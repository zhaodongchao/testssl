/* 作者：李钰龙
 * 功能：扩展jquery
 * 扩展项目：
 *  1、序列化form表单
 *  2、根据参数转换字符串为list
 * 10、可更换主题 
 * 11、建立图标对象数组
 * 12、扩展datagrid，使datagrid的editors能保存combotree的多选值
 */


 
/**
 * 功能：获取数值的百分数形式
 * 返回： String
 */



Number.prototype.toPercent = function(){
	return (Math.round(this * 10000)/100).toFixed(2) + '%';
};

/**
 * 功能：检测数组中是否存在指定值
 * 用法：	var arr=[" ","b"];  
 *  		alert(arr.inArray("a"));
 */
Array.prototype.inArray=function(e) {  
	var r = new RegExp(this.S+e+this.S);  
	return (r.test(this.S+this.join(this.S)+this.S));  
};


/**
 * @author 李钰龙
 * @requires jQuery
 * 注册命名空间
 * @returns object
 */
Namespace = new Object();
 
// 全局对象仅仅存在register函数，参数为名称空间全路径，如"Qianchi.MyWork"
Namespace.register = function(fullNS){
    // 将命名空间切成N部分, 比如GQianchi、MyWork等
    var nsArray = fullNS.split('.');
    var sEval = "";
    var sNS = "";
    for (var i = 0; i < nsArray.length; i++){
        if (i != 0) sNS += ".";
        sNS += nsArray[i];
        // 依次创建构造命名空间对象（假如不存在的话）的语句
        // 比如先创建Grandsoft，然后创建Qianchi.MyWork，依次下去
        if(i == nsArray.length - 1) {
        	// 最后一个节点，如果已经存在，清空一次再生成
        	sEval += sNS + " = new Object();"
        } else {
        	sEval += "if (typeof(" + sNS + ") == 'undefined') " + sNS + " = new Object();"
        }
    }
    if (sEval != "") eval(sEval);
};

/**
 * @author 李钰龙
 * 增加formatString功能
 * 使用方法：formatString('字符串{0}字符串{1}字符串','第一个变量','第二个变量');
 * @returns 格式化后的字符串
 */

$.formatString = function(str) {
	for ( var i = 0; i < arguments.length - 1; i++) {
		str = str.replace("{" + i + "}", arguments[i + 1]);
	}
	return str;
};


/**
 * @author 李钰龙
 * @requires jQuery
 * 将form表单元素的值序列化成对象
 * @returns object
 */
$.serializeObject = function(form) {
	var o = {};
	$.each(form.serializeArray(), function(index) {
		if (o[this['name']]) {
			o[this['name']] = o[this['name']] + "," + this['value'];
		} else {
			o[this['name']] = this['value'];
		}
	});
	return o;
};


/**
 * @author 李钰龙
 * 接收一个以逗号分割的字符串，返回List，list里每一项都是一个字符串
 * @returns list
 */
$.stringToList = function(value) {
	if (value != undefined && value != '') {
		var values = [];
		var t = value.split(',');
		for ( var i = 0; i < t.length; i++) {
			values.push('' + t[i]);/* 避免他将ID当成数字 */
		}
		return values;
	} else {
		return [];
	}
};

/**
 * 获取指定id或者src地址的frame内容
 * 参数：idOrSrc iframe的id或者src
 * 		inFrame 是否在iframe内调用，默认没有
 */
$.getFrameContent = function(idOrSrc, inFrame) {
	if(idOrSrc && idOrSrc != null) {
		// 先判断参数为id的情况
		if(idOrSrc.indexOf(".") > 0 || idOrSrc.indexOf("/") > 0 || idOrSrc.indexOf(":") > 0) {
			// 找不到id对应的iframe，则传递的参数应该是src
			var frames = inFrame == true ? parent.$("iframe") : $("iframe");
			for(var i=0; i<frames.size(); i++) {
				var src = $(frames[i]).attr("src");
				if(src == idOrSrc) {
					return frames[i].contentWindow;
				}
			}
		} else {
			var frame =  inFrame == true ? parent.$("iframe#" + idOrSrc) : $("iframe#" + idOrSrc);
			if(frame.length != 0) {
				return frame[0].contentWindow;
			}
		}
		return undefined;
	}
};


/**
 * 功能：选中radio单选按钮
 * 参数：
 *	  radioParentId 父级容器的id
 *	  radioName 元素name
 *	  radiovalue 值
 */
$.setRadioBoxValue = function(radioParentId, radioName, radiovalue) {
	var obj = radioParentId && radioParentId != "" ? 
			$("#" + radioParentId).find("[name=" +  radioName+ "]") : 
			$("[name=" +  radioName+ "]");
	for(var i=0; i<obj.length; i++) {
		if(obj[i].value == radiovalue) {  
			obj[i].checked = true;
			return true;
		}  
	}
};
