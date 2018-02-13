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
                    <h4 class="panel-title">添加资源</h4>
                </div>
                <div class="panel-body">
                    <form class="form-horizontal" action="save"   method="post">

                        <div class="form-group">
                            <label class="col-md-1 control-label">父级资源</label>
                            <div class="col-md-6">
                                <select  name="parentId" class="form-control" >
                                    <option value="">请选择</option>
                                [#list meunList as menu]
                                    <option value="${menu.id}">${menu.resName}</option>
                                [/#list]
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-1 control-label">资源名称</label>
                            <div class="col-md-6">
                                <input type="text" name="resName" class="form-control" placeholder="资源名称" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-1 control-label">资源标识</label>
                            <div class="col-md-4">
                                <input type="text" name="code" class="form-control" placeholder="资源标识" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-1 control-label">资源URL</label>
                            <div class="col-md-4">
                                <input type="text" name="url" class="form-control" placeholder="资源URL"  />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-1 control-label">是否启用</label>
                            <div class="col-md-4">
                                <label class="radio-inline">
                                    <input type="radio" name="enable" value="1" required  checked="checked"/>
                                    启用
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="enable" value="0" required/>
                                    禁用
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-1 control-label">资源类型</label>
                            <div class="col-md-4">
                                <label class="radio-inline">
                                    <input type="radio" name="type" value="0" required checked="checked"/>
                                    菜单资源
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="type" value="1" required/>
                                    按钮资源
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

