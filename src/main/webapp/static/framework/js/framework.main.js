/**
 * 作者：黄晓华
 * 日期：2016/12/28
 * 联系方式：909833608@qq.com
 */
$.namespace("com.newtouch.framework");

var _framework = com.newtouch.framework;

_framework.data = new function() {
    var self = this;

    self.MODULE_TYPE_LR = 'LR';
    self.MODULE_TYPE_PORTAL = 'PORTAL';
    self.MODULE_TYPE_INNER = 'INNER';
    self.MODULE_TYPE_IFRAME = 'IFRAME';
    self.MENU_TYPE_INNER = 'INNER';
    self.MENU_TYPE_IFRAME = 'IFRAME';
    self.HOME_PAGE = 'home';

    self.init = function(config) {

        self.userInfo = config.userInfo;
        self.modules = config.modules;
        self.todayLogin = config.todayLogin;
        self.onlineUser = config.onlineUser;
        self.content = config.content;

        $("#current_user").text( self.userInfo.realName);
    };

    self.getModuleById = function(moduleId){
    	for(var i =0; i < _framework.data.modules.length;i++){
			var module = _framework.data.modules[i];
			if(module.id == moduleId){
				return module;
			}
		}
    	return null;
    }
      
    
};

_framework.layout = new function(){
	var self = this;
	
	self.current_module = _framework.data.HOME_PAGE;
	
	self.render = function(){
		self.initLayout();
		self.renderTitle();
		
	}
	self.initLayout = function(){
		document.onreadystatechange = function () {
            if (document.readyState == 'complete'){
                var clientHeight = document.documentElement.clientHeight ;
                var adeptHeight = clientHeight - $("#frame-header").height() - $("#frame-nav-top").height() -$("#foot_copyright").height() - 50;
                $("#frame-main-content").height(adeptHeight);
                $("#main-context").height(adeptHeight - $("#main-breadcrumb").height()).css("overflow-y","auto");

            }
        }

        $(window).resize(function () {
            //alert(123);
        });

	};
	
	self.renderTitle = function(){
		for(var i =0; i < _framework.data.modules.length;i++){
			var module = _framework.data.modules[i];
			var moduleBarHTML = '<li><a id="A_'+module.id+'" href="#" onclick="_framework.layout.openModule(\''+module.id+'\')">'+module.name+'</a></li>' 
			$("#modulesBar").append(moduleBarHTML);
		}
		if(_framework.data.modules.length>0){
			var moduleId =  _framework.data.modules[0].id;
			self.openModule(moduleId);
		}

		
	}
	self.openModule = function(moduleId) {
		
		
		
		_framework.data.current_module = _framework.data.getModuleById(moduleId);		
		var moduleName = _framework.data.current_module.name;		
        var type = _framework.data.current_module.type;
        
        $("#A_"+moduleId).parents().addClass("tcurrent").siblings().removeClass("tcurrent");
		_framework.data.content.empty();
		self.renderBreadcrumb(moduleName)
		
        if(type == _framework.data.MODULE_TYPE_LR){
        	var menus = _framework.data.current_module.menus;
        	self.renderMenu(menus);
        }else if(type == _framework.data.MODULE_TYPE_PORTAL){
            var portalURL = g_baseURL + '/portal/main?portalId=' + moduleId;
            _framework.data.content.load(portalURL);
        }else if(type == _framework.data.MODULE_TYPE_INNER){
            var url = g_baseURL+_framework.data.current_module.url;
            _framework.data.content.load(url)
        }else if(type == _framework.data.MODULE_TYPE_IFRAME){
        	self.hideMenu();
            var url = _framework.data.current_module.url;
            var iframe = $('<iframe src="'+(g_baseURL+'/'+url)+'" width=100% height='+($(window).height()- 163)+' frameborder=0></iframe>');
            _framework.data.content.empty();
            _framework.data.content.html(iframe);
            window.onresize = function() {
                setTimeout(function(){
                    var iframe = $('<iframe src="'+(g_baseURL+'/'+url)+'" width=100% height='+($(window).height()- 163)+' frameborder=0></iframe>');
                    _framework.data.content.html(iframe);
                },50);
            };
        }else{
            _framework.messagebox.error("非法的模块类型!")
        }

    };

    
    self.renderMenu = function(menus){
    	
    	var menuframe = $('#menuframe'); 
    	menuframe.empty();   
    	menuframe.show();
    	
    	$('.frame-right-col').removeClass('frame-full-col')
    	menuframe.load(g_baseURL+'/index/leftTree')
    }
    
    self.hideMenu = function(){
    	var menuframe = $('#menuframe');    	
    	menuframe.hide();
    	$('.frame-right-col').addClass('frame-full-col')
    	
    }
    
    self.openMenu = function(menu) {
    	

   		self.renderBreadcrumb(menu.fullTitle);
    	if(menu.url==''){
    		_framework.data.content.empty();
    		return;
    	}
    	
    	if(menu.type == _framework.data.MENU_TYPE_INNER){
        	_framework.data.content.load(g_basePath+'/'+menu.url)
        }else if(menu.type == _framework.data.MENU_TYPE_IFRAME){  
        	var iframe = $('<iframe src="'+(g_baseURL+'/'+menu.url)+'" width=100% height='+($(window).height()- 163)+' frameborder=0></iframe>');
        	_framework.data.content.html(iframe);
            window.onresize = function() {
                setTimeout(function(){
                    var iframe = $('<iframe src="'+(g_baseURL+'/'+menu.url)+'" width=100% height='+($(window).height()- 163)+' frameborder=0></iframe>');
                    _framework.data.content.html(iframe);
                },50);
            };
        }else{
            _framework.messagebox.error("非法的模块类型!")
        }

    };
    
    self.renderBreadcrumb = function(fullTitle){
    	
    	var breadcrumbsHTML = '';
    	var titles = fullTitle.split('.');
    	for(var i=0;i<titles.length;i++){
    		var t = titles[i];
    		
    		breadcrumbsHTML += titles[i];
    		
    		if(i!=titles.length-1){
    			breadcrumbsHTML += ' > ';
    		}
    	}
    	$('#main-breadcrumb').html(breadcrumbsHTML);
    }


	self.formatTitle = function(title,commissionCount){
		var tt = title;
		if(title.indexOf('(')!=-1){
			tt = title.substring(0,title.indexOf('('));
		};
		return tt +	commissionCount ;
	}
}
_framework.messagebox = new function () {
    var self = this;

    self.info = function (message) {
        alert(message);
    };

    self.error = function (message) {
        alert(message);
    };

    self.warn = function (message) {
        alert(message);
    };

    self.question = function (message) {
        alert(message);
    };
}
_framework.timer = new function () {
	var self = this;

	self.setCommissionCountTimer = function () {
		window.setInterval('_framework.layout.refreshCommissionCount()',120000);
	}
}
_framework.tips = new function () {
    var self = this ;
    var hasPermission = false ;
    var users = [];
    var data = [] ;
    self.CapitalTip = function () {
        $.ajax({url : g_basePath+"ui/modules/fundstatistics/fundCurrentQueryDept.action",
            data:{},
            type:'post',
            async:false,
            dataType:"json",
            success:function(responseInfo){
                data = responseInfo.root ;
                users = responseInfo.rootUser ;
            }
		});
        //判断是否有权限

        $.each(users,function (i) {
        	alert(users[i].varname +"---"+ _framework.data.userInfo.loginName);
			if(users[i].varname == _framework.data.userInfo.loginName){
				hasPermission = true ;
			}
        })
		if (!hasPermission){
            $(".message_show").addClass("hide");
        	return ;
		}
        var total_capital = 0.0 ;
        $.each(data,function (i) {
            total_capital += parseFloat(data[i].sum)/10000 ;
        });
        $("#tip_text").empty();
        $("#tip_text").append("有新的资金需求:<strong>" + money(total_capital) +"</strong>");
    }
    self.showCapitalDetail = function () {
    	if(!hasPermission){
    		return ;
		}
    	var strHtml = "" ;
    	$.each(data,function (i) {
            strHtml +='<tr>';
            strHtml +='<td class="numId" style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden; left;">'+(i+1)+'</td>';
            strHtml +='<td style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;text-align: left;">'+data[i].deptname+'</td>';
            strHtml +='<td style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;text-align: right;">'+money(data[i].sum/10000)+'</td>';
            strHtml +='</tr>';
        });
    	$("#capitalDetailData").empty();
    	$("#capitalDetailData").append(strHtml);
        openpop('capital_need_popup', 'capital_need_iframe');
    }
    self.colseCapitalDetail = function () {
        $("#capital_need_popup").addClass("hide");
    }
    self.colse = function () {
        $(".close_gif").click(function () {
                $(".message_show").addClass("hide");
            }
        );
    }
}