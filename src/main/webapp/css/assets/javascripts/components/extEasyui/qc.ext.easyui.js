/* 作者：李钰龙
 * 功能：扩展EasyUI
 * 扩展项目：
 * 	1、自动回收自动回收iframe
 * 	2、可自定义加载时的文字
 *  3、加载出错时，将出错内容放入对话框
 *  4、增加表头菜单，控制显示隐藏列
 *  5、扩展数据验证
 *  6、树形控件自动可根据parentField自动生成树
 *  9、检测处理pannel超出边界情况
 * 10、可更换主题
 * 11、建立图标对象数组
 * 12、扩展datagrid，使datagrid的editors能保存combotree的多选值
 */

/**
 * @author 李钰龙
 * @requires jQuery,EasyUI
 * panel关闭时回收内存，主要用于layout使用iframe嵌入网页时的内存泄漏问题
 */


$.fn.panel.defaults.onBeforeDestroy = function() {
	var frame = $('iframe', this);
	try {
		if (frame.length > 0) {
			for ( var i = 0; i < frame.length; i++) {
				frame[i].contentWindow.document.write('');
				frame[i].contentWindow.close();
			}
			frame.remove();
			if ($.browser.msie) {
				CollectGarbage();
			}
		}
	} catch (e) {
	}
};

/**
 * 使panel和datagrid在加载时提示
 * @author 李钰龙
 * @requires jQuery,EasyUI
 *
 */
$.fn.panel.defaults.loadingMessage = '加载中....';
$.fn.datagrid.defaults.loadMsg = '加载中....';

$.fn.dialog.defaults.onOpen = function() {
	$(this).parent().addClass("active");
};
$.fn.dialog.defaults.onClose = function() {
	$(this).parent().removeClass("active");
};

/**
 * @author 李钰龙
 * @requires jQuery,EasyUI
 * 通用错误提示
 * 用于datagrid/treegrid/tree/combogrid/combobox/form加载数据出错时的操作
 */
var easyuiErrorFunction = function(XMLHttpRequest) {
	$.messager.progress('close');
	$.messager.alert('错误', XMLHttpRequest.responseText);
};
$.fn.datagrid.defaults.onLoadError = easyuiErrorFunction;
$.fn.treegrid.defaults.onLoadError = easyuiErrorFunction;
$.fn.tree.defaults.onLoadError = easyuiErrorFunction;
$.fn.combogrid.defaults.onLoadError = easyuiErrorFunction;
$.fn.combobox.defaults.onLoadError = easyuiErrorFunction;
$.fn.form.defaults.onLoadError = easyuiErrorFunction;

/**
 * @author 李钰龙
 * @requires jQuery,EasyUI
 * 为datagrid、treegrid增加表头菜单，用于显示或隐藏列，注意：冻结列不在此菜单中
 */
var createGridHeaderContextMenu = function(e, field) {
	e.preventDefault();
	var grid = $(this);/* grid本身 */
	var headerContextMenu = this.headerContextMenu;/* grid上的列头菜单对象 */
	if (!headerContextMenu) {
		var tmenu = $('<div class="col-12"></div>').appendTo('body');
		var fields = grid.datagrid('getColumnFields');
		for ( var i = 0; i < fields.length; i++) {
			var fildOption = grid.datagrid('getColumnOption', fields[i]);
			if (!fildOption.hidden) {
				$('<div iconCls="fa fa-chevron-circle-down" field="' + fields[i] + '"/>').html(fildOption.title).appendTo(tmenu);
			} else {
				$('<div iconCls="fa fa-circle" field="' + fields[i] + '"/>').html(fildOption.title).appendTo(tmenu);
			}
		}
		headerContextMenu = this.headerContextMenu = tmenu.menu({
			onClick : function(item) {
				var field = $(item.target).attr('field');
				if (item.iconCls == 'fa fa-chevron-circle-down') {
					grid.datagrid('hideColumn', field);
					$(this).menu('setIcon', {
						target : item.target,
						iconCls : 'fa fa-circle'
					});
				} else {
					grid.datagrid('showColumn', field);
					$(this).menu('setIcon', {
						target : item.target,
						iconCls : 'fa fa-chevron-circle-down'
					});
				}
			}
		});
	}
	headerContextMenu.menu('show', {
		left : e.pageX,
		top : e.pageY
	});
};
$.fn.datagrid.defaults.onHeaderContextMenu = createGridHeaderContextMenu;
$.fn.treegrid.defaults.onHeaderContextMenu = createGridHeaderContextMenu;

