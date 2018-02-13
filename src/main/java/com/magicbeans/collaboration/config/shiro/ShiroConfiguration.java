package com.magicbeans.collaboration.config.shiro;

import com.magicbeans.collaboration.entity.Resource;
import com.magicbeans.collaboration.service.IResourceService;
import org.apache.shiro.authc.credential.HashedCredentialsMatcher;
import org.apache.shiro.authc.pam.AuthenticationStrategy;
import org.apache.shiro.authc.pam.FirstSuccessfulStrategy;
import org.apache.shiro.authz.ModularRealmAuthorizer;
import org.apache.shiro.mgt.SecurityManager;
import org.apache.shiro.realm.Realm;
import org.apache.shiro.spring.LifecycleBeanPostProcessor;
import org.apache.shiro.spring.security.interceptor.AuthorizationAttributeSourceAdvisor;
import org.apache.shiro.spring.web.ShiroFilterFactoryBean;
import org.apache.shiro.web.mgt.DefaultWebSecurityManager;
import org.apache.shiro.web.session.mgt.DefaultWebSessionManager;
import org.springframework.aop.framework.autoproxy.DefaultAdvisorAutoProxyCreator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.DependsOn;
import org.springframework.util.StringUtils;

import javax.servlet.Filter;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Configuration
public class ShiroConfiguration {

    @Autowired
    private IResourceService menuService;

    @Autowired
    private RedisSessionDAO redisSessionDAO;


    @Bean("lifecycleBeanPostProcessor")
    public static LifecycleBeanPostProcessor getLifecycleBeanPostProcessor() {
        return new LifecycleBeanPostProcessor();
    }

    /**
     * ShiroFilterFactoryBean 处理拦截资源文件问题。
     * 注意：单独一个ShiroFilterFactoryBean配置是或报错的，因为在
     * 初始化ShiroFilterFactoryBean的时候需要注入：SecurityManager
     *
     Filter Chain定义说明
     1、一个URL可以配置多个Filter，使用逗号分隔
     2、当设置多个过滤器时，全部验证通过，才视为通过
     3、部分过滤器可指定参数，如perms，roles
     *
     */
    @Bean
    public ShiroFilterFactoryBean shirFilter(SecurityManager securityManager){
        ShiroFilterFactoryBean shiroFilterFactoryBean  = new ShiroFilterFactoryBean();

        // 必须设置 SecurityManager
        shiroFilterFactoryBean.setSecurityManager(securityManager);
        // 如果不设置默认会自动寻找Web工程根目录下的"/login.jsp"页面
        Map<String, Filter> filters = new HashMap<String, Filter>();
        filters.put("admin", new AdminFormAuthenticationFilter());
        shiroFilterFactoryBean.setFilters(filters);

        //拦截器.
        Map<String,String> filterChainDefinitionMap = new LinkedHashMap<String,String>();
        //配置退出 过滤器,其中的具体的退出代码Shiro已经替我们实现了
        filterChainDefinitionMap.put("/assets/**","anon");
        filterChainDefinitionMap.put("/**/favicon.ico","anon");
        filterChainDefinitionMap.put("/logout", "logout");
        filterChainDefinitionMap.put("/druid/**","anon");
        filterChainDefinitionMap.put("/**","admin");
//
        List<Resource> menuList =  menuService.selectAll();
        for (Resource menu : menuList){
            if(!StringUtils.isEmpty(menu.getUrl())&& !StringUtils.isEmpty(menu.getCode())){
                String permission = "authc,perms[" + menu.getCode()+ "]";
                filterChainDefinitionMap.put(menu.getUrl(),permission);
            }
        }
        shiroFilterFactoryBean.setFilterChainDefinitionMap(filterChainDefinitionMap);
        return shiroFilterFactoryBean;
    }


