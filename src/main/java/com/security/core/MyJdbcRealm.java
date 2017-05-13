package com.security.core;


import com.security.entity.Module;
import com.security.entity.User;
import com.security.services.AccountService;
import org.apache.commons.lang3.builder.EqualsBuilder;
import org.apache.commons.lang3.builder.HashCodeBuilder;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationException;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * Created by zhaodongchao on 2017/3/18.
 */
public class MyJdbcRealm extends AuthorizingRealm {
    protected AccountService accountService;
    /**
     * 授权查询回调函数, 进行鉴权但缓存中无用户的授权信息时调用.
     */
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        if (principals == null) {
            throw new AuthorizationException("PrincipalCollection method argument cannot be null.");
        }
        ShiroUser shiroUser = (ShiroUser) principals.getPrimaryPrincipal();
        User user = accountService.findUserByLoginName(shiroUser.getLoginName());
        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
        info.addRoles(user.getRoleCodes());
        return info;
    }
    /**
     * 认证回调函数,登录时调用.
     */
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        UsernamePasswordToken usernamePasswordToken = (UsernamePasswordToken) token ;
        User user =accountService.findUserByLoginName(usernamePasswordToken.getUsername());
        if (null != user){
            return  new SimpleAuthenticationInfo(parseUser2ShiroUser(user),user.getLoginPassword(), getName());
        }
        return null;
    }
    @Autowired
    public void setAccountService(AccountService accountService) {
        this.accountService = accountService;
    }

    private ShiroUser parseUser2ShiroUser(User user){
        if (null == user){
            return null ;
        }
        ShiroUser shiroUser = new ShiroUser();
        shiroUser.setId(user.getUserId());
        shiroUser.setLoginName(user.getLoginName());
        shiroUser.setRealName(user.getRealName());
        shiroUser.setAge(user.getAge());
        String sex = "" ;
        if(null != user.getSex() ) {
            sex = user.getSex() == 1 ? "男" : "女" ;
        }
        shiroUser.setSex(sex);
        shiroUser.setBirthday(user.getBirthday());
        shiroUser.setEmail(user.getEmail());
        shiroUser.setTelphone(user.getTelphone());
        shiroUser.setRoles(user.getRoleCodes());
        //TODO 添加用户有权限菜单
        return shiroUser ;
    }
    /**
     * 自定义Authentication对象，使得Subject除了携带用户的登录名外还可以携带更多信息.
     */
    public static class ShiroUser implements Serializable {
        private static final long serialVersionUID = -1373760761780840081L;
        public String id;
        public String loginName;
        public String realName;
        public Short age ;
        public String sex ;
        public Date birthday ;
        public String email ;
        public String telphone ;
        public List<String> roles ;
        public List<Module> modules; //存放当前登录用户的有权限的菜单模块

        public ShiroUser() {
        }

        public ShiroUser(String id, String loginName, String realName) {
            this.id = id;
            this.loginName = loginName;
            this.realName = realName;
        }

        public ShiroUser(String id, String loginName, String realName, Short age, String sex, Date birthday, String email, String telphone) {
            this.id = id;
            this.loginName = loginName;
            this.realName = realName;
            this.age = age;
            this.sex = sex;
            this.birthday = birthday;
            this.email = email;
            this.telphone = telphone;
        }

        public ShiroUser(String id, String loginName, String realName, Short age, String sex, Date birthday, String email, String telphone, List<Module> modules) {
            this.id = id;
            this.loginName = loginName;
            this.realName = realName;
            this.age = age;
            this.sex = sex;
            this.birthday = birthday;
            this.email = email;
            this.telphone = telphone;
            this.modules = modules;
        }

        @Override
        public String toString() {
            return new ToStringBuilder(this)
                    .append("id", id)
                    .append("loginName", loginName)
                    .append("realName", realName)
                    .append("age", age)
                    .append("sex", sex)
                    .append("birthday", birthday)
                    .append("email", email)
                    .append("telphone", telphone)
                    .append("roles", roles)
                    .toString();
        }

        /**
         * 本函数输出将作为默认的<shiro:principal/>输出.
         */


        @Override
        public boolean equals(Object o) {
            if (this == o) return true;

            if (o == null || getClass() != o.getClass()) return false;

            ShiroUser shiroUser = (ShiroUser) o;

            return new EqualsBuilder()
                    .append(id, shiroUser.id)
                    .append(loginName, shiroUser.loginName)
                    .append(realName, shiroUser.realName)
                    .isEquals();
        }

        @Override
        public int hashCode() {
            return new HashCodeBuilder(17, 37)
                    .append(id)
                    .append(loginName)
                    .append(realName)
                    .toHashCode();
        }

        public String getId() {
            return id;
        }

        public void setId(String id) {
            this.id = id;
        }

        public String getLoginName() {
            return loginName;
        }

        public void setLoginName(String loginName) {
            this.loginName = loginName;
        }

        public String getRealName() {
            return realName;
        }

        public void setRealName(String realName) {
            this.realName = realName;
        }

        public Short getAge() {
            return age;
        }

        public void setAge(Short age) {
            this.age = age;
        }

        public String getSex() {
            return sex;
        }

        public void setSex(String sex) {
            this.sex = sex;
        }

        public Date getBirthday() {
            return birthday;
        }

        public void setBirthday(Date birthday) {
            this.birthday = birthday;
        }

        public String getEmail() {
            return email;
        }

        public void setEmail(String email) {
            this.email = email;
        }

        public String getTelphone() {
            return telphone;
        }

        public void setTelphone(String telphone) {
            this.telphone = telphone;
        }

        public List<Module> getModules() {
            return modules;
        }

        public void setModules(List<Module> modules) {
            this.modules = modules;
        }

        public List<String> getRoles() {
            return roles;
        }

        public void setRoles(List<String> roles) {
            this.roles = roles;
        }
    }
}