/**
 * @author 李钰龙
 * @requires jQuery,EasyUI
 * 扩展validatebox，添加验证数据功能
 */
$.extend($.fn.validatebox.defaults.rules, {
	idcard : {// 验证身份证
		validator : function(value) {
			return /^\d{15}(\d{2}[A-Za-z0-9])?$/i.test(value);
		},
		message : '身份证号码格式不正确'
	},
	minLength: {
		validator: function(value, param){
			return value.length >= param[0];
		},
		message: '请输入至少（2）个字符.'
	},
	length:{validator:function(value,param){
		var len=$.trim(value).length;
			return len>=param[0]&&len<=param[1];
		},
			message:"输入内容长度必须介于{0}和{1}之间."
		},
	phone : {// 验证电话号码
		validator : function(value) {
			return /^((\(\d{2,3}\))|(\d{3}\-))?(\(0\d{2,3}\)|0\d{2,3}-)?[1-9]\d{6,7}(\-\d{1,4})?$/i.test(value);
		},
		message : '格式不正确,请使用下面格式:020-88888888'
	},
	mobile : {// 验证手机号码
		validator : function(value) {
			return /^(13|15|18)\d{9}$/i.test(value);
		},
		message : '手机号码格式不正确'
	},
	intOrFloat : {// 验证整数或小数
		validator : function(value) {
			return /^\d+(\.\d+)?$/i.test(value);
		},
		message : '请输入数字，并确保格式正确'
	},
	currency : {// 验证货币
		validator : function(value) {
			return /^\d+(\.\d+)?$/i.test(value);
		},
		message : '货币格式不正确'
	},
	qq : {// 验证QQ,从10000开始
		validator : function(value) {
			return /^[1-9]\d{4,9}$/i.test(value);
		},
		message : 'QQ号码格式不正确'
	},
	integer : {// 验证整数
		validator : function(value) {
			return /^[+]?[1-9]+\d*$/i.test(value);
		},
		message : '请输入整数'
	},
	age : {// 验证年龄
		validator : function(value) {
			return /^(?:[1-9][0-9]?|1[01][0-9]|120)$/i.test(value);
		},
		message : '年龄必须是0到120之间的整数'
	},

	chinese : {// 验证中文
		validator : function(value) {
			return /^[Α-\￥]+$/i.test(value);
		},
		message : '请输入中文'
	},
	english : {// 验证英语
		validator : function(value) {
			return /^[A-Za-z]+$/i.test(value);
		},
		message : '请输入英文'
	},
	unnormal : {// 验证是否包含空格和非法字符
		validator : function(value) {
			return /.+/i.test(value);
		},
		message : '输入值不能为空和包含其他非法字符'
	},
	username : {// 验证用户名
		validator : function(value) {
			return /^[a-zA-Z][a-zA-Z0-9_]{5,15}$/i.test(value);
		},
		message : '用户名不合法（字母开头，允许6-16字节，允许字母数字下划线）'
	},
	faxno : {// 验证传真
		validator : function(value) {
//				return /^[+]{0,1}(\d){1,3}[ ]?([-]?((\d)|[ ]){1,12})+$/i.test(value);
			return /^((\(\d{2,3}\))|(\d{3}\-))?(\(0\d{2,3}\)|0\d{2,3}-)?[1-9]\d{6,7}(\-\d{1,4})?$/i.test(value);
		},
		message : '传真号码不正确'
	},
	zip : {// 验证邮政编码
		validator : function(value) {
			return /^[1-9]\d{5}$/i.test(value);
		},
		message : '邮政编码格式不正确'
	},
	ip : {// 验证IP地址
		validator : function(value) {
			return /d+.d+.d+.d+/i.test(value);
		},
		message : 'IP地址格式不正确'
	},
	name : {// 验证姓名，可以是中文或英文
			validator : function(value) {
				return /^[Α-\￥]+$/i.test(value)|/^\w+[\w\s]+\w+$/i.test(value);
			},
			message : '请输入姓名'
	},
	date : {// 验证日期
		validator : function(value) {
		//格式yyyy-MM-dd或yyyy-M-d
			return /^(?:(?!0000)[0-9]{4}([-]?)(?:(?:0?[1-9]|1[0-2])\1(?:0?[1-9]|1[0-9]|2[0-8])|(?:0?[13-9]|1[0-2])\1(?:29|30)|(?:0?[13578]|1[02])\1(?:31))|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)([-]?)0?2\2(?:29))$/i.test(value);
		},
		message : '清输入合适的日期格式'
	},
	msn:{
		validator : function(value){
		return /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/.test(value);
		},
		message : '请输入有效的msn账号(例：abc@hotmail(msn/live).com)'
	},
	same:{
		validator : function(value, param){
			if(value == undefined) {
				return false;
			}
			return $(param[0]).val() == value;
		},
		message : '两次输入的密码不一致！'
	}
});

