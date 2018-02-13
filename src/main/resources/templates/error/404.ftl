<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title> 404 错误</title>
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
    <meta content="" name="description" />
    <meta content="" name="author" />
    [#include "../include.ftl"]
</head>
<body class="pace-top">
<!-- begin #page-loader -->
<div id="page-loader" class="fade in"><span class="spinner"></span></div>
<!-- end #page-loader -->

<!-- begin #page-container -->
<div id="page-container" class="fade">
    <!-- begin error -->
    <div class="error">
        <div class="error-code m-b-10">404<i class="fa fa-warning"></i></div>
        <div class="error-content">
            <div class="error-message">找不到路径</div>
            <div class="error-desc m-b-20">

            </div>
            <div>
                <a href="javascript:window.history.back()" class="btn btn-success" >返    回</a>
            </div>
        </div>
    </div>
    <!-- end error -->

    <!-- begin scroll to top btn -->
    <a href="javascript:;" class="btn btn-icon btn-circle btn-success btn-scroll-to-top fade" data-click="scroll-top"><i class="fa fa-angle-up"></i></a>
    <!-- end scroll to top btn -->
</div>
<!-- end page container -->


<script>
    $(document).ready(function() {
        App.init();
    });
</script>
</body>
</html>
