package com.security.services;

import com.security.dao.UserDao;
import com.security.entity.Role;
import com.security.entity.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.dao.DataAccessException;
import org.springframework.data.redis.connection.RedisConnection;
import org.springframework.data.redis.core.RedisCallback;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.serializer.RedisSerializer;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

/**
 * Created by zhaodongchao on 2017/3/19.
 */
@Component
@Transactional(readOnly = true)
public class AccountService {
    private static Logger logger = LoggerFactory.getLogger(AccountService.class);

    @Autowired
    private UserDao userDao;

    @Autowired
    @Qualifier("redisTemplate")
    private RedisTemplate<String,String> redisTemplate;


    public List<User> getAllUser() {
        List<User> users = (List<User>) userDao.findAll();
        for (int i = 0; i < users.size(); i++) {
            toFromatUser(users.get(i));
        }
        return users;
    }
    public List<Map<String,Object>> findAllUser(){
        List<User> users = this.getAllUser();
        if (users.isEmpty()){
            return null ;
        }
        List<Map<String,Object>> mapList = new ArrayList<Map<String,Object>>();
        for (int i = 0; i < users.size() ; i++) {
            mapList.add(parseUser2Map(users.get(i)));
        }
        return mapList ;
    }

    public List<String> findLoginName(String term){
        return userDao.queryLoginName(term);
    }
    public User findUserByLoginName(String loginName) {
        return fromatUser(userDao.findByLoginName(loginName) );
    }

    /**
     * 将Roles中的角色编号存入User对象的roleCodes
     * 去掉User对象中的Roles集合
     * @param user
     * @return user
     */
    private User fromatUser(User user){
        if(null == user){
            return null ;
        }
        Set<Role> roles = user.getRoles();
        List<String> roleCodes = new ArrayList<String>();
        for (Role role : roles){
            roleCodes.add(role.getRoleCode());
        }
        user.setRoleCodes(roleCodes);
        user.setRoles(null);
        return user ;
    }
    private void toFromatUser(User user){
        if(null == user){
            return ;
        }
        Set<Role> roles = user.getRoles();
        List<String> roleCodes = new ArrayList<String>();
        for (Role role : roles){
            roleCodes.add(role.getRoleCode());
        }
        user.setRoleCodes(roleCodes);
        user.setRoles(null);
    }
    private Map<String,Object> parseUser2Map(User user){
        if(null == user) {
            return null ;
        }
        Map<String,Object> mp = new HashMap();
        mp.put("loginName",user.getLoginName());
        mp.put("realName",user.getRealName());
        mp.put("sex",user.getSex());
        mp.put("age",user.getAge());
        mp.put("birthday",user.getBirthday());
        mp.put("telphone",user.getTelphone());
        mp.put("email",user.getEmail());
        mp.put("createTime",user.getCreateTime());
        mp.put("loginCount",user.getLoginCount());
        mp.put("isLock",user.getIsLock());
        mp.put("expiredTime",user.getExpiredTime());
        mp.put("lastLoginTime",user.getLastLoginTime());

        return mp ;
    }
}