/**
 * @author 李钰龙
 * @requires jQuery,EasyUI
 * 扩展datagrid，添加单元格内容提示框
 */
$.extend($.fn.datagrid.methods, {
	/**
	 * 开打提示功能
	 * @param {} jq
	 * @param {} params 提示消息框的样式
	 * @return {}
	 */
	doCellTip:function (jq, params) {
		function showTip(showParams, td, e, dg) {
			//无文本，不提示。
			if ($(td).text() == "") return;

			params = params || {};
			showParams.content = '<div class="tipcontent">' + showParams.content + '</div>';
			$(td).tooltip({
				content:showParams.content,
				trackMouse:true,
				position:params.position,
				onHide:function () {
					$(this).tooltip('destroy');
				},
				onShow:function () {
					var tip = $(this).tooltip('tip');
					if(showParams.tipStyler){
						tip.css(showParams.tipStyler);
					}
					if(showParams.contentStyler){
						tip.find('div.tipcontent').css(showParams.contentStyler);
					}
				}
			}).tooltip('show');

		}
		return jq.each(function () {
			var grid = $(this);
			var options = $(this).data('datagrid');
			if (options && !options.tooltip) {
				var panel = grid.datagrid('getPanel').panel('panel');
				panel.find('.datagrid-body').each(function () {
					var delegateEle = $(this).find('> div.datagrid-body-inner').length ? $(this).find('> div.datagrid-body-inner')[0] : this;
					$(delegateEle).undelegate('td', 'mouseover').undelegate('td', 'mouseout').undelegate('td', 'mousemove').delegate('td[field]', {
						'mouseover':function (e) {
							//if($(this).attr('field')===undefined) return;
							var that = this;
							var setField = null;
							if(params.specialShowFields && params.specialShowFields.sort){
								for(var i=0; i<params.specialShowFields.length; i++){
									if(params.specialShowFields[i].field == $(this).attr('field')){
										setField = params.specialShowFields[i];
									}
								}
							}
							if(setField==null){
								options.factContent = $(this).find('>div').clone().css({'margin-left':'-5000px', 'width':'auto', 'display':'inline', 'position':'absolute'}).appendTo('body');
								var factContentWidth = options.factContent.width();
								params.content = $(this).text();
								if (params.onlyShowInterrupt) {
									if (factContentWidth > $(this).width()) {
										showTip(params, this, e, grid);
									}
								} else {
									showTip(params, this, e, grid);
								}
							}else{
								panel.find('.datagrid-body').each(function(){
									var trs = $(this).find('tr[datagrid-row-index="' + $(that).parent().attr('datagrid-row-index') + '"]');
									trs.each(function(){
										var td = $(this).find('> td[field="' + setField.showField + '"]');
										if(td.length){
											params.content = td.text();
										}
									});
								});
								showTip(params, this, e, grid);
							}
						},
						'mouseout':function (e) {
							if (options.factContent) {
								options.factContent.remove();
								options.factContent = null;
							}
						}
					});
				});
			}
		});
	},
	/**
	 * 关闭消息提示功能
	 * @param {} jq
	 * @return {}
	 */
	cancelCellTip:function (jq) {
		return jq.each(function () {
			var data = $(this).data('datagrid');
			if (data.factContent) {
				data.factContent.remove();
				data.factContent = null;
			}
			var panel = $(this).datagrid('getPanel').panel('panel');
			panel.find('.datagrid-body').undelegate('td', 'mouseover').undelegate('td', 'mouseout').undelegate('td', 'mousemove');
		});
	}
});

