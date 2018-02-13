package com.magicbeans.collaboration;

import com.magicbeans.collaboration.redis.JdkRedisTemplate;
import com.magicbeans.collaboration.redis.ObjectRedisTemplate;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.context.embedded.EmbeddedServletContainerCustomizer;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.boot.web.servlet.ErrorPage;
import org.springframework.boot.web.support.SpringBootServletInitializer;
import org.springframework.context.ApplicationListener;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.http.HttpStatus;
import org.springframework.transaction.annotation.EnableTransactionManagement;

/**
 * @author :Jason
 * @date ：2017/8/28 0028
 * @description
 **/
@SpringBootApplication
@EnableTransactionManagement
@ComponentScan
public class AdminTemplateApplication extends SpringBootServletInitializer implements  ApplicationListener<ApplicationReadyEvent> {


    /**
     * 进行数据初始化
     * @param event
     */
    @Override
    public void onApplicationEvent(ApplicationReadyEvent event) {

    }


    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
        builder.sources(AdminTemplateApplication.class);
        return builder;
    }

    public static void main(String[] args) {
        SpringApplication.run(AdminTemplateApplication.class,args);
    }



    @Bean
    public ObjectRedisTemplate objectRedisTemplate(RedisConnectionFactory redisConnectionFactory){
        return  new ObjectRedisTemplate(redisConnectionFactory);
    }

    @Bean
    public JdkRedisTemplate redisTemplate(RedisConnectionFactory factory) {
        return new JdkRedisTemplate(factory);
    }


    @Bean
    public EmbeddedServletContainerCustomizer containerCustomizer() {

        return (container -> {
            ErrorPage error401Page = new ErrorPage(HttpStatus.UNAUTHORIZED, "/error/401.html");
            ErrorPage error404Page = new ErrorPage(HttpStatus.NOT_FOUND, "/error/404.html");
            ErrorPage error500Page = new ErrorPage(HttpStatus.INTERNAL_SERVER_ERROR, "/error/500.html");
            container.addErrorPages(error401Page, error404Page, error500Page);
        });
    }

}
