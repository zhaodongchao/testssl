package com.security.dao;


import com.security.entity.Menu;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;


public interface MenuDao extends JpaRepository<Menu, String> {
     String sql_query_permission = " select  cm.menu_id,cm.menu_name,cm.menu_code,cm.menu_type,cm.uri,cm.leaf,cm.parent_id " +
                            "                from scott.cf_menu cm " +
                            "                inner join scott.cf_authority ca on ca.operation_uri = cm.menu_code " +
                            "                where cm.menu_id=?1 " +
                            "                and  cm.leaf = 1   " + //权限只针对叶子菜单
                            "                and  ca.authority_id in ( select cra.authority_id from scott.cf_role_authority cra " +
                            "                                                                   where cra.role_id in (select cur.role_id from scott.cf_user_role cur where cur.user_id=?2 )) ";
    String sql_query_child_menu = "  select  cm.menu_id,cm.menu_name,cm.menu_code,cm.menu_type,cm.uri,cm.leaf,cm.parent_id " +
                            "                from scott.cf_menu cm " +
                            "                inner join scott.cf_authority ca on ca.operation_uri = cm.menu_code " +
                            "                where cm.parent_id=?1 " +
                            "                and  ca.authority_id in ( select cra.authority_id from scott.cf_role_authority cra " +
                            "                                                                   where cra.role_id in (select cur.role_id from scott.cf_user_role cur where cur.user_id=?2 )) ";
    @Query(value = sql_query_permission,nativeQuery = true)
    Menu findMenuByMenuIdAndUserId(String menuId,String userId);

    @Query(value = sql_query_child_menu,nativeQuery = true)
    List<Menu> findAllByParentIdAndUserId(String parentId,String userId);

    List<Menu> findAllByParentId(String parentId);

}