/**
 * @author 李钰龙
 * @requires jQuery,EasyUI
 * 扩展datagrid，使datagrid的editors能保存combotree的多选值
 */
$.extend(jQuery.fn.datagrid.defaults.editors, {
	combotree: {
		init: function(container, options){
			var editor = jQuery('<input type="text"/>').appendTo(container);
			cip.editor = editor;
			cip.options = options;
			if(editor.combotree) {
				editor.combotree(options);
			}
			return editor;
		},
		destroy: function(target){
			$(target).combotree('destroy');
		},
		getValue: function(target){
			var temp = $(target).combotree('getValues');
			return temp.join(',');
		},
		setValue: function(target, value){
			if(value && value != null) {
				var temp = value.split(',');
				$(target).combotree('setValues', temp);
			}
		},
		resize: function(target, width){
			$(target).combotree('resize', width);
		}
	}
});


/**
 * @author 李钰龙
 * @requires jQuery,EasyUI
 * 将tree，treegrid的list数据自动转换tree形式的json
 */
$.fn.treeDataFilterListToTree = function(data, opt) {
	if (opt.parentField) {
		var idField = opt.idField || 'id';
		var textField = opt.textField || opt.treeField || 'text';
		var iconField = opt.iconField || 'iconCls';
		var parentField = opt.parentField || 'parentField';
		var i, l, treeData = [], tmpMap = [];
		for (i = 0, l = data.length; i < l; i++) {
			tmpMap[data[i][idField]] = data[i];
		}
		for (i = 0, l = data.length; i < l; i++) {
			if (tmpMap[data[i][parentField]] && data[i][idField] != data[i][parentField]) {
				if (!tmpMap[data[i][parentField]]['children']) {
					tmpMap[data[i][parentField]]['children'] = [];
				}
				data[i]['id'] = data[i][idField];
				data[i]['text'] = data[i][textField];
				data[i]['iconCls'] = data[i][iconField];
				tmpMap[data[i][parentField]]['children'].push(data[i]);
			} else {
				data[i]['id'] = data[i][idField];
				data[i]['text'] = data[i][textField];
				data[i]['iconCls'] = data[i][iconField];
				treeData.push(data[i]);
			}
		}
		return treeData;
	}
	return data;

};

/**
 * @author 李钰龙
 * @requires jQuery,EasyUI
 * 扩展tree，使tree支持设置父节点，自动生成树形结构
 * 增加parentField属性
 */
$.fn.tree.defaults.loadFilter = function(data) {
	return $.fn.treeDataFilterListToTree(data, $(this).data().tree.options);
};

/**
 * @author 李钰龙
 * @requires jQuery,EasyUI
 * 扩展treegrid，使treegrid支持设置父节点，自动生成树形结构
 * 增加parentField属性
 */
$.fn.treegrid.defaults.loadFilter = function(data) {
	return $.fn.treeDataFilterListToTree(data, $(this).data().treegrid.options);
};

/**
 * @author 李钰龙
 * @requires jQuery,EasyUI
 * 扩展combotree，使combotree支持设置父节点，自动生成树形结构
 * 增加parentField属性
 */
$.fn.combotree.defaults.loadFilter = $.fn.tree.defaults.loadFilter;



/**
 * 扩展树表格级联勾选方法：
 * @param {Object} container
 * @param {Object} options
 * @return {TypeName}
 */
