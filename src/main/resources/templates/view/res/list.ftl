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
                    <h4 class="panel-title">菜单管理</h4>
                </div>
                <div class="panel-body">

                    <div class="panel panel-info">
                        <div class="panel-heading">
                            <h3 class="panel-title">高级查询</h3>
                        </div>
                        <div class="panel-body">
                            <div class="form-group">
                                <select class="form-control" name="searchProperties">
                                    <option value="" >请选择查询条件</option>
                                    <option value="res_name" [#if 'res_name' ==( page.searchProperties)!'' ]selected="selected"[/#if]>资源名称</option>
                                </select>
                                <div class="input-group input-daterange">
                                    <input type="text" class="form-control" name="searchValue" value="${page.searchValue!''}" />
                                </div>
                            </div>
                            <button type="submit" class="btn btn-default">查询</button>
                        </div>
                    </div>
                    <div class="panel panel-default actionPanel">
                        <div class="row m-l-1 ">
                        [@shiro.hasPermission name = "system:menu:save"]
                            <a href="add" class="btn btn-sm btn-success">添加菜单</a>
                        [/@shiro.hasPermission]
                        </div>
                    </div>
                    <table class="table table-bordered table-striped">
                            <thead>
                            <tr>
                                <th width="70">序号</th>
                                <th>菜单名称</th>
                                <th>权限标识</th>
                                <th>菜单URL</th>
                                <th>创建时间</th>
                                <th>更新时间</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody>

                            [#list page.records as item]
                                <tr>
                                    <td width="70" align="center">${item_index+1}</td>
                                    <td>${item.resName!''}</td>
                                    <td>${item.code!''}</td>
                                    <td>${item.url}</td>
                                    <td>${(item.createTime?string("yyyy-MM-dd hh:MM:ss"))!''}
                                    <td>${(item.updateTime?string("yyyy-MM-dd hh:MM:ss"))!''}
                                    <td>
                                    [@shiro.hasPermission name = "system:menu:edit"]
                                        <a href="edit?id=${item.id}"><li class="fa  fa-edit">编辑</li></a>
                                    [/@shiro.hasPermission]
                                    [@shiro.hasPermission name = "system:menu:del"]
                                        <a href="javascript:void(0)" class="delete" id="${item.id}"><li class="fa fa-trash">删除</li></a>
                                    [/@shiro.hasPermission]

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

<script type="application/javascript" >
    [@flash_message /]
    $(function () {
        $(".delete").click(function () {
           var  id =  $(this).attr("id");
            alertServer.cofirm("确认删除","删除",function (flag) {
                if(flag){
                    Ajax.Get("${basePath}/resource/del/"+id).done(function (res) {
                        window.location.reload();
                    }).fail(function (err) {
                        alertServer.error(err);
                    });
                }
            });
        });
    })
</script>