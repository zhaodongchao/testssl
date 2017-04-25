package com.security.dao;

import com.security.entity.User;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;

/**
 * Created by zhaodongchao on 2017/3/19.
 */
public interface UserDao extends PagingAndSortingRepository<User, String> {
    User findByLoginName(String loginName);

    @Query(value = "select LOGIN_NAME from scott.CF_USER cu WHERE cu.login_name LIKE '%'||:term||'%' ",nativeQuery = true)
    List<String> queryLoginName(@Param("term") String term);
}
