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
                    <h4 class="panel-title">模型管理</h4>
                </div>
                <div class="panel-body">
                    <div class="panel panel-default actionPanel">
                        <div class="row m-l-1 ">
                            <a href="${base}/workflow/model/add" class="btn btn-sm btn-success" >添加模型</a>
                        </div>
                    </div>
                    <table class="table table-bordered table-striped">
                        <thead>
                        <tr>
                            <th width="70">序号</th>
                            <th>流程分类</th>
                            <th>模型ID</th>
                            <th>模型标识</th>
                            <th>模型名称</th>
                            <th>版本号</th>
                            <th>创建时间</th>
                            <th>更新时间</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        [#list  page.records as item]
                            <tr>
                                <td width="70" align="center">${item_index+1}</td>
                                <td>${item.category!''}</td>
                                <td>${item.id!''}</td>
                                <td>${item.key!''}</td>
                                <td>${item.name!''}</td>
                                <td>${item.version!''}</td>
                                <td>${(item.createTime?string("yyyy-MM-dd hh:MM:ss"))!''}</td>
                                <td>${(item.lastUpdateTime?string("yyyy-MM-dd hh:MM:ss"))!''}</td>
                                <td>
                                    <a href="${base}/assets/plugins/activiti/modeler.html?modelId=${item.id}" target="_blank"><li class="fa  ">流程设计</li></a>
                                    <a href="javascript:void (0)" class="delete" id="${item.id}" ><li class="fa fa-trash">删除</li></a>
                                    <a href="${base}/workflow/model/deploy/${item.id}" ><li class="fa  ">部署</li></a>
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
