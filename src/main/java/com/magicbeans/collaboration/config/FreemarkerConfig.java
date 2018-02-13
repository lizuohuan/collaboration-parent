package com.magicbeans.collaboration.config;

import com.jagregory.shiro.freemarker.ShiroTags;
import com.magicbeans.collaboration.common.freemarker.directive.FlashMessageDirective;
import com.magicbeans.collaboration.common.freemarker.directive.PaginationDirective;
import freemarker.template.Configuration;
import freemarker.template.TemplateException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.freemarker.FreeMarkerProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.ui.freemarker.FreeMarkerConfigurationFactory;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * @author :Jason
 * @date ：2017/8/30 0030
 * @description
 **/
@org.springframework.context.annotation.Configuration
public class FreemarkerConfig {

    @Autowired
    private FreeMarkerProperties freeMarkerProperties;

    @Bean
    public FreeMarkerConfigurer freemarkerConfigurer() throws IOException, TemplateException {
        FreeMarkerConfigurationFactory factory = new FreeMarkerConfigurationFactory();
        factory.setTemplateLoaderPaths(freeMarkerProperties.getTemplateLoaderPath());
        factory.setDefaultEncoding("UTF-8");
        Configuration configuration = factory.createConfiguration();
        configuration.setSetting("tag_syntax","auto_detect");
        configuration.setSetting("datetime_format","yyyy-MM-dd HH:mm:ss");
        configuration.setSetting("date_format","yyyy-MM-dd");
        configuration.setSetting("time_format","HH:mm:ss");
//        configuration.setSetting("classic_compatible", "true");
        configuration.setSetting("whitespace_stripping", "true");
        configuration.setSetting("locale", "zh_CN");
        configuration.setSetting("url_escaping_charset", "UTF-8");
        configuration.setSetting("defaultEncoding", "UTF-8");
        configuration.setSetting("boolean_format", "true,false");
        configuration.setSetting("object_wrapper", "freemarker.ext.beans.BeansWrapper");

        configuration.setSharedVaribles(loadFreemarkDirective());
        configuration.setSharedVariable("shiro",new ShiroTags());
        configuration.setNumberFormat("#");

        FreeMarkerConfigurer freeMarkerConfigurer = new FreeMarkerConfigurer();
        freeMarkerConfigurer.setConfiguration(configuration);
        return freeMarkerConfigurer;
    }

    /**
     * 加载freemark 自定义标签解析器
     *
     * @return
     */
    private Map<String, Object> loadFreemarkDirective() {
        Map<String, Object> directiives = new HashMap<>();
        directiives.put("pagination", new PaginationDirective());
        directiives.put("flash_message", new FlashMessageDirective());
        return directiives;
    }
}
