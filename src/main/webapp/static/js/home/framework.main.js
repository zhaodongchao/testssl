(function($) {
    /**
     * Namespace
     */
    $.extend({
        namespace: function () {
            var a = arguments, o = null, i, j, d, rt;
            for (i = 0; i < a.length; ++i) {
                d = a[i].split(".");
                rt = d[0];
                eval("if (typeof " + rt + " == \"undefined\"){" + rt
                    + " = {};} o = " + rt + ";");
                for (j = 1; j < d.length; ++j) {
                    o[d[j]] = o[d[j]] || {};
                    o = o[d[j]]
                }
            }
            return this;
        }
    });
})(jQuery);
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
        }else{
            _framework.messagebox.error("非法的模块类型!");
        }

    };

    
    self.renderMenu = function(menus){
    	
    	var menuframe = $('#menuframe'); 
    	menuframe.empty();   
    	menuframe.show();
    	
    	$('.frame-right-col').removeClass('frame-full-col');
    	menuframe.load(g_baseURL+'/index/leftTree');
    }
    
    self.hideMenu = function(){
    	var menuframe = $('#menuframe');    	
    	menuframe.hide();
    	$('.frame-right-col').addClass('frame-full-col')
    	
    }
    
    self.openMenu = function(menu) {
    	

   		self.renderBreadcrumb(menu.fullTitle);
    	if(!menu.url){
    		_framework.data.content.empty();
    		return;
    	}
    	
    	if(menu.type == _framework.data.MENU_TYPE_INNER){//菜单默认为这中类型
        	_framework.data.content.load(g_basePath+'/'+menu.url)
        }else if(menu.type == _framework.data.MENU_TYPE_IFRAME){  
        	var iframe = $('<iframe src="'+(g_baseURL+'/'+menu.url)+'" width=100% height='+($(window).height()- 163)+' frameborder=0></iframe>');
        	_framework.data.content.html(iframe);        	
        }else{
            _framework.messagebox.error("非法的模块类型!")
        }

    };
    
    self.renderBreadcrumb = function(fullTitle){
    	
    	var breadcrumbsHTML = '';
    	var titles = fullTitle.split('.');
    	for(var i=0;i<titles.length;i++){
    		breadcrumbsHTML += titles[i];
    		if(i!=titles.length-1){
    			breadcrumbsHTML += ' > ';
    		}
    	}
    	$('#main-breadcrumb').html(breadcrumbsHTML);
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