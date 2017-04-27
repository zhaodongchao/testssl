package com.security.core.redis;

import org.apache.shiro.cache.Cache;
import org.apache.shiro.cache.CacheException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.CollectionUtils;

import java.util.*;

/**
 * 自定义的Cache类，用Redis实现shiro数据的缓存
 * Created by zhaodongchao on 2017/4/27.
 */
public class RedisCache<K,V> implements Cache<K, V> {
    private Logger logger = LoggerFactory.getLogger(this.getClass());
    /*
       操作redis数据库的公共类
     */
    private RedisManager redisManager ;
    private String cachePrefix = "shiro_cache_prefix:";

    public RedisCache(RedisManager redisManager) {
        if (null == redisManager){
            throw new IllegalArgumentException("redisManager argument cannot be null.");
        }else{
            this.redisManager = redisManager ;
        }
    }

    @Override
    public V get(K key) throws CacheException {
        logger.debug("根据key从Redis中获取对象 key [" + key + "]");
        return (V) redisManager.get(cachePrefix+key.toString());
    }

    @Override
    public V put(K key, V value) throws CacheException {
        logger.debug("根据key从存储 key [" + key + "]");
       redisManager.set(cachePrefix+key.toString(),redisManager.getBytesFromObj(value));
        return value ;
    }

    @Override
    public V remove(K key) throws CacheException {
        logger.debug("从redis中删除 key [" + key + "]");
        V value = (V) redisManager.get(cachePrefix+key.toString());
        redisManager.delete(key.toString());
        return value;
    }

    @Override
    public void clear() throws CacheException {
        logger.debug("从redis中删除所有元素");
        redisManager.flushDB();
    }

    @Override
    public int size() {
        return redisManager.keys(cachePrefix+"*").size();
    }

    @Override
    public Set<K> keys() {
        Collection<String> keys = redisManager.keys(cachePrefix+"*");
        if (CollectionUtils.isEmpty(keys)){
            return Collections.emptySet();
        }else {
            return Collections.unmodifiableSet((Set<? extends K>) keys);
        }
    }

    @Override
    public Collection<V> values() {
        Collection<String> keys = redisManager.keys(cachePrefix+"*");
        if (keys.isEmpty()){
            return Collections.emptyList();
        }
        List<V> values = new ArrayList<V>(keys.size());
        for (String key : keys){
            values.add(get((K) key));
        }
        return Collections.unmodifiableList(values);
    }

    public RedisManager getRedisManager() {
        return redisManager;
    }

    public void setRedisManager(RedisManager redisManager) {
        this.redisManager = redisManager;
    }

    public String getCachePrefix() {
        return cachePrefix;
    }

    public void setCachePrefix(String cachePrefix) {
        this.cachePrefix = cachePrefix;
    }
}
