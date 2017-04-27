package com.security.core.redis;

import org.apache.shiro.session.Session;
import org.apache.shiro.session.UnknownSessionException;
import org.apache.shiro.session.mgt.eis.AbstractSessionDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


import java.io.*;
import java.util.Collection;

/**
 * Created by zhaodongchao on 2017/4/12.
 */
public class SessionRedisDao extends AbstractSessionDAO {
    private static Logger logger = LoggerFactory.getLogger(SessionRedisDao.class);
    /**
     * Spring提供的redis数据库操作工具类
     */
    private RedisManager redisManager ;

    private String shiro_session_prefix = "shiro_session_prefix:";
    @Override
    protected Serializable doCreate(Session session) {
        Serializable sessionId = this.generateSessionId(session);
        assignSessionId(session,sessionId);
        try {
            this.saveSession(session);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return sessionId;
    }

    @Override
    protected Session doReadSession(Serializable sessionId) {
        if(sessionId == null){
            logger.error("session id is null");
            return null;
        }
        Session session = (Session) redisManager.get(shiro_session_prefix+sessionId.toString());
        return session;
    }

    @Override
    public void update(Session session) throws UnknownSessionException {
        redisManager.set(shiro_session_prefix+session.getId().toString(), (Serializable) session);
    }

    @Override
    public void delete(Session session) {
        if(session == null || session.getId() == null){
            logger.error("session or session id is null");
            return;
        }
        redisManager.delete(shiro_session_prefix+session.getId().toString());
    }

    @Override
    public Collection<Session> getActiveSessions() {
        return null;
    }
    private void saveSession(Session session) throws UnknownSessionException, IOException {
           redisManager.set(shiro_session_prefix+session.getId().toString(),redisManager.getBytesFromObj(session));
    }


    public RedisManager getRedisManager() {
        return redisManager;
    }

    public void setRedisManager(RedisManager redisManager) {
        this.redisManager = redisManager;
    }
}