    @Bean
    public SecurityManager securityManager(){
        DefaultWebSecurityManager securityManager =  new DefaultWebSecurityManager();

        Map<String, Realm> shiroAuthenticatorRealms = new HashMap<>();
        shiroAuthenticatorRealms.put(LoginType.ADMIN.getType(), dBShiroRealm());

        CustomModularRealmAuthenticator customModularRealmAuthenticator = new CustomModularRealmAuthenticator();
        customModularRealmAuthenticator.setDefinedRealms(shiroAuthenticatorRealms);
        customModularRealmAuthenticator.setAuthenticationStrategy(authenticationStrategy());
        securityManager.setAuthenticator(customModularRealmAuthenticator);


        ModularRealmAuthorizer customModularRealmAuthorizer = new ModularRealmAuthorizer();
        customModularRealmAuthorizer.setRealms(shiroAuthenticatorRealms.values());
        securityManager.setAuthorizer(customModularRealmAuthorizer);

//        securityManager.setSessionManager(sessionManager());
        securityManager.setCacheManager(shiroRedisCacheManager());
        return securityManager;
    }

    @Bean
    public DBShiroRealm dBShiroRealm(){
        DBShiroRealm dbShiroRealm = new DBShiroRealm();
        dbShiroRealm.setCredentialsMatcher(hashedCredentialsMatcher());
        dbShiroRealm.setCacheManager(shiroRedisCacheManager());
        dbShiroRealm.setCachingEnabled(true);
        return dbShiroRealm;
    }

    /**
     * Shiro默认提供了三种 AuthenticationStrategy 实现：
     * AtLeastOneSuccessfulStrategy ：其中一个通过则成功。
     * FirstSuccessfulStrategy ：其中一个通过则成功，但只返回第一个通过的Realm提供的验证信息。
     * AllSuccessfulStrategy ：凡是配置到应用中的Realm都必须全部通过。
     * authenticationStrategy
     * @return
     */
    @Bean(name="authenticationStrategy")
    public AuthenticationStrategy authenticationStrategy() {
        System.out.println("ShiroConfiguration.authenticationStrategy()");
        return new FirstSuccessfulStrategy();
    }

    /**
     * 凭证匹配器
     * （由于我们的密码校验交给Shiro的SimpleAuthenticationInfo进行处理了
     *  所以我们需要修改下doGetAuthenticationInfo中的代码;
     * ）
     * @return
     */
    @Bean
    public HashedCredentialsMatcher hashedCredentialsMatcher(){
        HashedCredentialsMatcher hashedCredentialsMatcher = new HashedCredentialsMatcher();
        //散列算法:这里使用MD5算法;
        hashedCredentialsMatcher.setHashAlgorithmName("md5");
        //散列的次数，比如散列两次，相当于 md5(md5(""));
        hashedCredentialsMatcher.setHashIterations(1);
        return hashedCredentialsMatcher;
    }


    /**
     *  开启shiro aop注解支持.
     *  使用代理方式;所以需要开启代码支持;
     * @param securityManager
     * @return
     */
    @Bean
    public AuthorizationAttributeSourceAdvisor authorizationAttributeSourceAdvisor(SecurityManager securityManager){
        AuthorizationAttributeSourceAdvisor authorizationAttributeSourceAdvisor = new AuthorizationAttributeSourceAdvisor();
        authorizationAttributeSourceAdvisor.setSecurityManager(securityManager);
        return authorizationAttributeSourceAdvisor;
    }


    @Bean
    @ConditionalOnMissingBean
    public DefaultAdvisorAutoProxyCreator defaultAdvisorAutoProxyCreator() {
        DefaultAdvisorAutoProxyCreator defaultAdvisorAutoProxyCreator = new DefaultAdvisorAutoProxyCreator();
        defaultAdvisorAutoProxyCreator.setProxyTargetClass(true);
        return defaultAdvisorAutoProxyCreator;
    }

    @Bean
    @DependsOn("lifecycleBeanPostProcessor")
    public ShiroRedisCacheManager shiroRedisCacheManager(){
        return  new ShiroRedisCacheManager();
    }


    /**
     * shiro session的管理
     */
    @Bean("sessionManager")
    public DefaultWebSessionManager sessionManager() {
        DefaultWebSessionManager sessionManager = new DefaultWebSessionManager();
//        sessionManager.setSessionDAO(redisSessionDAO);
        sessionManager.setGlobalSessionTimeout(1800000*2);
//        sessionManager.setCacheManager(shiroRedisCacheManager());
        return sessionManager;
    }


}
