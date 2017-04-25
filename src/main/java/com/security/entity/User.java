package com.security.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.google.common.collect.ImmutableList;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.builder.EqualsBuilder;
import org.apache.commons.lang3.builder.HashCodeBuilder;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.hibernate.validator.constraints.NotBlank;

import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Set;

/**
 * Created by zhaodongchao on 2017/3/19.
 */
@Entity
@Table(name = "CF_USER")
public class User {
    @Id
   /* @GeneratedValue(strategy = GenerationType.SEQUENCE,generator = "userIdSquence")
    @SequenceGenerator(name = "userIdSquence",sequenceName = "user_id_squ")*/
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private String userId;
    @NotBlank
    private String loginName;

    private String loginPassword;

    private String passwordSalt;
    @NotBlank
    private String realName;

    private String selfdeclare;

    private String city;

    private String address;

    private Short age;

    private Short sex;

    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+08:00")
    private Date birthday;

    private String telphone;

    private String email;
    @NotBlank
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
    private Date createTime;
    @NotBlank
    private BigDecimal loginCount;
    @NotBlank
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
    private Date lastLoginTime;

    private Short isLock;

    private Short isExpired;

    private BigDecimal expiredTime;

    /*
      存放用户所拥有的角色的代号code的集合
      不持久化到数据库，也不显示在Restful接口的属性.
     */
    @Transient
    @JsonIgnore
    private List<String> roleCodes ;
    /*
      存放用户拥有的角色的对象的集合
      多对多关联fetch不能设置为懒加载
     */

    @ManyToMany(cascade = CascadeType.ALL,fetch = FetchType.EAGER)
    @JoinTable(name = "CF_USER_ROLE",
               joinColumns = {@JoinColumn(name = "USER_ID",referencedColumnName = "userId")},
               inverseJoinColumns = {@JoinColumn(name = "ROLE_ID",referencedColumnName = "roleId")})
    private Set<Role> roles ;

    private static final long serialVersionUID = 1L;

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getLoginName() {
        return loginName;
    }

    public void setLoginName(String loginName) {
        this.loginName = loginName;
    }

    public String getLoginPassword() {
        return loginPassword;
    }

    public void setLoginPassword(String loginPassword) {
        this.loginPassword = loginPassword;
    }

    public String getPasswordSalt() {
        return passwordSalt;
    }

    public void setPasswordSalt(String passwordSalt) {
        this.passwordSalt = passwordSalt;
    }

    public String getRealName() {
        return realName;
    }

    public void setRealName(String realName) {
        this.realName = realName;
    }

    public String getSelfdeclare() {
        return selfdeclare;
    }

    public void setSelfdeclare(String selfdeclare) {
        this.selfdeclare = selfdeclare;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Short getAge() {
        return age;
    }

    public void setAge(Short age) {
        this.age = age;
    }

    public Short getSex() {
        return sex;
    }

    public void setSex(Short sex) {
        this.sex = sex;
    }

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    public String getTelphone() {
        return telphone;
    }

    public void setTelphone(String telphone) {
        this.telphone = telphone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public BigDecimal getLoginCount() {
        return loginCount;
    }

    public void setLoginCount(BigDecimal loginCount) {
        this.loginCount = loginCount;
    }

    public Date getLastLoginTime() {
        return lastLoginTime;
    }

    public void setLastLoginTime(Date lastLoginTime) {
        this.lastLoginTime = lastLoginTime;
    }

    public Short getIsLock() {
        return isLock;
    }

    public void setIsLock(Short isLock) {
        this.isLock = isLock;
    }

    public Short getIsExpired() {
        return isExpired;
    }

    public void setIsExpired(Short isExpired) {
        this.isExpired = isExpired;
    }

    public BigDecimal getExpiredTime() {
        return expiredTime;
    }

    public void setExpiredTime(BigDecimal expiredTime) {
        this.expiredTime = expiredTime;
    }

    public Set<Role> getRoles() {
        return roles;
    }

    public void setRoles(Set<Role> roles) {
        this.roles = roles;
    }

    public List<String> getRoleCodes() {
        return roleCodes;
    }

    public void setRoleCodes(List<String> roleCodes) {
        this.roleCodes = roleCodes;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;

        if (o == null || getClass() != o.getClass()) return false;

        User user = (User) o;

        return new EqualsBuilder()
                .append(userId, user.userId)
                .isEquals();
    }

    @Override
    public int hashCode() {
        return new HashCodeBuilder(17, 37)
                .append(userId)
                .toHashCode();
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this)
                .append("userId", userId)
                .append("loginName", loginName)
                .append("loginPassword", loginPassword)
                .append("passwordSalt", passwordSalt)
                .append("realName", realName)
                .append("selfdeclare", selfdeclare)
                .append("city", city)
                .append("address", address)
                .append("age", age)
                .append("sex", sex)
                .append("birthday", birthday)
                .append("telphone", telphone)
                .append("email", email)
                .append("createTime", createTime)
                .append("loginCount", loginCount)
                .append("lastLoginTime", lastLoginTime)
                .append("isLock", isLock)
                .append("isExpired", isExpired)
                .append("expiredTime", expiredTime)
                .append("roleCodes", roleCodes)
                .toString();
    }
}
