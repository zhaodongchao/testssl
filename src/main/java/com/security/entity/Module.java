package com.security.entity;

import org.apache.commons.lang3.builder.EqualsBuilder;
import org.apache.commons.lang3.builder.HashCodeBuilder;
import org.apache.commons.lang3.builder.ToStringBuilder;

import java.util.ArrayList;
import java.util.List;

/**
 * 此类表示菜单模块，不需要持久化
 * Created by zhaodongchao on 2017/3/24.
 */
public class Module {
    private String id;
    private String name;
    private Type type;
    private String url;
    private List<DynaTreeNode> menus = new ArrayList<DynaTreeNode>();

    public Module(String id, String name, Type type, String url, List<DynaTreeNode> menus) {
        this.id = id;
        this.name = name;
        this.type = type;
        this.url = url;
        this.menus = menus;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Type getType() {
        return type;
    }

    public void setType(Type type) {
        this.type = type;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public List<DynaTreeNode> getMenus() {
        return menus;
    }

    public void setMenus(List<DynaTreeNode> menus) {
        this.menus = menus;
    }

    public enum Type{
        LR,PORTAL,INNER,IFRAME
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;

        if (o == null || getClass() != o.getClass()) return false;

        Module module = (Module) o;

        return new EqualsBuilder()
                .append(id, module.id)
                .isEquals();
    }

    @Override
    public int hashCode() {
        return new HashCodeBuilder(17, 37)
                .append(id)
                .toHashCode();
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this)
                .append("id", id)
                .append("name", name)
                .append("type", type)
                .append("url", url)
                .append("menus", menus)
                .toString();
    }
}
