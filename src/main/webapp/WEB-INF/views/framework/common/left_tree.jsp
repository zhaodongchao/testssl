<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<head>
</head>

<div id="menu" class="menu">
    <div class="menu-header"><h3 class="box-title">所有菜单</h3></div>
    <div id="menu-main" class="menu-main"></div>
</div>

<script>
         $(".menu-main").dynatree({
            fx: { height: "toggle", duration: 500 },
            autoCollapse: true,
            onActivate : onMenuClick,
            children : _framework.data.current_module.menus
        }); 
         
         function onMenuClick(dtnode, e){
        	 _framework.layout.openMenu(dtnode.data)
        	 if (dtnode.hasChildren() || dtnode.data.url == null) {
                 dtnode.toggleExpand();
             }else {
            	 dtnode.deactivate();
             }
         }

</script>

