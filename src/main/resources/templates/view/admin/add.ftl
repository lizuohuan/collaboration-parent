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
                    [#if admin??]
                        <h4 class="panel-title">编辑管理员</h4>
                    [#else ]
                        <h4 class="panel-title">添加管理员</h4>
                    [/#if ]
                </div>
                <div class="panel-body">
                    <form class="form-horizontal" action="save"   method="post">
                        <input type="hidden" name="id" value="${(admin.id)!''}">
                        <div class="form-group">
                            <label class="col-md-1 control-label">用户名</label>
                            <div class="col-md-4">
                                <input type="text" name="username" class="form-control" placeholder="用户名"  value="${(admin.username)!''}"/>
                            </div>
                        </div>
                        [#if !admin?? ]
                            <div class="form-group">
                                <label class="col-md-1 control-label">密码</label>
                                <div class="col-md-4">
                                    <input type="password" name="password" class="form-control" placeholder="密码" value="${(admin.password)!''}"/>
                                </div>
                            </div>
                        [/#if]

                        <div class="form-group">
                            <label class="col-md-1 control-label">角色</label>
                            <div class="col-md-4">
                                <select name="roles" class="selectpicker" multiple>
                                    [#list  allRole as role]
                                        [#if adminRoles??]
                                            [#list adminRoles as item]
                                                 <option value="${role.id}" [#if role.id == item ] selected="selected" [/#if]  >${role.roleName} </option>
                                            [/#list]
                                        [#else]
                                            <option value="${role.id}" >${role.roleName}</option>
                                        [/#if]
                                    [/#list]
                                </select>
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

