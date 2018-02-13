package com.magicbeans.collaboration.config.shiro;

import com.magicbeans.collaboration.entity.Admin;
import com.magicbeans.collaboration.service.IAdminService;
import com.magicbeans.collaboration.service.IResourceService;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

public class DBShiroRealm extends AuthorizingRealm {

    @Autowired
    private IAdminService adminService;

    @Autowired
    private IResourceService menuService;


    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        SimpleAuthorizationInfo authorizationInfo = new SimpleAuthorizationInfo();
        Principal admin = (Principal) principals.getPrimaryPrincipal();
        Set<String> menus = menuService.findMenuCodeByUserId(admin.getId());
        authorizationInfo.addStringPermissions( menus.stream().filter((item)-> !StringUtils.isEmpty(item)).collect(Collectors.toList()));
        return authorizationInfo;
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        String username = (String)token.getPrincipal();
        //通过username从数据库中查找 User对象，如果找到，没找到.
        //实际项目中，这里可以根据实际情况做缓存，如果不做，Shiro自己也是有时间间隔机制，2分钟内不会重复执行该方法
        Admin userInfo = adminService.findByUsername(username);
        if(userInfo == null){
            throw new UnknownAccountException();
        }
        if(userInfo.getEnable()) {
            //帐号锁定
            throw new LockedAccountException();
        }
        SimpleAuthenticationInfo authenticationInfo = new SimpleAuthenticationInfo(
                new Principal(userInfo.getId(),userInfo.getUsername()),
                userInfo.getPassword(),
                ByteSource.Util.bytes(userInfo.getSalt()),
                userInfo.getUsername()
        );

        return authenticationInfo;

    }

}
