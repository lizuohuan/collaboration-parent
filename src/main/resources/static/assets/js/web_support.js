/**
 * load jquery-2.0.2.min.js first
 * Author: Zhang Qi
 */


String.prototype.trim=function()
{
     return this.replace(/(^\s*)|(\s*$)/g, '');
};

var encode = function(str)
{
		return encodeURIComponent(str);
};



var getFullUrl = function(url) {
	var contextPath = window.location.pathname.split("/")[1];
	if(contextPath!="BaseServer")
	{
		return url;
	}
	return "/" + contextPath + url;
};
// 动态加载javascript
var load = function(url, options) {
	options = $.extend(options || {}, {
		dataType : "script",
		cache : true,
		url : url,
		async : false
	});
	return jQuery.ajax(options);
};
var loadHtml = function(url, options) {
	options = $.extend(options || {}, {
		dataType : "html",
		cache : false,
		url : url,
		async : false
	});
	return jQuery.ajax(options);
};

// find the top window
var findTopWindow = function(currentWindow) {
	if (currentWindow.parent == currentWindow) {
		return currentWindow;
	} else {
		return findTopWindow(currentWindow.parent);
	}

};



//get the window object of the centerFrame
var GetCenterFrame=function(){
	
	var topWindow = findTopWindow(window);
	var index = topWindow._getSelectTabIndex();
	var centerWindow =topWindow.frames[index];
	return centerWindow;
};

var validate = function(){
	var validate_reslut =true;
	$(".easyui-validatebox").each(function(){
		if(!$(this).validatebox("isValid"))
		{
			validate_reslut=false;
		}
	});
	return validate_reslut;
};

/**
 * 处理服务器返回的树形节点
 */
var parseChildren = function(data,topNodeId) {
	if (data.childSize > 0 && data.children.length == 0) {
		data.state = "closed";
	}
	if(data.children&&data.children.length>0)
	for ( var i = 0; i < data.children.length; i++) {
		parseChildren(data.children[i]);
	}
};

var treeResolver=function(data,topNodeId)
{
	var result =[];
	parseChildren(data);
	if(data.id==topNodeId)
	{
		result.push(data);
	}else if(data instanceof Array){
		result = data;
	}else
	{
		result=data.children;
	}
   	return result;
};

//文档载入后执行
$(function(){
	if($('._datagrid').length!=0){
		$(window).resize(function(par) {
			$('._datagrid').datagrid("resize",{width:par.currentTarget.innerWidth});
		});
	}
});





Date.prototype.format = function(format) {
	/*
	 * eg:format="yyyy-MM-dd hh:mm:ss";
	 */
	if (!format) {
		format = "yyyy-MM-dd hh:mm:ss";
	}

	var o = {
		"M+" : this.getMonth() + 1, // month
		"d+" : this.getDate(), // day
		"h+" : this.getHours(), // hour
		"m+" : this.getMinutes(), // minute
		"s+" : this.getSeconds(), // second
		"q+" : Math.floor((this.getMonth() + 3) / 3), // quarter
		"S" : this.getMilliseconds()
	// millisecond
	};
	if (/(y+)/.test(format))
		format = format.replace(RegExp.$1, (this.getFullYear() + "")
				.substr(4 - RegExp.$1.length));
	for ( var k in o)
		if (new RegExp("(" + k + ")").test(format))
			format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k]
					: ("00" + o[k]).substr(("" + o[k]).length));
	return format;
};


if($.fn.validatebox)
{
	$.extend($.fn.validatebox.defaults.rules, {  
	    equals: {  
	        validator: function(value,param){  
	            return value == $(param[0]).val();  
	        },  
	        message: '两次输入信息不匹配'  
	    },
	    maxLength: {   
	        validator: function(value, param){  
	        	
	            return value.length <= param[0];   
	        },   
	        message: '请不要输入超过 {0} 个字符.'  
	    }   
	});
}

CodeTableUtils={
		init:function($containter,tableName,selfOptions)
		{
			var opts = { 
					method:"GET",
				    url:getFullUrl("/api/code_table/loadCodeTable?codeTableName="+tableName),   
				    valueField:'codeTableItemCode',   
				    textField:'codeTableItemName',
				    panelHeight:"auto"
				};
			opts = $.extend(opts,selfOptions||{});
			
			$containter.combobox(opts);
		}
};


var LoadingUtils = {
		Open:function(){
			var top=  $(this).offset()==undefined?0:$(this).offset().top;
			var left=  $(this).offset()==undefined?0:$(this).offset().left;
			var appender=null;

			if($(this).parent().length==0)
			{
				appender="body";
			}else
			{
				appender=$(this);
			}
//查找出顶级元素具有绝对定位的元素
			
			function find(a)
			{
				if(a.parent().length==0||a.is("body")==true)
					return null;
				if(a.parent().css("position")=="absolute")
				{
					var _f = a.parent().offset();
					return _f;
				}
				return find(a.parent());
			}
			var _offset = find(appender);
			if(_offset!=null)
			{
				left = left -_offset.left;
			}
			
			$("<div class=\"mask\"></div>").css({
				display : "block",
				width : $(this).outerWidth(),//100%
				height : $(this).outerHeight(),//height
				top:top,
				left:left
			}).appendTo(appender);//body
			
			$("<div class=\"mask-msg\"></div>").html("正在处理，请稍候...").appendTo(appender).css({
				display : "block",
				left : ($(this).outerWidth()-153) / 2+left,
				top :  ($(this).outerHeight()-42) / 2+top
			});
		},
		Close:function(){
			$(".mask").remove();
			$(".mask-msg").remove();
		}
};