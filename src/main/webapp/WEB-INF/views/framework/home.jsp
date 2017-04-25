<%--
  Created by IntelliJ IDEA.
  User: hxh
  Date: 2016/12/28
  Time: 14:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <%@include file="common/bootup.jsp" %>
    <title>主页</title>
</head>
<body class="body-full">
    <script type="text/javascript">
    	var userInfo = ${userJson};
		  var modules = ${modulesJson};

        
        $(function () {
            var config = {
                'userInfo':userInfo,
                'modules':modules,
                'todayLogin':'',
                'onlineUser':'',
                'content':$('#main-context')
            }
            _framework.data.init(config);
            _framework.layout.render();
           // _framework.tips.CapitalTip();//初始化资金需求
        })
        
        
    </script>
    
    <div class = "frame-container">
		<div class="frame-header" id="frame-header">
			<%@include file="common/title.jsp" %>
		</div>
	
    <!--主菜单-->
    <div class="frame-nav" id="frame-nav-top">
        <ul id="modulesBar">
          <!--渲染菜单-->
        </ul>
    </div>
		
		<div class = "frame-content" id = "frame-main-content">
			<div class = "frame-left-col" id="menuframe"></div>
			<div class="frame-right-col">
        <div class = "frame-breadcrumb" id="main-breadcrumb"></div>
        <div class = "frame-right-main" id="main-context"></div>
      </div>
		</div>

    <div class="foot" id = "foot_copyright">
      <div class="f_m">
        <div class="foot_word"><span>中国移动集团上海分公司</span><br/>
          <span>ChinaMobile Shanghai Co.,Ltd</span></div>
      </div>
    </div>

     <%-- <div id="capital_need_popup" class="popup hide">
        <div  class="popup_layout_content popup_400" style="height:250px;">
          <div class="block_pop">
            <div class="block_pop_title">
              <h5>本月资金需求信息</h5>
            </div>
            <div class="block_pop_content">
              <div class="part" style="height:215px;overflow-y:scroll;">
                <table cellpadding="0" cellspacing="0"  class="table_show">
                  <thead>
                  <th width="30"></th>
                  <th style="text-align: left ;width: 220px;">二级部门</th>
                  <th style="text-align: right">总金额（万元）</th>
                  </thead>
                  <tbody id="capitalDetailData">

                  </tbody>
                </table>
              </div>
            </div>
            <div class="block_pop_foot" style="height: 30px">
                <a href="javascript:void(0)" id="do_split" class="a_green"><em onclick="_framework.tips.colseCapitalDetail();">确定</em></a>
            </div>
          </div>
        </div>
        <iframe id="capital_need_iframe" frameborder="0" class="popup_iframe"></iframe>
      </div>--%>
	</div>
    
</body>
</html>