$.extend($.fn.treegrid.methods,{
	/**
	 * 级联选择
	 * @param {Object} target
	 * @param {Object} param
	 *	  param包括两个参数:
	 *		  id:勾选的节点ID
	 *		  deepCascade:是否深度级联
	 * @return {TypeName}
	 */
	cascadeCheck : function(target,param){
		var opts = $.data(target[0], "treegrid").options;
		if(opts.singleSelect)
			return;
		var idField = opts.idField;//这里的idField其实就是API里方法的id参数
		var status = false;//用来标记当前节点的状态，true:勾选，false:未勾选
		var selectNodes = $(target).treegrid('getSelections');//获取当前选中项
		for(var i=0;i<selectNodes.length;i++){
			if(selectNodes[i][idField]==param.id)
				status = true;
		}
		//级联选择父节点
		selectParent(target[0],param.id,idField,status);
		selectChildren(target[0],param.id,idField,param.deepCascade,status);
		/**
		 * 级联选择父节点
		 * @param {Object} target
		 * @param {Object} id 节点ID
		 * @param {Object} status 节点状态，true:勾选，false:未勾选
		 * @return {TypeName}
		 */
		function selectParent(target,id,idField,status){
			var parent = $(target).treegrid('getParent',id);
			if(parent){
				var parentId = parent[idField];
				if(status)
					$(target).treegrid('select',parentId);
				else
					$(target).treegrid('unselect',parentId);
				selectParent(target,parentId,idField,status);
			}
		}
		/**
		 * 级联选择子节点
		 * @param {Object} target
		 * @param {Object} id 节点ID
		 * @param {Object} deepCascade 是否深度级联
		 * @param {Object} status 节点状态，true:勾选，false:未勾选
		 * @return {TypeName}
		 */
		function selectChildren(target,id,idField,deepCascade,status){
			//深度级联时先展开节点
			if(!status&&deepCascade)
				$(target).treegrid('expand',id);
			//根据ID获取下层孩子节点
			var children = $(target).treegrid('getChildren',id);
			for(var i=0;i<children.length;i++){
				var childId = children[i][idField];
				if(status)
					$(target).treegrid('select',childId);
				else
					$(target).treegrid('unselect',childId);
				selectChildren(target,childId,idField,deepCascade,status);//递归选择子节点
			}
		}
	}
});

/**
 * @author 李钰龙
 * @requires jQuery,EasyUI
 * 扩展datagrid行编辑的combobox编辑器，解决无法设置多选值的bug
 */
$.extend($.fn.datagrid.defaults.editors.combobox, {
	getValue : function(jq) {
		var opts = $(jq).combobox('options');
		if(opts.multiple){
			var values = $(jq).combobox('getValues');
			if(values.length>0){
				if(values[0]==''||values[0]==' '){
					return values.join(',').substring(1);//新增的时候会把空白当成一个值了，去掉
				}
			}
			return values.join(',');
		} else
			return $(jq).combobox("getValue");
	},
	setValue : function(jq, value) {
		var opts = $(jq).combobox('options');
		if(opts.multiple && value!=null && (""+value).indexOf(opts.separator)!=-1){//多选且不只一个值
			var values = (""+value).split(opts.separator);
			$(jq).combobox("setValues", values);
		} else
			$(jq).combobox("setValue", value);
	}
});

/**
 * @author 李钰龙
 * @requires jQuery,EasyUI
 * 扩展datagrid行编辑的combogrid编辑器
 */
$.extend($.fn.datagrid.defaults.editors, {
	combogrid: {
		init: function(container, options){
			var input = $('<input type="text" class="datagrid-editable-input"/>').appendTo(container);
			input.combogrid(options);
			return input;
		},
		destroy: function(target){
			$(target).combogrid('destroy');
		},
		getValue: function(jq){
			var opts = $(jq).combogrid('options');
			if(opts.multiple){
				var values = $(jq).combogrid('getValues');
				if(values.length>0){
					if(values[0]==''||values[0]==' '){
						return values.join(',').substring(1);//新增的时候会把空白当成一个值了，去掉
					}
				}
				return values.join(',');
			} else
				return $(jq).combogrid("getValue");
		},
		setValue: function(jq, value){
			var opts = $(jq).combogrid('options');
			if(opts.multiple && value!=null && (""+value).indexOf(opts.separator)!=-1){//多选且不只一个值
				var values = (""+value).split(opts.separator);
				$(jq).combogrid("setValues", values);
			} else
				$(jq).combogrid("setValue", value);
		},
		resize: function(target, width){
			$(target).combogrid('resize',width);
		}
	}
});
/**
 * 扩展datebox为datetimebox
 */
$.extend($.fn.datagrid.defaults.editors, {
	datetimebox: {
		init: function(container, options){
			var editor = $('<input type="text" />').appendTo(container);
			options.editable = false;
			editor.datetimebox(options);
			return editor;
		},
		getValue: function(target){
			return $(target).datetimebox('getValue');
		},
		setValue: function(target, value){
			$(target).datetimebox('setValue', value);
		},
		resize: function(target, width){
			$(target).datetimebox('resize',width);
		},
		destroy: function(target) {
			$(target).datetimebox('destroy');
		}
	}
});

