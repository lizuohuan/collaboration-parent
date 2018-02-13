<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>Color Admin | Login Page</title>
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
    <meta content="" name="description" />
    <meta content="" name="author" />
[#include "include.ftl"]
</head>
<body class="pace-top">
<div class="login-cover">
    <div class="login-cover-image"><img src="${basePath}/assets/img/login-bg/bg-1.jpg" data-id="login-cover-image" alt="" /></div>
</div>
<!-- begin #page-container -->
<div id="page-container" class="fade">
    <!-- begin login -->
    <div class="login login-v2" data-pageload-addclass="animated fadeIn">
        <!-- begin brand -->
        <div class="login-header">
            <div class="brand">
                <span class="logo"></span>魔豆互动通用管理后台
            </div>
        </div>
        <!-- end brand -->
        <div class="login-content">
            <form action="login" method="post" class="margin-bottom-0">
                <div class="form-group m-b-20">
                    <input type="text" name="username" class="form-control input-lg" placeholder="用户名" />
                </div>
                <div class="form-group m-b-20">
                    <input type="password" name="password" class="form-control input-lg" placeholder="密码" />
                </div>
                <div class="login-buttons">
                    <button type="submit" class="btn btn-success btn-block btn-lg">登录</button>
                </div>
            </form>
        </div>
    </div>
    <!-- end login -->
</div>
<!-- end page container -->
<script>
    $(document).ready(function() {
        App.init(ajax=true);
    });
</script>
</body>
</html>
