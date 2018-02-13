<!-- begin #content -->
<!-- ================== BEGIN BASE CSS STYLE ================== -->
[#include "../../include.ftl"]
<div id="content" class="content">
    <form id="listForm" action="list" class="form-inline" >
        <div class="row">
        <!-- begin col-12 -->
        <div class="col-md-12">
            <!-- begin panel -->
            <div class="panel panel-inverse" data-sortable-id="table-basic-7">
                <div class="panel-heading">
                    <h4 class="panel-title">流程信息</h4>
                </div>
                <div class="panel-body">
                    <div class="panel panel-default actionPanel">
                        [#--操作栏--]
                    </div>
                    <table class="table table-bordered table-striped">
                        <thead>
                        <tr>
                            <th width="70">序号</th>
                            <th>流程分类</th>
                            <th>模型标识</th>
                            <th>流程名称</th>
                            <th>版本号</th>
                            <th>流程XML</th>
                            <th>流程图片</th>
                            <th>部署时间</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        [#list  page.records as item]
                            <tr>
                                <td width="70" align="center">${item_index+1}</td>
                                <td>${item.category!''}</td>
                                <td>${item.key!''}</td>
                                <td>${item.name!''}</td>
                                <td>${item.revision!''}</td>
                                <td>${item.xmlName}</td>
                                <td>${item.picName}</td>
                                <td>${(item.deploymentTime?string("yyyy-MM-dd hh:MM:ss"))!''}</td>
                                <td>
                                    [#if item.suspend]
                                        <a href="${base}/workflow/process/status?procDefId=${item.processonDefinitionId}&status=active" ><i class="fa fa-1x fa-play-circle">激活</i></a>
                                    [#else]
                                        <a href="${base}/workflow/process/status?procDefId=${item.processonDefinitionId}&status=suspend" ><i class="fa fa-1x fa-pause">挂起</i></a>
                                    [/#if]
                                </td>
                            </tr>
                        [/#list]
                        </tbody>
                    </table>

                    [@pagination pageNumber = page.current totalPages = page.pages]
                    [#include "../../pagination.ftl"]
                    [/@pagination]


                </div>
            </div>
            <!-- end panel -->
        </div>
        <!-- end col-12 -->
    </div>
    </form>
    <!-- end row -->
</div>




<script type="application/javascript">

    $(function () {
        $(".delete").click(function () {
            var  id =  $(this).attr("id");
            alertServer.cofirm("确认删除","删除",function (flag) {
                if(flag){
                    Ajax.Get("${base}/workflow/model/delete/"+id).done(function (res) {
                        window.location.reload()
                    }).fail(function (err) {
                        swal("错误", '操作失败', "error")
                    })
                }
            });
        });
    })
</script>