$.extend($.fn.datagrid.methods, {
	/*扩展动态编辑框，可以指定禁止编辑的编辑框所在的列*/
	addEditor : function(jq, param) {
		if (param instanceof Array) {
			$.each(param, function(index, item) {
				var e = $(jq).datagrid('getColumnOption', item.field);
				e.editor = item.editor;
			});
		} else {
			var e = $(jq).datagrid('getColumnOption', param.field);
			e.editor = param.editor;
		}
	},
	/*扩展动态编辑框，可以指定禁止编辑的编辑框所在的列*/
	removeEditor : function(jq, param) {
		if (param instanceof Array) {
			$.each(param, function(index, item) {
				var e = $(jq).datagrid('getColumnOption', item);
				e.editor = {};
			});
		} else {
			var e = $(jq).datagrid('getColumnOption', param);
			e.editor = {};
		}
	},
	/*扩展自动合并连续单元格*/
	autoMergeCells : function (jq, fields) {
		return jq.each(function () {
			var target = $(this);
			if (!fields) {
				fields = target.datagrid("getColumnFields");
			}
			var rows = target.datagrid("getRows");
			var i = 0,
			j = 0,
			temp = {};
			for (i; i < rows.length; i++) {
				var row = rows[i];
				j = 0;
				for (j; j < fields.length; j++) {
					var field = fields[j];
					var tf = temp[field];
					if (!tf) {
						tf = temp[field] = {};
						tf[row[field]] = [i];
					} else {
						var tfv = tf[row[field]];
						if (tfv) {
							tfv.push(i);
						} else {
							tfv = tf[row[field]] = [i];
						}
					}
				}
			}
			$.each(temp, function (field, colunm) {
				$.each(colunm, function () {
					var group = this;

					if (group.length > 1) {
						var before,
						after,
						megerIndex = group[0];
						for (var i = 0; i < group.length; i++) {
							before = group[i];
							after = group[i + 1];
							if (after && (after - before) == 1) {
								continue;
							}
							var rowspan = before - megerIndex + 1;
							if (rowspan > 1) {
								target.datagrid('mergeCells', {
									index : megerIndex,
									field : field,
									rowspan : rowspan
								});
							}
							if (after && (after - before) != 1) {
								megerIndex = after;
							}
						}
					}
				});
			});
		});
	}
});

/**
 * @author 李钰龙
 * @requires jQuery,EasyUI
 * 创建一个模式化的dialog
 * @returns $.modalDialog.handler 这个handler代表弹出的dialog句柄
 * @returns $.modalDialog.xxx 这个xxx是可以自己定义名称，主要用在弹窗关闭时，刷新某些对象的操作，可以将xxx这个对象预定义好
 */
$.modalDialog = function(options) {
	var opts = $.extend({
		title : '模态窗口',
		width : 840,
		height : 680,
		modal : true,
		closable : true,
		onClose : function() {
			$(this).dialog('destroy');
		}
	}, options);
	opts.modal = true;// 强制此dialog为模式化，无视传递过来的modal参数
	return $.modalDialog.handler = $('<div/>').dialog(opts);
};

$.showMessage = function(options) {
	var msgType = !!options && !!options.msgType ? options.msgType : "warning";
	var opts = $.extend({
		msg : '此函数可以完全使用easyuiMessage的参数<br/>'
			+ '一般情况只用修改msg参数即可',
		showType: 'slide',
		width: 500,
		height: 50,
		noheader: true,
		onBeforeOpen: function(){
			if(options && options.onBeforeOpen) {
				options.onBeforeOpen();
			}
			$(this).addClass('message-body-' + msgType);
			$(this).append("<a class='message-close' href='javascript:void(0);' onclick='$.closeMessage(this)'>×</a>");
		}
	}, options);
	opts.width = opts.width < 400 ? 400 : opts.width; // 强制宽度大于400
	return $.messager.show(opts);
};

$.closeMessage = function(btn) {
	if(!!btn) {
		$(btn).parents(".panel.window").remove()
	}
};



/**
 * @author 李钰龙
 * @requires jQuery,EasyUI
 * 防止panel/window/dialog组件超出浏览器边界
 * @param left
 * @param top
 */
