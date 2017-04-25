package com.security.services;

import com.security.dao.MenuDao;
import com.security.entity.DynaTreeNode;
import com.security.entity.Menu;
import com.security.entity.Module;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by zhaodongchao on 2017/3/24.
 */
@Component
@Transactional(readOnly = true)
public class MenuService {
    @Autowired
    private MenuDao menuDao ;

    public List<Module> getAllMoule(String userId){
        /*
         获取根模块菜单集合,跟权限无关，有权限有关的菜单全部为叶子菜单；
         当当前模块下没有有权限的叶子菜单时，移除次模块，不予显示
         */
        List<Menu> rootMenus = menuDao.findAllByParentId("ROOT");

        List<Module> moduleList = new ArrayList<Module>() ;
        for (int i = 0; i < rootMenus.size(); i++) {
             Menu rootMenu = rootMenus.get(i) ;
             String menuId = rootMenu.getMenuId();
             String menuName = rootMenu.getMenuName();

             List<Menu> childMenus = null ;
             boolean hasPermission = false ;

             Integer leaf = rootMenu.getLeaf();
             String uri = rootMenu.getUri();
             if ( leaf == 0 ) {//表示不是叶子菜单，查看下级是否存在有权限的叶子菜单
                 childMenus = menuDao.findAllByParentIdAndUserId(menuId,userId);
                 if(null != childMenus && childMenus.size() > 0 ) {
                     moduleList.add(new Module(rootMenu.getMenuId(),rootMenu.getMenuName(), Module.Type.LR,"#",getAllChildByModule(menuId,menuName,userId)));
                 }
             }else{//表示这是一个独立的模块菜单
                 hasPermission = this.hasPermission(menuId,userId);
                 if(hasPermission) {
                     moduleList.add(new Module(rootMenu.getMenuId(),rootMenu.getMenuName(), Module.Type.IFRAME,rootMenu.getUri(),new ArrayList<DynaTreeNode>()));
                 }
             }
        }


        return moduleList ;
    }

    public boolean hasPermission(String menuId,String userId){
        Menu menu = menuDao.findMenuByMenuIdAndUserId(menuId,userId);
        if( null != menu){
            return true ;
        }
        return false ;
    }
    private List<DynaTreeNode> getAllChildByModule(String menuId,String menuName,String userId){
        DynaTreeNode root = new DynaTreeNode();//根菜单，相当于Module对象
        root.setId(menuId);
        root.setFullTitle(menuName);
        this.setChild(root,userId);//使用迭代的方式找出所有有权限的菜单填充root对象的childMenus属性
        return root.getChildren();
    }
    private void setChild(DynaTreeNode parent, String userId){
       List<Menu> childMenus = menuDao.findAllByParentIdAndUserId(parent.getId(),userId);
       List<DynaTreeNode> dynaTreeNodeList = parseMenus2DynaTreeNodes(childMenus);
       if(null == dynaTreeNodeList || dynaTreeNodeList.size()==0){
           return ;
       }
       for (int i = 0; i < dynaTreeNodeList.size(); i++) {
           dynaTreeNodeList.get(i).setFullTitle(parent.getFullTitle()+DynaTreeNode.PATHSPLIT+dynaTreeNodeList.get(i).getFullTitle());
           this.setChild(dynaTreeNodeList.get(i),userId);
           parent.getChildren().add(dynaTreeNodeList.get(i));
       }
    }
    public List<DynaTreeNode> parseMenus2DynaTreeNodes(List<Menu> menus){
        List<DynaTreeNode> dynaTreeNodes = new ArrayList<DynaTreeNode>();
        DynaTreeNode dynaTreeNode = null ;
        for (int i = 0; i < menus.size(); i++) {
            dynaTreeNode = new DynaTreeNode();
            dynaTreeNode.setId(menus.get(i).getMenuId());
            dynaTreeNode.setTitle(menus.get(i).getMenuName());
            dynaTreeNode.setFullTitle(menus.get(i).getMenuName());
            dynaTreeNode.setUrl(menus.get(i).getUri());
            //其他字段暂时不填充
            dynaTreeNodes.add(dynaTreeNode);
        }

        return dynaTreeNodes;

    }
}
