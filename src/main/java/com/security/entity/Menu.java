package com.security.entity;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonIgnore;
import org.apache.commons.lang3.builder.EqualsBuilder;
import org.apache.commons.lang3.builder.HashCodeBuilder;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.hibernate.validator.constraints.NotEmpty;

/**
 * @author zhaodongchao
 */
@Entity
@Table(name="CF_MENU")
public class Menu implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "MENU_ID")
    private String menuId;

    @NotEmpty
    @Column(name = "MENU_NAME")
    private String menuName;

    @NotEmpty
    @Column(name = "MENU_CODE")
    private String menuCode ;

    @Column(name = "MENU_TYPE")
    private String menuType ;

    @Column(name = "URI")
    private String uri ;

    @Column(name = "LEAF")
    private Integer leaf ;

    @Column(name = "PARENT_ID")
    private String parentId ;

    @Transient
    @JsonIgnore
    private List<Menu> childMenus = new ArrayList<Menu>();

    public String getMenuId() {
        return menuId;
    }

    public void setMenuId(String menuId) {
        this.menuId = menuId;
    }

    public String getMenuName() {
        return menuName;
    }

    public void setMenuName(String menuName) {
        this.menuName = menuName;
    }

    public String getMenuCode() {
        return menuCode;
    }

    public void setMenuCode(String menuCode) {
        this.menuCode = menuCode;
    }

    public String getMenuType() {
        return menuType;
    }

    public void setMenuType(String menuType) {
        this.menuType = menuType;
    }

    public String getUri() {
        return uri;
    }

    public void setUri(String uri) {
        this.uri = uri;
    }

    public Integer getLeaf() {
        return leaf;
    }

    public void setLeaf(Integer leaf) {
        this.leaf = leaf;
    }

    public String getParentId() {
        return parentId;
    }

    public void setParentId(String parentId) {
        this.parentId = parentId;
    }

    public List<Menu> getChildMenus() {
        return childMenus;
    }

    public void setChildMenus(List<Menu> childMenus) {
        this.childMenus = childMenus;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;

        if (o == null || getClass() != o.getClass()) return false;

        Menu menu = (Menu) o;

        return new EqualsBuilder()
                .append(menuId, menu.menuId)
                .isEquals();
    }

    @Override
    public int hashCode() {
        return new HashCodeBuilder(17, 37)
                .append(menuId)
                .toHashCode();
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this)
                .append("menuId", menuId)
                .append("menuName", menuName)
                .append("menuCode", menuCode)
                .append("menuType", menuType)
                .append("uri", uri)
                .append("leaf", leaf)
                .append("parentId", parentId)
                .append("menus", childMenus)
                .toString();
    }
}