var easyuiPanelOnMove = function(left, top) {
	var l = left;
	var t = top;
	if (l < 1) {
		l = 1;
	}
	if (t < 1) {
		t = 1;
	}
	var width = parseInt($(this).parent().css('width')) + 14;
	var height = parseInt($(this).parent().css('height')) + 14;
	var right = l + width;
	var buttom = t + height;
	var browserWidth = $(window).width();
	var browserHeight = $(window).height();
	if (right > browserWidth) {
		l = browserWidth - width;
	}
	if (buttom > browserHeight) {
		t = browserHeight - height;
	}
	$(this).parent().css({/* 修正面板位置 */
		left : l,
		top : t
	});
};
$.fn.dialog.defaults.onMove = easyuiPanelOnMove;
$.fn.window.defaults.onMove = easyuiPanelOnMove;
$.fn.panel.defaults.onMove = easyuiPanelOnMove;


/**
 * @author 李钰龙
 * @requires jQuery
 * 改变jQuery的AJAX默认属性和方法
 */
$.ajaxSetup({
	type : 'POST',
	error : function(XMLHttpRequest, textStatus, errorThrown) {
		$.messager.progress('close');
		$.messager.alert('错误', XMLHttpRequest.responseText+"_"+errorThrown);
	}
});

/**
 * @author 李钰龙
 * @requires jQuery,EasyUI,jQuery cookie plugin
 * 更换EasyUI主题的方法
 * @param themeName 主题名称
 */
$.changeThemeFun = function(themeName) {
	var $easyuiTheme = $('#easyuiTheme');
	var url = $easyuiTheme.attr('href');
	var href = url.substring(0, url.indexOf('themes')) + 'themes/' + themeName + '/easyui.css';
	$easyuiTheme.attr('href', href);
	var $iframe = $('iframe');
	if ($iframe.length > 0) {
		for ( var i = 0; i < $iframe.length; i++) {
			var ifr = $iframe[i];
			$(ifr).contents().find('#easyuiTheme').attr('href', href);
		}
	}
	$.cookie('easyuiThemeName', themeName, {
		expires : 7
	});
};

/**
 * @author 李钰龙
 * @requires jQuery,EasyUI，My97
 * 扩展my97插件
 * 使用方法：参数和my97原本控件参数相同
 * 			class="easyui-my97"
 * 			data-options="readOnly:true,dateFmt:'yyyy-MM-dd'"
 */
$.fn.my97 = function (options, params) {
	if (typeof options == "string") {
		return $.fn.my97.methods[options](this, params);
	}
	options = options || {};
	if (!WdatePicker) {
		alert("未引入My97js包！");
		return;
	}
	return this.each(function () {
		var data = $.data(this, "my97");
		var newOptions;
		if (data) {
			newOptions = $.extend(data.options, options);
			data.opts = newOptions;
		} else {
			newOptions = $.extend({}, $.fn.my97.defaults, $.fn.my97.parseOptions(this), options);
			$.data(this, "my97", {
				options : newOptions
			});
		}
		$(this).addClass('Wdate').click(function () {
			WdatePicker(newOptions);
		});
	});
};
$.fn.my97.methods = {
	setValue : function (target, params) {
		target.val(params);
	},
	getValue : function (target) {
		return target.val();
	},
	clearValue : function (target) {
		target.val('');
	}
};
$.fn.my97.parseOptions = function (target) {
	return $.extend({}, $.parser.parseOptions(target,
		["el", "vel", "weekMethod", "lang", "skin",
		 "dateFmt", "realDateFmt", "realTimeFmt",
		 "realFullFmt", "minDate", "maxDate", "startDate", {
			doubleCalendar : "boolean",
			enableKeyboard : "boolean",
			enableInputMask : "boolean",
			autoUpdateOnChanged : "boolean",
			firstDayOfWeek : "number",
			isShowWeek : "boolean",
			highLineWeekDay : "boolean",
			isShowClear : "boolean",
			isShowToday : "boolean",
			isShowOthers : "boolean",
			readOnly : "boolean",
			errDealMode : "boolean",
			autoPickDate : "boolean",
			qsEnabled : "boolean",
			autoShowQS : "boolean",
			opposite : "boolean"
		}
	]));
};
$.fn.my97.defaults = {
	dateFmt : 'yyyy-MM-dd HH:mm:ss'
};
$.parser.plugins.push('my97');
//扩展my97日期控件结束
;
