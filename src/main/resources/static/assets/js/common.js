var Global = {
    imageService : 'http://139.129.111.76:5888/'
}

var alertServer = alertServer||{}

alertServer.cofirm = function (text,confirmText,fun) {
    swal({
            title: "提示",
            text: text,
            type: "warning",
            showCancelButton: true,
            confirmButtonColor: "#DD6B55",
            confirmButtonText: confirmText,
            cancelButtonText: "取消",
            closeOnConfirm: true,
        },
       fun);
}

alertServer.error= function (text) {
    swal("错误", text, "error")
}

alertServer.success = function (text) {
    swal("成功", text, "success")
}

/**
 * 通知消息
 * @type {{success: Notify.success, info: Notify.info, waring: Notify.waring, danger: Notify.danger, _notify: Notify._notify}}
 */
var Notify={
    success:function (message) {
        this._notify("success",message);
    },
    info:function (message) {
      this._notify("info",message);
    },
    warning:function (message) {
      this._notify("warning",message);
    },
    danger:function (message) {
        this._notify("danger",message);
    },
    message:function (type, message) {
        this._notify(type,message);
    },
    _notify:function (type,message) {
        $.notify({
            message:message
        },{
            type: type,
            delay:2000,
            timer: 1000,
            animate: {
                enter: 'animated fadeInDown',
                exit: 'animated fadeOutUp'
            },
        });
    }
}

var Ajax = Ajax||{}
Ajax.setBaseUrl  = function (url) {
    this.baseUrl = url;
}
Ajax.ajax = function ajax(url, param, type) {
    return $.ajax({
        url: url,
        data: param || {},
        type: type || 'GET',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
    });
}
Ajax.ajaxSend =function(url, param, type) {
    return Ajax.ajax(url, param, type).then(function(resp){
        // 成功回调
        if(resp.status){
            return resp.body; // 直接返回要处理的数据，作为默认参数传入之后done()方法的回调
        }
        else{
            return $.Deferred().reject(resp.msg); // 返回一个失败状态的deferred对象，把错误代码作为默认参数传入之后fail()方法的回调
        }
    }, function(err){
        // 失败回调
        return $.Deferred().reject("操作失败 错误码"+err.status);
    });
}

Ajax.Get = function (url) {
   return Ajax.ajaxSend(url,null,'GET')
}

Ajax.Post = function (url, params) {
    return Ajax.ajaxSend(url,params,'POST')
}




