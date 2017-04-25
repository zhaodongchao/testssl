$(function(){
		   closepop();
			$("div.popup_layout_content a[rel='close']").click( function() {
				
				$(this).closest(".popup").addClass("hide");
				
			
			});
		   
		   
			
			
		   
		   });

function openpop(popname, popupiframe) {
	$("#" + popname).removeClass("hide");
	//$("#" + popname).show().css('height', $("body").height() + 'px');
	var scrollTop =  document.documentElement.scrollTop || document.body.scrollTop;
	_windowHeight = $(window).height(),//获取当前窗口高度 
	_popupHeight =$("#" + popname).find(".popup_layout_content").innerHeight(),//获取弹出层高度 
	_posiTop = (_windowHeight - _popupHeight)/2 + scrollTop - 150; 
	var _bodyheight =  $("body").height();
	iframe_height = _windowHeight>_bodyheight?_windowHeight:_bodyheight;
	
	$("#" + popname + " .popup_layout_content").show().css('top',_posiTop + 'px');
	$("#" + popupiframe).css('height', iframe_height + 'px');
	
	$(window).resize(function() {
				var scrollTop =  document.documentElement.scrollTop || document.body.scrollTop;
				_windowHeight = $(window).height(),//获取当前窗口高度 
				_popupHeight =$("#" + popname).find(".popup_layout_content").innerHeight(),//获取弹出层高度 
				_posiTop = (_windowHeight - _popupHeight)/2 + scrollTop - 150; 
				
				$("#" + popname + " .popup_layout_content").show().css('top',_posiTop + 'px');
				$("#" + popupiframe).css('height', iframe_height + 'px');
			});
			//当滚动条发生改变的时候
	$(window).scroll(function() {
		var scrollTop =  document.documentElement.scrollTop || document.body.scrollTop;
		_windowHeight = $(window).height(),//获取当前窗口高度 
		_popupHeight =$("#" + popname).find(".popup_layout_content").innerHeight(),//获取弹出层高度 
		_posiTop = (_windowHeight - _popupHeight)/2 + scrollTop - 150; 
		
		$("#" + popname + " .popup_layout_content").show().css('top',_posiTop + 'px');
		$("#" + popupiframe).css('height', iframe_height + 'px');
	});	
	

}

function closepop() {
	$(".popup").addClass("hide");
	
};
//json字符串格式化
$.fn.serializeObject = function(){    
   var o = {};    
   var a = this.serializeArray();    
   $.each(a, function() {    
       if (o[this.name]) {    
           if (!o[this.name].push) {    
               o[this.name] = [o[this.name]];    
           }    
           o[this.name].push(this.value || '');    
       } else {    
           o[this.name] = this.value || '';    
       }    
   });    
   return o;    
}; 

function question_word_show(msg,fc){
	$("#popup_312 .question_word").empty();
	$("#popup_312 .question_word").append(msg);
	openpop('popup_312', 'popup_iframe_312');
	question_word_click(fc);
};
function question_word_click(fc){
	if(fc==null){
		$("#question_word_em_id").attr("onclick","");
		return null;
	}
	$("#question_word_em_id").attr("onclick",fc);
};
function exclamation_word_show(msg,fc){
	$("#popup_313 .exclamation_word").empty();
	$("#popup_313 .exclamation_word").append(msg);
	openpop('popup_313', 'popup_iframe_313');
	exclamation_word_click(fc);
};
function exclamation_word_click(fc){
	if(fc==null){
		$("#exclamation_word_em_id").attr("onclick","");
		return null;
	}
	$("#exclamation_word_em_id").attr("onclick",fc);
};
function error_word_show(msg,fc){
	$("#popup_314 .error_word").empty();
	$("#popup_314 .error_word").append(msg);
	openpop('popup_314', 'popup_iframe_314');
	error_word_click(fc);
};
function error_word_click(fc){
	if(fc==null){
		$("#error_word_em_id").attr("onclick","");
		return null;
	}
	$("#error_word_em_id").attr("onclick",fc);
};
function onLoading_show(){
	openpop('popup_315', 'popup_iframe_315');
};