<%--
  Created by IntelliJ IDEA.
  User: zhaodongchao
  Date: 2017/3/25 22:44
  telphone:17621008632
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<body>
<div class="body_single">
  <div class="block_layout block_form">
    <div class="block_title">
      <h3>组合查询</h3>
      <em><a href="javascript:void(0)" class="slide_up"></a></em>
    </div>
    <div class="block_content">
      <table cellpadding="0" cellspacing="0" class="table_form"><!--普通表单填写表格使用table_form-->
        <colgroup>
          <col style="width:120px;"/>
          <col style="width:240px;"/>
          <col style="width:120px;"/>
          <col/>
        </colgroup><!--表单表格宽度控制使用colgroup，每个col对应下方的一个td，或者th，上下是对齐的-->
        <thead></thead><!--表头-->
        <tfoot><!--表尾，主要放表单按钮-->
        <tr>
          <td></td>
          <td colspan="4">
            <a href="#" class="a_blue"><em>查询</em></a>
            <a href="#" class="a_green"><em>重置</em></a>
            <a href="#" class="a_green" onclick="export2excel('user_grid','用户列表')"><em>重置</em></a>
        </tr>
        </tfoot>
        <tbody><!--表内容，th是蓝色字体，主要放字段名，td为字段内容-->
        <tr>
          <th><span class="span_red">*</span>姓名：</th>
          <td><input id="username" type="text" title="请输入用户姓名" class="input_120 easyui-tooltip"></td>
          <th><span class="span_red">*</span>手机号：</th>
          <td>
            <input type="text" id="telphone" class="input_120 easyui-tooltip" title="输入后四位可模糊查询">
          </td>
        </tr>
        </tbody>
      </table>
    </div>
  </div>
  <div class="block_layout block_gray">
    <div class="block_title">
      <h3>搜索结果</h3>
      <em><a href="javascript:void(0)" class="slide_up"></a></em>
    </div>
    <div>
      <table id="user_grid" >
       <%-- <thead>
        <tr>
          <th></th>
          <th>登录名</th>
          <th>真实名称</th>
          <th>性别</th>
          <th>年龄</th>
          <th>生日</th>
          <th>电话号码</th>
          <th>电子邮箱</th>
          <th>创建时间</th>
          <th>登录次数</th>
          <th>是否锁定</th>
          <th>过期时间</th>
          <th>最近一次登录</th>
        </tr>
        </thead>
        <tfoot></tfoot>
        <tbody><!--这里最好设置为点击tr即可选择与取消选择-->
        <c:choose>
          <c:when test="${empty userList}">
            <tr align="center">
              <td colspan="6"><font color='red'>未找到任何数据....</font></td>
            </tr>
          </c:when>
          <c:otherwise>
            <c:forEach items="${userList}" var="user" varStatus="i">
              <tr style="text-align: center;">
                <td>${i.index+1}</td>
                <td>${user.loginName}</td>
                <td>${user.realName}</td>
                <td>${user.sex}</td>
                <td>${user.age}</td>
                <td>${user.birthday}</td>
                <td>${user.telphone}</td>
                <td>${user.email}</td>
                <td>${user.createTime}</td>
                <td>${user.loginCount}</td>
                <td>${user.isLock}</td>
                <td>${user.expiredTime}</td>
                <td>${user.lastLoginTime}</td>
              </tr>
            </c:forEach>
          </c:otherwise>
        </c:choose>
        </tbody>--%>
      </table>
      <div id="userGrid_pager" align="left"></div>
    </div>
  </div>
</div>
</div>
</div>

<script type="text/javascript" >
    $(function () {
        $("#username").autocomplete({
            source: g_basePath + "user/find_username",
            minLength: 2,
            select: function (event, ui) {
                if (ui.item) {
                    //alert(ui.item.value+'--'+ui.item.id+'--'+this.value);
                }
            }
        });

        $("#user_grid").jqGrid(
            {
                url: g_basePath+'user/queryUsers',//组件创建完成之后请求数据的url
                datatype: "json",//请求数据返回的类型。可选json,xml,txt
                colNames: ['登录名', '真实名', '性别', '年龄', '生日','手机号码' ,'电子邮箱', '所在城市','家庭住址','创建时间'],//jqGrid的列显示名字
                colModel: [ //jqGrid每一列的配置信息。包括名字，索引，宽度,对齐方式.....
                    {name: 'loginName', index: 'loginName', width: 100,sortable:false},
                    {name: 'realName', index: 'realName', width: 100,sortable:false},
                    {name: 'sex', index: 'sex', width: 80,sortable:false},
                    {name: 'age', index: 'age asc', width: 80, align: "center",sortable:false},
                    {name: 'birthday', index: 'birthday', width: 100, align: "center",sortable:false},
                    {name: 'telphone', index: 'telphone', width: 100, center: "center",sortable:false},
                    {name: 'email', index: 'email', width: 120, center: "center",sortable:false},
                    {name: 'city', index: 'city', width: 90, align: "left",sortable:false},
                    {name: 'address', index: 'address', width: 150, align: "left",sortable:false},
                    {name: 'createTime', index: 'createTime', width: 150, sortable: false,align:"center",sortable:false}
                ],
                rowNum: 10,//一页显示多少条
                rowList: [10, 20, 30],//可供用户选择一页显示多少条
                pager: '#userGrid_pager',//表格页脚的占位符(一般是div)的id
                sortname: 'age',//初始化的时候排序的字段
                sortorder: "desc",//排序方式,可选desc,asc
                mtype: "post",//向后台请求数据的ajax的类型。可选post,get
                viewrecords: true,
                height:200
               // caption: ""//表格的标题名字
            });
    });
</script>
</body>
</html>
