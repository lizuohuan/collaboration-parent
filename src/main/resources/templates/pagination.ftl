<link href="${basePath}/assets/css/common.css" rel="stylesheet" id="theme" />
[#--<input type="hidden" id="orderProperty" name="orderProperty" value="${pageList.orderProperty}" />--]
[#--<input type="hidden" id="orderDirection" name="orderDirection" value="${pageList.orderDirection}" />--]
<input type="hidden" id="pageSize" name="pageSize" value="${page.size}" />
[#--<input type="hidden" id="orderDirection" name="orderDirection" value="${pageList.orderDirection}" />--]
[#if totalPages > 1]
<!-- 分页样式模块 -->
<div class="pagination">
    <div class="align-right">
		[#if isFirst]
		[#--<input type="button" class="page" value="首页" disabled>--]
		[#else]
            <input type="button" class="page" value="首页" onclick="$.pageSkip(${firstPageNumber});">
		[/#if]
		[#if hasPrevious]
            <input type="button" class="page" value="上一页" onclick="$.pageSkip(${previousPageNumber});">
		[#else]
		[#--<input type="button" class="page" value="上一页" disabled>--]
		[/#if]

		[#list segment as segmentPageNumber]
			[#if segmentPageNumber_index == 0 && segmentPageNumber > firstPageNumber + 1]
                <span class="spot">...</span>
			[/#if]
			[#if segmentPageNumber != pageNum]
                <input type="button" class="page" value="${segmentPageNumber}" onclick="$.pageSkip(${segmentPageNumber});"/>
			[#else]
                <input type="button" class="page active" value="${segmentPageNumber}" disabled/>
			[/#if]
			[#if !segmentPageNumber_has_next && segmentPageNumber < lastPageNumber - 1]
                <span class="spot">...</span>
			[/#if]
		[/#list]

		[#if hasNext]
            <input type="button" class="page" value="下一页" onclick="$.pageSkip(${nextPageNumber});">
		[#else]
            <span class="nextPage">&nbsp;</span>
		[/#if]
		[#if isLast]
            <span class="lastPage">&nbsp;</span>
		[#else]
            <input type="button" class="page" value="末页" onclick="$.pageSkip(${lastPageNumber});">
		[/#if]

        <span>&nbsp;&nbsp;</span>
        <span>共<label style="color: #0794FD">${totalPages}</label>页,</span>
        <span>跳转到</span>
        <input id="current" name="current" type="text" class="page-input" value="${pageNum}" maxlength="9" onpaste="return false;"/>
        <span>页</span>
        <input type="submit" class="page" value="确定" >
    </div>
</div>

[/#if]