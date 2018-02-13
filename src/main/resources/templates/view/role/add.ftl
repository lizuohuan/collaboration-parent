<!-- begin #content -->
<!-- ================== BEGIN BASE CSS STYLE ================== -->
[#include "../../include.ftl"]
<!-- begin #content -->
<div id="content" class="content">
    <!-- begin row -->
    <div class="row">
        <!-- begin col-6 -->
        <div class="col-md-12">
            <!-- begin panel -->
            <div class="panel panel-inverse" data-sortable-id="form-stuff-1">
                <div class="panel-heading">
                    <h4 class="panel-title">添加角色</h4>
                </div>
                <div class="panel-body">
                    <form class="form-horizontal" action="save"   method="post">
                        <input type="hidden" name="id" value="${(role.id)!''}">
                        <div class="form-group">
                            <label class="col-md-1 control-label">角色名称</label>
                            <div class="col-md-6">
                                <input type="text" name="roleName" class="form-control" placeholder="角色名称"  value="${(role.roleName)!''}"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-1 control-label">角色描述</label>
                            <div class="col-md-6">
                                <input type="text" name="roleDesc" class="form-control" placeholder="角色名称" value="${(role.roleDesc)!''}"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-1 control-label">是否启用</label>
                            <div class="col-md-4">
                                <label class="radio-inline">
                                    <input type="radio" name="enable" value="0" checked />
                                    启用
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="enable" value="1" />
                                   禁用
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-4 control-label"></label>
                            <div class="col-md-6">
                                <button type="submit" class="btn btn-success m-r-5 m-b-5">保存</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <!-- end panel -->
        </div>
        <!-- end col-6 -->

    </div>

</div>

