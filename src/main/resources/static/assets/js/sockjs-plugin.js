/**
 * 进行websocket连接
 * @param url
 * @constructor
 */
var  WebSocketClient={
    topics:{},
    EventType:{
        OPEN:"OPEN",
        CLOSE:"CLOSE"
    },
    createConnect:function (url) {
        this.popWindow = new Pop("","","");
        this.sock = new SockJS(url);
        this.sock.onmessage = this._onMessage;
        this.sock.onopen = this._onOpen;
        return this;
    },
    _getPopWindow:function () {
      return this.popWindow;
    },
    _getSocket:function () {
        return this.sock;
    },
    _onMessage:function (message) {
        var jsonData = JSON.parse(message.data);
        if(jsonData.event == "global"){
            WebSocketClient._getPopWindow().setContent("温馨提示","",jsonData.body);
        }else{
            WebSocketClient.dispatherEvent(jsonData.event,jsonData.body);
        }
    },
    _onOpen:function () {
        WebSocketClient.dispatherEvent(WebSocketClient.EventType.OPEN)
    },
    sendEventMessage:function (event, message) {
        WebSocketClient._getSocket().send(JSON.stringify({event:event,body:message}));
    },
    sendGlobalMessage:function (message) {
        WebSocketClient._getSocket().send(JSON.stringify({event:"global",body:message}));
    },
    registerEventListener:function (event, listener) {
        if(!this.topics.hasOwnProperty(event)) {
            this.topics[event] = [];
        }
        this.topics[event].push(listener);
    },
    dispatherEvent:function (event,info) {
        if (this.topics.hasOwnProperty(event)) {
            this.topics[event].forEach(function(handler) {
                handler(info ? info : {});
            })
        }
    }


}




