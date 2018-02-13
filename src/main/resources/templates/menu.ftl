[#macro menu children]
    [#list children as child]
        [#if child.children?size > 0]
        <li class="has-sub expand" >
            <a href="javascript:;"><b class="caret pull-right"></b><i class="fa fa-th"></i><span>${child.text} </span></a>
            <ul class="sub-menu" style="display: block;">
                [@menu children = child.children /]
            </ul>
        </li>
        [#else ]
             <li><a href="${basePath}/${child.data}"  class="menu-item">${child.text}</a></li>
        [/#if]
    [/#list]
[/#macro]