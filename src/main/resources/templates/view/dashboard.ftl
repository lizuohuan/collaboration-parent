[#include "../include.ftl"]
<div id="content" class="content">

    <div class="panel panel-inverse">
        <div class="panel-heading">

            <h4 class="panel-title">Panel Title here</h4>
        </div>
        <div class="panel-body">
            <h3>通用上传demo</h3>
            <button  id="files">上传图片</button>

        </div>


        <div class="panel-body">
            <h3>通知demo</h3>
            <a href="javascript:Notify.success('成功提示');">成功提示</a>
            <a href="javascript:Notify.info('提示提示');">提示提示</a>
            <a href="javascript:Notify.warning('警告提示');">警告提示</a>
            <a href="javascript:Notify.danger('错误提示');">错误提示</a>

        </div>

        <div class="panel-body">
            <h3>editor 搭配图片服务器使用</h3>
            <script id="editor" type="text/plain" style="width:1024px;height:300px;"></script>
        </div>


    </div>

</div>

<script type="application/javascript">
    $().ready(function () {
        var ue = UE.getEditor('editor');
        $("#files").uploadFile({
            path:"Test/image",
            imageService: Global.imageService,
            uploadUrl: "/upload/images",
            callback:function(data) {
                console.log(data)
            }
        })
    })
</script>
<!-- end #content -->

