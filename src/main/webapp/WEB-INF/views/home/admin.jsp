<%--
Created by IntelliJ IDEA.
User: zhaodongchao
Date: 2017/3/24 9:54
telphone:17621008632
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- includ taglib -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- set globle vars -->
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<c:set var="basePath" value="<%=basePath%>" scope="request"/>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>资金管控</title>
  <link href="${ctx}/css/homestyle/application.css?1442373376" rel="stylesheet" />
  <link href="${ctx}/css/homestyle/vendor/fontawesome/fontawesome.css?1442373376" rel="stylesheet" />
  <link href="//fonts.googleapis.com/css?family=Open+Sans:400,600" rel="stylesheet" />
  <link href="${ctx}/css/homestyle/highlighting.css?1442373184" rel="stylesheet" />
  <link href='${ctx}/images/icons/favicon.ico' rel='icon' type='image/x-icon'>
</head>
<body class='easyui-layout theme-default' style="dispaly: none ;">
<div class='header' data-options="region:'north', split:false, border:false, height:45">
  <!-- logo -->
  <div class='logo'>
    <span class='logo-text'>中国移动通讯集团</span>
  </div>
  <!-- user info -->
  <div class='user-nav pull-left'>
    <!-- user info -->
    <ul class='list-inline list-user-info'>
      <li>
        Welcome,
        <strong>
          Geraldine Solomon
        </strong>
      </li>
      <li>
        <i class='fa fa-pencil-square'></i>
        <strong>
          Post:
        </strong>
        17621008632
      </li>
      <li>
        <i class='fa fa-sitemap'></i>
        <strong>
          Role :
        </strong>
        <select class='easyui-combobox' data-options="width:'120', height:'25'" panelheight='auto'>
          <option value='manager'>Manager</option>
          <option value='developer'>Developer</option>
          <option value='designer'>Designer</option>
        </select>
      </li>
      <li>
        <i class='fa fa-briefcase'></i>
        <strong>
          Depart. :
        </strong>
      </li>
      <li>
        <i class='fa fa-desktop'></i>
        <strong>
          Ip:
        </strong>
        192.168.1.139
      </li>
    </ul>
    <!-- system menu -->
    <div class='navbar-header pull-right'>
      <ul class='nav nav-rounded'>
        <li class='notice'>
          <a class="easyui-menubutton" data-options="menu:'#mm1', hasDownArrow:false, plain:false" href="javascript:void(0)"><i class='fa fa-bell'></i>
          </a>
        </li>
        <li>
          <a class="easyui-menubutton" data-options="menu:'#mm2', hasDownArrow:false, plain:false" href="javascript:void(0)"><i class='fa fa-user'></i>
          </a>
        </li>
        <li>
          <a href="/pages/login.html"><i class='fa fa-power-off'></i>
          </a>
        </li>
      </ul>
    </div>
  </div>

</div>

<div data-options=' itemHeight:32' id='mm1'>
  <div data-options="iconCls:'fa fa-user-plus'">
    <a href="/pages/sign-up.html">New User
    </a>
  </div>
  <div data-options="iconCls:'fa fa-inbox'">
        <span>
          E-mail Inbox
        </span>
    <small class='badge badge-info'>
      3
    </small>
  </div>
  <div data-options="iconCls:'fa fa-warning'">
        <span>
          Dashboard Error
        </span>
    <small class='badge badge-danger'>
      1
    </small>
  </div>
</div>
<div data-options=' itemHeight:32' id='mm2'>
  <div data-options="iconCls:'fa fa-user'">
    <a onclick="$('#userProfile').dialog('open')" href="javascript:void(0)">Profile
    </a>
  </div>
  <div data-options="iconCls:'fa fa-unlock-alt'">
    <a href="/pages/forgotpwd.html">Forget Password
    </a>
  </div>
  <div data-options="iconCls:'fa fa-gear'">
        <span>
          Settings
        </span>
  </div>
</div>
<div id='userProfile'>
  <form>
    <div class='form-group col-12 text-center'>
      <div class='border-circle mt-20'>
        <i class='fa fa-user fa-3x mt-10'></i>
      </div>
    </div>
    <div class='form-group'>
      <label>User Name</label>
      <input class='easyui-textbox' data-options="readonly:true, width:320, height:34, iconCls:'fa fa-user', iconWidth:38" type='text' value='John Doe'>
    </div>
    <div class='form-group'>
      <hr>
    </div>
    <div class='form-group'>
      <label>Old Password</label>
      <input class='easyui-textbox' data-options="prompt:'Old Password', width:320, height:34, iconCls:'fa fa-lock', iconWidth:38" type='password'>
    </div>
    <div class='form-group'>
      <label>New Password</label>
      <input class='easyui-textbox' data-options="prompt:'New Password', width:320, height:34, iconCls:'fa fa-lock', iconWidth:38" type='password'>
    </div>
    <div class='form-group'>
      <label>Confirm New Password</label>
      <input class='easyui-textbox' data-options="prompt:'Confirm New Password', width:320, height:34, iconCls:'fa fa-lock', iconWidth:38" type='password'>
    </div>
    <div class='form-group mt-20'>
      <div class='col-6 col-push-3'>
        <button class='easyui-linkbutton l-btn-warning pull-right' type='submit'>
          <i class='fa fa-times'></i>
          Close
        </button>
        <button class='easyui-linkbutton l-btn-primary pull-left' type='submit'>
          <i class='fa fa-check'></i>
          Accept
        </button>
      </div>
    </div>
  </form>
</div>
<!--菜单-->
<div class='sidebar' data-options="region:'west', title:'系统菜单', split:false, border:false, headerCls:'sidebar-header'">
  <ul class='sidebar-nav' id='mainSlideMenu'>
    <li>test menu</li>
  </ul>
</div>
<!--主要显示区-->
<div data-options="region:'center', border:false">
  <div class='easyui-tabs' id='mainTabs'>
    <div class='container' data-options="iconCls:'fa fa-home'" title='欢迎使用'>
     主数据
    </div>
  </div>
</div>

<script src="${ctx}/static/home/vendor/jquery-2.1.3.min.js?1440992355"></script>
<script src="${ctx}/static/home/vendor/jquery.easyui.min.js?1440992355"></script>
<script src="${ctx}/static/home/main.js?1442373184"></script>
<script src="${ctx}/static/home/application.js?1442373316"></script>
</body>
</html>
