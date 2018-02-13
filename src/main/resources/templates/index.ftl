<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8"/>
    <title id="page-title">魔豆通用管理后台</title>
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport"/>
    <meta content="" name="description"/>
    <meta content="" name="author"/>

[#include "include.ftl"]
[#include "menu.ftl"]
</head>
<body>

<!-- begin #page-container -->
<div id="page-container" class="fade page-sidebar-fixed page-header-fixed">
    <!-- begin #header -->
    <div id="header" class="header navbar navbar-default navbar-fixed-top">
        <!-- begin container-fluid -->
        <div class="container-fluid">
            <!-- begin mobile sidebar expand / collapse button -->
            <div class="navbar-header">
                <a href="index.html" class="navbar-brand"><span class="navbar-logo"></span> 魔豆互动通用管理后台</a>
                <button type="button" class="navbar-toggle" data-click="sidebar-toggled">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
            </div>
            <!-- end mobile sidebar expand / collapse button -->

            <!-- begin header navigation right -->
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown navbar-user">
                    <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown">
                        <img src="${basePath}/assets/img/user-13.jpg" alt=""/>
                        <span class="hidden-xs">
                        [@shiro.principal property="username" /]
                       </span> <b class="caret"></b>
                    </a>
                    <ul class="dropdown-menu animated fadeInLeft">
                        <li class="arrow"></li>
                        <li><a href="${basePath}/logout">退出</a></li>
                    </ul>
                </li>
            </ul>
            <!-- end header navigation right -->
        </div>
        <!-- end container-fluid -->
    </div>
    <!-- end #header -->

    <!-- begin #sidebar -->
    <div id="sidebar" class="sidebar">
        <!-- begin sidebar scrollbar -->
        <div data-scrollbar="true" data-height="100%">
            <!-- begin sidebar user -->
            <ul class="nav">
                <li class="nav-header">菜单</li>
                [@menu children = menus/]
                <!--gin sidebar minify button -->
                <li><a href="javascript:;" class="sidebar-minify-btn" data-click="sidebar-minify"><i class="fa fa-angle-double-left"></i></a></li>
            </ul>
            <!-- end sidebar nav -->
        </div>
        <!-- end sidebar scrollbar -->
    </div>
    <div class="sidebar-bg"></div>
    <!-- end #sidebar -->



    <!-- end #sidebar -->

    <!-- begin #ajax-content -->
    <iframe id="iFrameContent" onload="resizeHeight()" style="padding-left: 200px;" src="${basePath}/dashboard" width="100%" frameborder="0" ></iframe>
    <!-- end #ajax-content -->

    <!-- begin scroll to top btn
    <a href="javascript:;" class="btn btn-icon btn-circle btn-success btn-scroll-to-top fade" data-click="scroll-top"><i
            class="fa fa-angle-up"></i></a>
    <!-- end scroll to top btn -->
</div>
<!-- end page container -->
<script>
    var secthei = document.documentElement.clientHeight || document.body.clientHeight;
    var headerh = 68;
    //        document.getElementById('sect').style.height = (secthei-headerh) + "px";
    document.getElementById("iFrameContent").style.height = (secthei-headerh) + "px";
    function resizeHeight() {
        var ifm= document.getElementById("iFrameContent");
        var subWeb = document.frames ? document.frames["iFrameContent"].document : ifm.contentDocument;
        if (ifm != null && subWeb != null) {
            ifm.height = subWeb.body.scrollHeight;
        }
    }

    $(document).ready(function () {
        App.init();
        $(".menu-item").click(function () {
            $("#iFrameContent").attr("src", $(this).attr("href"))
            return false;
        })
        Ajax.setBaseUrl('${basePath}')
        var client = WebSocketClient.createConnect("${basePath}/web")
        client.registerEventListener(WebSocketClient.EventType.OPEN,function (socket, data) {
            client.sendGlobalMessage("adasdasd")
        })
    });
</script>
</body>
</html>
