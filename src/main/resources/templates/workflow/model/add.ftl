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
                    [#if model??]
                        <h4 class="panel-title">编辑模型</h4>
                    [#else ]
                        <h4 class="panel-title">添加模型</h4>
                    [/#if ]
                </div>
                <div class="panel-body">
                    <form class="form-horizontal" action="${base}/workflow/model/save"   method="post">
                        <div class="form-group">
                            <label class="col-md-1 control-label">模型分类:</label>
                            <div class="col-md-4">
                                <input type="text" name="category" class="form-control" placeholder="分类"  value="${(model.category)!''}"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-1 control-label">模型名称:</label>
                            <div class="col-md-4">
                                <input type="text" name="name" class="form-control" placeholder="分类"  value="${(model.name)!''}"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-1 control-label">模型标识:</label>
                            <div class="col-md-4">
                                <input type="text" name="key" class="form-control" placeholder="分类"  value="${(model.key)!''}"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-1 control-label">模型描述:</label>
                            <div class="col-md-4">
                                <input type="text" name="desc" class="form-control" placeholder="分类"  value="${(model.desc)!''}"/>
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

