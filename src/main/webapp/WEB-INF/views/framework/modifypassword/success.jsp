<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <%@include file="../common/bootup.jsp" %>
    <link rel="stylesheet" type="text/css" href="${theme_css}/modify-pass.css" />
    <title>修改密码</title>
</head>
<body class="body_1280 body_single"><!--1280居中，单个页面-->
<div class="container">
    <div class="frame-header">
        <div class="system_name">上海移动管理信息系统</div>
    </div>
    <div class="content_full">
        <div class="main">
            <div class="frame-breadcrumb">修改密码</div>
            <div class="balance-bar">
                <ul id="modify_password_ul">
                    <li >
                        <div><span>1</span></div>
                        1.修改密码
                    </li>
                    <li class="progress-current">
                        <div><span>2</span></div>
                        2.完成
                    </li>
                </ul>
            </div>
            <div class="block_layout block_form">
                <div class="block_content" id="modify_password_content">
                    <table cellpadding="0" cellspacing="0" class="table_form"><!--普通表单填写表格使用table_form-->
                        <colgroup>
                            <col style="width:470px;" />
                            <col style="width:100px;" />
                            <col />
                            <col />
                        </colgroup><!--表单表格宽度控制使用colgroup，每个col对应下方的一个td，或者th，上下是对齐的-->
                        <thead></thead><!--表头-->
                        <tfoot><!--表尾，主要放表单按钮-->
                        
                        </tfoot>
                        <tbody id = "modify_password_body"><!--表内容，th是蓝色字体，主要放字段名，td为字段内容-->
	                        <div class="modify_pass_success">
		                        <dl>
		                            <dt></dt>
		                            <dd>
		                                <h2>恭喜您，修改密码成功！</h2>
		                                <p>现在使用新密码登录。</p>
		                                <a href="#" onclick="window.close()" class="a_blue"><em>确定</em></a>
		                            </dd>
		                        </dl>
	                   		</div>
                        </tbody>


                    </table>
                </div>
            </div>
        </div>
    </div>

</div>
</body>

</html>