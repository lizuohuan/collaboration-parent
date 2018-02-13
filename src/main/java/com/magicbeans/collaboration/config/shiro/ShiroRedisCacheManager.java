package com.magicbeans.collaboration.config.shiro;


import com.magicbeans.collaboration.redis.JdkRedisTemplate;
import org.apache.shiro.cache.Cache;
import org.apache.shiro.cache.CacheException;
import org.apache.shiro.cache.CacheManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;

import javax.annotation.Resource;

public class ShiroRedisCacheManager implements CacheManager {

    @Autowired
    private JdkRedisTemplate redisTemplate;

    @Override
    public <K, V> Cache<K, V> getCache(String name) throws CacheException {
        return new ShiroCache<K, V>(name, redisTemplate);
    }

    public JdkRedisTemplate getRedisTemplate() {
        return redisTemplate;
    }

    public void setRedisTemplate(JdkRedisTemplate redisTemplate) {
        this.redisTemplate = redisTemplate;
    }
}