package com.magicbeans.collaboration.config.shiro;

import org.apache.shiro.cache.Cache;
import org.apache.shiro.cache.CacheException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.redis.core.RedisTemplate;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Set;
import java.util.concurrent.TimeUnit;

public class ShiroCache<K, V> implements Cache<K, V> {
    private Logger logger = LoggerFactory.getLogger(getClass());

    private static final String REDIS_SHIRO_CACHE = "magic-shiro-cache:";
    private String cacheKey;
    private RedisTemplate<K, V> redisTemplate;
    private long globExpire = 30;

    @SuppressWarnings("rawtypes")
    public ShiroCache(String name, RedisTemplate client) {
        this.cacheKey =  REDIS_SHIRO_CACHE+name + ":";
        this.redisTemplate = client;
    }

    @Override
    public V get(K key) throws CacheException {
        logger.debug("Shiro从缓存中获取数据KEY值["+key+"]");
        return redisTemplate.boundValueOps(getCacheKey(key)).get();
    }

    @Override
    public V put(K key, V value) throws CacheException {
        logger.debug("Shiro更新缓存数据KEY值["+key+"]");
        V old = get(key);
        redisTemplate.boundValueOps(getCacheKey(key)).set(value,globExpire,TimeUnit.MINUTES);
        return old;
    }

    @Override
    public V remove(K key) throws CacheException {
        V old = get(key);
        redisTemplate.delete(getCacheKey(key));
        return old;
    }

    @Override
    public void clear() throws CacheException {
        redisTemplate.delete(keys());
    }

    @Override
    public int size() {
        return keys().size();
    }

    @Override
    public Set<K> keys() {
        return redisTemplate.keys(getCacheKey("*"));
    }

    @Override
    public Collection<V> values() {
        Set<K> set = keys();
        List<V> list = new ArrayList<>();
        for (K s : set) {
            list.add(get(s));
        }
        return list;
    }

    private K getCacheKey(Object k) {
        return (K) (this.cacheKey + k);
    }
}
