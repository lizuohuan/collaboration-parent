<!-- begin #content -->
<!-- ================== BEGIN BASE CSS STYLE ================== -->
[#include "../../include.ftl"]



<div id="content" class="content">
    <form id="listForm" action="list" class="form-inline">
        <div class="row">
            <!-- begin col-12 -->
            <div class="col-md-12">
                <!-- begin panel -->
                <div class="panel panel-inverse" data-sortable-id="table-basic-7">
                    <div class="panel-heading">
                        <h4 class="panel-title">角色管理</h4>
                    </div>
                    <div class="panel-body">

                        <div class="panel panel-info">
                            <div class="panel-heading">
                                <h3 class="panel-title">高级查询</h3>
                            </div>
                            <div class="panel-body">
                                <div class="form-group">
                                    <select class="form-control" name="searchProperties">
                                        <option value="">请选择查询条件</option>
                                        <option value="role_name"
                                                [#if 'role_name' ==( page.searchProperties)!'' ]selected="selected"[/#if]>
                                            角色名称
                                        </option>
                                    </select>
                                    <div class="input-group input-daterange">
                                        <input type="text" class="form-control" name="searchValue"
                                               value="${page.searchValue!''}"/>
                                    </div>
                                </div>
                                <button type="submit" class="btn btn-default">查询</button>
                            </div>
                        </div>
                        <div class="panel panel-default actionPanel">
                            <div class="row m-l-1 ">
                            [@shiro.hasPermission name = "system:role:save"]
                                <a href="${basePath}/role/toAdd" class="btn btn-sm btn-success">添加角色</a>
                            [/@shiro.hasPermission]

                            </div>
                        </div>
                            <table class="table table-bordered table-striped">
                                <thead>
                                <tr>
                                    <th width="70">序号</th>
                                    <th>名称</th>
                                    <th>描述</th>
                                    <th>是否启用</th>
                                    <th>创建时间</th>
                                    <th>更新时间</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody>

                                [#list page.records as item]
                                <tr>
                                    <td width="70" align="center">${item_index+1}</td>
                                    <td>${item.roleName!''}</td>
                                    <td>${item.roleDesc!''}</td>
                                    <td>${(item.enable==0)?string("启用","禁用")}</td>
                                    <td>${(item.createTime?string("yyyy-MM-dd hh:MM:ss"))!''}
                                    <td>${(item.updateTime?string("yyyy-MM-dd hh:MM:ss"))!''}
                                    <td>
                                    [#if item.system?? && item.system]
                                        [@shiro.hasPermission name = "system:role:edit"]
                                            <a href="edit?id=${item.id}">
                                                <li class="fa fa-edit">编辑</li>
                                            </a>
                                        [/@shiro.hasPermission]
                                    [/#if]
                                        [@shiro.hasPermission name = "system:role:del"]
                                            <a href="javascript:void(0)" class="delete" id="${item.id}" >
                                                <li class="fa fa-trash">删除</li>
                                            </a>
                                        [/@shiro.hasPermission]
                                        [@shiro.hasPermission name = "system:role:distribution"]
                                            <a href="javascript:void(0)" class="distribution" id="${item.id}">
                                                <li class="fa  fa-unlock-alt">分配权限</li>
                                            </a>
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


<div class="modal fade" id="func-modal-dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">分配权限</h4>
            </div>
            <input type="hidden" name="selectRole" id="selectRole">
            <div class="modal-body">
                <div id="jstree-checkable"></div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-sm btn-white" data-dismiss="modal">关闭</button>
                <button  id="saveRole" class="btn btn-sm btn-success">保存</button>
            </div>
        </div>
    </div>
</div>


<script type="application/javascript">
    [@flash_message /]

    $(function () {
        /**
         *删除按钮
         */
        $(".delete").click(function () {
            var  id =  $(this).attr("id");
            alertServer.cofirm("确认删除","删除",function (flag) {
                if(flag){
                    Ajax.Get("${basePath}/role/del/" + id).done(function (res) {
                        window.location.reload()
                    }).fail(function (err) {
                        alertServer.error(err)
                    })
                }
            });
        });

        /**
         * 打开分配权限面板
         */
        $(".distribution").click(function () {
            var  roleId =  $(this).attr("id");
            $("#selectRole").val(roleId)
            $('#jstree-checkable').jstree('destroy');
            $("#func-modal-dialog").modal()
            Ajax.Get("${basePath}/resource/all").done(function (res) {
                $('#jstree-checkable').on('ready.jstree', function (e) {

                    Ajax.Get("${basePath}/resource/selectRoleResource/" + roleId).done(function (data) {
                        $('#jstree-checkable').jstree('deselect_all', true);
                        $.each(data, function (index, item) {
                            if ($('#jstree-checkable').jstree(true).is_leaf(item.id) == true) {
                                $('#jstree-checkable').jstree('check_node', item.id)
                            }
                        })
                        $('#jstree-checkable').jstree('open_all');
                    })

                }).jstree({
                    'plugins': ["wholerow", "checkbox", "types"],
                    'core': {
                        "themes": {
                            "responsive": false
                        },
                        'data': [res]
                    },
                    'state': {
                        "undetermined": true
                    },
                    "types": {
                        "default": {
                            "icon": "fa fa-folder text-primary fa-lg"
                        },
                        "file": {
                            "icon": "fa fa-file text-success fa-lg"
                        }
                    }
                });
            });
        });

        /**
         * 保存权限
         */
        $("#saveRole").click(function () {
            var selectedElmsIds = $('#jstree-checkable').jstree("get_selected");
            var spliceIndex = $.inArray('-1L', selectedElmsIds);
            if (spliceIndex > 0){
                selectedElmsIds.splice(spliceIndex , 1);
            }
            $("#jstree-checkable").find(".jstree-undetermined").each(function (i, element) {
                var id = $(element).closest('.jstree-node').attr("id");
                if ("-1L" != id) {
                    selectedElmsIds.push(id);
                }
            });
            var data = {res: selectedElmsIds, role: $("#selectRole").val()}
            Ajax.Post("${basePath}/role/saveResource", JSON.stringify(data)).done(function (res) {
                alertServer.success("操作成功")
                $("#func-modal-dialog").modal('hide');
            });
        });
    })

</script>