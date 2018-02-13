<!-- begin #content -->
<!-- ================== BEGIN BASE CSS STYLE ================== -->
[#include "../include.ftl"]
<div id="content" class="content">
    <form id="listForm" action="${basePath}/log" class="form-inline" >
        <div class="row">
        <!-- begin col-12 -->
        <div class="col-md-12">
            <!-- begin panel -->
            <div class="panel panel-inverse" data-sortable-id="table-basic-7">
                <div class="panel-heading">
                    <h4 class="panel-title">日志管理</h4>
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
                                       <option value="type" [#if 'type' ==( page.searchProperties)!'' ]selected="selected"[/#if]>分类</option>
                                   </select>
                                    <div class="input-group input-daterange">
                                        <select class="form-control" name="searchValue">
                                            <option value="" >请选择查询条件</option>
                                            <option value="0" [#if '0' ==( page.searchValue)!'' ]selected="selected"[/#if] >请求日志</option>
                                            <option value="1" [#if '1' ==( page.searchValue)!'' ]selected="selected"[/#if]>业务日志</option>
                                            <option value="2" [#if '2' ==( page.searchValue)!'' ]selected="selected"[/#if]>异常日志</option>
                                        </select>
                                    </div>
                                </div>
                                <button type="submit" class="btn btn-default">查询</button>
                        </div>
                    </div>
                    <div class="panel panel-default actionPanel">
                        [#--添加操作按钮--]
                    </div>
                    <table class="table table-bordered table-striped">
                        <thead>
                        <tr>
                            <th width="70">序号</th>
                            <th>分类</th>
                            <th>IP</th>
                            <th>模块</th>
                            <th>内容</th>
                            <th>操作人</th>
                            <th>创建时间</th>
                        </tr>
                        </thead>
                        <tbody>

                        [#list  page.records as item]
                            <tr>
                                <td width="70" align="center">${item_index+1}</td>
                                <td>${item.type.desc!''}</td>
                                <td>${item.ip!''}</td>
                                <td>${item.module!''}</td>
                                <td width="100">${item.content!''}</td>
                                <td>${item.loginUser!''}</td>
                                <td>${(item.createTime?string("yyyy-MM-dd hh:MM:ss"))!''}
                            </tr>
                        [/#list]
                        </tbody>
                    </table>

                    [@pagination pageNumber = page.current totalPages = page.pages]
                    [#include "../pagination.ftl"]
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
    [@flash_message /]
</script>
