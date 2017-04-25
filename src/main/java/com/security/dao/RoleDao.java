package com.security.dao;

import com.security.entity.Role;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by zhaodongchao on 2017/3/22.
 */
public interface RoleDao extends PagingAndSortingRepository<Role,String> {

}
