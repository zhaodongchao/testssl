package com.security.core.redis;

import org.springframework.dao.DataAccessException;
import org.springframework.data.redis.connection.RedisConnection;
import org.springframework.data.redis.core.RedisCallback;
import org.springframework.data.redis.core.RedisTemplate;

import java.io.*;
import java.util.Collection;

/**
 * Created by zhaodongchao on 2017/4/18.
 */
public class RedisManager {
    private RedisTemplate<String, Serializable> redisTemplate;

    /**
     * 根据key删除记录
     *
     * @param key key值
     */
    public void delete(String key) {
        redisTemplate.delete(key);
    }

    /**
     * @param pattern 匹配字符串
     * @return 所有数据库key中包含pattern的key的集合
     */
    public Collection<String> keys(String pattern) {
        return redisTemplate.keys(pattern);
    }

    /**
     * @param key 键
     * @return 还回key对应的value
     */
    public Serializable get(String key) {
        return redisTemplate.opsForValue().get(key);
    }

    /**
     * 保存数据
     *
     * @param key   键
     * @param value 值
     */
    public void set(String key, Serializable value) {
        if (value == null) {
            return;
        }
        redisTemplate.opsForValue().set(key, value);
    }

    public void setEX(String key, Serializable value, Long timeout) {
        if (value == null) {
            return;
        }

        if (timeout != null) {
            redisTemplate.opsForValue().set(key, value, timeout);
        } else {
            redisTemplate.opsForValue().set(key, value);
        }
    }

    /**
     * 清空数据库
      */
    public void flushDB() {
        redisTemplate.execute(new RedisCallback<Boolean>() {
            @Override
            public Boolean doInRedis(RedisConnection redisConnection) throws DataAccessException {
                redisConnection.flushDb();
                return true;
            }
        });

    }

    public RedisTemplate<String, Serializable> getRedisTemplate() {
        return redisTemplate;
    }

    public void setRedisTemplate(RedisTemplate<String, Serializable> redisTemplate) {
        this.redisTemplate = redisTemplate;
    }

    public Object readObjFromBytes(byte[] bytes) throws IOException, ClassNotFoundException {
        Object result = null;
        try {
            ByteArrayInputStream byteArrayInputStream = new ByteArrayInputStream(bytes);
            ObjectInputStream objectInputStream = new ObjectInputStream(byteArrayInputStream);
            result = objectInputStream.readObject();
            objectInputStream.close();
            byteArrayInputStream.close();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        return result;
    }

    public byte[] getBytesFromObj(Object obj) {
        byte[] bytes = null;
        try {
            ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
            ObjectOutputStream objectOutputStream = new ObjectOutputStream(byteArrayOutputStream);
            objectOutputStream.writeObject(obj);
            bytes = byteArrayOutputStream.toByteArray();
            objectOutputStream.close();
            byteArrayOutputStream.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

        return bytes;
    }
}
