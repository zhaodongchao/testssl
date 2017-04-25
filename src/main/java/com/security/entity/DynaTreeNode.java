package com.security.entity;

import org.apache.commons.lang3.builder.EqualsBuilder;
import org.apache.commons.lang3.builder.HashCodeBuilder;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * 次对象为jquery dynatree 菜单插件需要的数据单位
 * Created by zhaodongchao on 2017/3/25.
 */
public class DynaTreeNode implements Serializable{
    public static final String PATHSPLIT = ".";

    private String id;
    // (required) Displayed name of the node (html is allowed here)
    // 节点的显示名称
    private String title;

    private String fullTitle ; //不是dynatree的配置属性,用于主界面面包线的显示

    private String url ;

    private Type type = Type.INNER; //不是dynatree的配置属性，这个用户区分页面显示菜单的方式
    // May be used with activate(), select(), find(),
    // 作为节点的表示，可用作activate(),selec(),find()方法
    private String key;
    // Use a folder icon. Also the node is expandable but not selectable.
    // 是否展示为文件夹图标
    private boolean isFolder;
    // Call onLazyRead(), when the node is expanded for the first time to allow for
    // delayed creation of children.
    // 是否延迟加载
    private boolean isLazy;
    // Show this popup text.
    // 节点的提示内容
    private String tooltip;
    // Use a custom image (filename relative to tree.options.imagePath). 'null' for default
    // icon, 'false' for no icon.
    // 使用自定义的图像（文件名与tree.options.imagePath相关）。
    private String icon;
    // Class name added to the node's span tag.
    // css样式
    private String addClass;
    // Use <span> instead of <a> tag for this node
    // 是否非链接形式
    private boolean noLink;
    // Initial active status.
    // 初始化为激活状态
    private boolean activate;
    // Initial focused status.
    // 初始化为聚焦状态
    private boolean focus;
    // Initial expanded status.
    // 初始化为展开
    private boolean expand;
    // Initial selected status.
    // 初始化为选中
    private boolean select;
    // Suppress checkbox display for this node.
    // 隐藏复选框
    private boolean hideCheckbox;
    // Prevent selection.
    // 不可选
    private boolean unselectable;
    // (附加)是否工程事件
    private boolean isProjEvent;

    private List<DynaTreeNode> children = new ArrayList<DynaTreeNode>();

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getFullTitle() {
        return fullTitle;
    }

    public void setFullTitle(String fullTitle) {
        this.fullTitle = fullTitle;
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

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public boolean isFolder() {
        return isFolder;
    }

    public void setFolder(boolean folder) {
        isFolder = folder;
    }

    public boolean isLazy() {
        return isLazy;
    }

    public void setLazy(boolean lazy) {
        isLazy = lazy;
    }

    public String getTooltip() {
        return tooltip;
    }

    public void setTooltip(String tooltip) {
        this.tooltip = tooltip;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public String getAddClass() {
        return addClass;
    }

    public void setAddClass(String addClass) {
        this.addClass = addClass;
    }

    public boolean isNoLink() {
        return noLink;
    }

    public void setNoLink(boolean noLink) {
        this.noLink = noLink;
    }

    public boolean isActivate() {
        return activate;
    }

    public void setActivate(boolean activate) {
        this.activate = activate;
    }

    public boolean isFocus() {
        return focus;
    }

    public void setFocus(boolean focus) {
        this.focus = focus;
    }

    public boolean isExpand() {
        return expand;
    }

    public void setExpand(boolean expand) {
        this.expand = expand;
    }

    public boolean isSelect() {
        return select;
    }

    public void setSelect(boolean select) {
        this.select = select;
    }

    public boolean isHideCheckbox() {
        return hideCheckbox;
    }

    public void setHideCheckbox(boolean hideCheckbox) {
        this.hideCheckbox = hideCheckbox;
    }

    public boolean isUnselectable() {
        return unselectable;
    }

    public void setUnselectable(boolean unselectable) {
        this.unselectable = unselectable;
    }

    public boolean isProjEvent() {
        return isProjEvent;
    }

    public void setProjEvent(boolean projEvent) {
        isProjEvent = projEvent;
    }

    public List<DynaTreeNode> getChildren() {
        return children;
    }

    public void setChildren(List<DynaTreeNode> children) {
        this.children = children;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;

        if (o == null || getClass() != o.getClass()) return false;

        DynaTreeNode that = (DynaTreeNode) o;

        return new EqualsBuilder()
                .append(id, that.id)
                .isEquals();
    }

    @Override
    public int hashCode() {
        return new HashCodeBuilder(17, 37)
                .append(id)
                .toHashCode();
    }
    public enum Type{
        INNER,IFRAME
    }
}
