package com.security.core.redis;

import org.apache.shiro.cache.Cache;
import org.apache.shiro.cache.CacheException;
import org.apache.shiro.cache.CacheManager;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;

/**
 * Created by zhaodongchao on 2017/4/27.
 */
public class RedisCacheManager implements CacheManager{
    private static final Logger log = LoggerFactory.getLogger(RedisCacheManager.class);
    private RedisManager redisManager ;
    private final ConcurrentMap<String, Cache> caches = new ConcurrentHashMap<String, Cache>();
    /**
     * The Redis key prefix for caches
     */
    private String keyPrefix = "shiro_redis_cache:";
    @Override
    public <K, V> Cache<K, V> getCache(String name) throws CacheException {
        Cache c = caches.get(name);
        if (c == null) {
            // create a new cache instance
          //TODO use redis implemented
            c = new RedisCache<K,V>(redisManager);
            // add it to the cache collection
            caches.put(name, c);
        }
        return c;
    }

    public RedisManager getRedisManager() {
        return redisManager;
    }

    public void setRedisManager(RedisManager redisManager) {
        this.redisManager = redisManager;
    }
}
