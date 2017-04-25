<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

<!-- includ taglib -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!-- set globle vars -->
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<c:set var="basePath" value="<%=basePath%>" scope="session"/>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="resource" value="${ctx}/static"/>
<c:set var="framework" value="${resource}/framework"/>
<c:set var="theme" value="${framework}/themes/classic-blue"/>
<c:set var="theme_css" value="${theme}/css" />
<c:set var="theme_images" value="${theme}/images" />

<!-- platform globle variable -->
<script type="text/javascript">
    var g_baseURL = "${ctx}";
    var g_resource = "${ctx}/static";
    var g_basePath = "${basePath}";
</script>

<!-- jquery and jquery ui -->
<script type="text/javascript" src="${framework}/required-plugins/jquery-1.12.4/jquery.js"></script>
<link rel="stylesheet" href="${framework}/required-plugins/jquery-ui-1.12.1/jquery-ui.css"/>
<script type="text/javascript" src="${framework}/required-plugins/jquery-ui-1.12.1/jquery-ui.js"></script>

<!-- jquery layout -->
<script type="text/javascript" src="${framework}/required-plugins/jquery-layout-1.4.4/jquery.layout.js"></script>
<link rel="stylesheet" href="${framework}/required-plugins/jquery-layout-1.4.4/layout-default.css"/>

<!-- jqGrid -->
<link rel="stylesheet" href="${framework}/required-plugins/jqgrid-5.2.0/css/ui.jqgrid.css"/>
<script type="text/javascript" src="${framework}/required-plugins/jqgrid-5.2.0/js/i18n/grid.locale-cn.js"></script>
<script type="text/javascript" src="${framework}/required-plugins/jqgrid-5.2.0/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript" src="${framework}/js/common/numberformat.js"></script>


<!-- jquery.dynatree-1.2.5 layout -->
<script type="text/javascript" src="${framework}/required-plugins/jquery.dynatree-1.2.5/jquery.dynatree.min.js"></script>
<link rel="stylesheet" href="${framework}/required-plugins/jquery.dynatree-1.2.5/skin/ui.dynatree.css"/>


<!-- framework js -->
<script type="text/javascript" src="${framework}/js/framework.base.js"></script>
<script type="text/javascript" src="${framework}/js/framework.main.js"></script>
<link rel="stylesheet" href="${theme_css}/layout.css"/>

<!--公共弹出框组件-->
<link rel="stylesheet" type="text/css" href="${framework}/extra-themes/css/explain.css"  />
<script type="text/javascript" src="${framework}/extra-themes/popup.js"></script>
