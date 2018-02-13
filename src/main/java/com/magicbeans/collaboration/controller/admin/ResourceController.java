package com.magicbeans.collaboration.controller.admin;

import com.magicbeans.collaboration.Message;
import com.magicbeans.collaboration.Tree;
import com.magicbeans.base.ajax.ResponseData;
import com.magicbeans.base.Pages;
import com.magicbeans.collaboration.controller.BaseController;
import com.magicbeans.collaboration.entity.Resource;
import com.magicbeans.collaboration.service.IResourceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.List;

/**
 * @author :Jason
 * @date ：2017/8/31 0031
 * @description
 **/
@Controller
@RequestMapping("resource")
public class ResourceController extends BaseController {

    @Autowired
    private IResourceService resourceService;

    /**
     * 查看列表页面
     * @param page
     * @param model
     * @return
     */
    @RequestMapping(value = "list")
    public String list(Pages page, Model model){
        page = resourceService.findPage(page,null,null);
        model.addAttribute("page",page);

        return "view/res/list";
    }

    /**
     * 跳转到添加页面
     * @return
     */
    @GetMapping("add")
    public String add(Model model){
        model.addAttribute("meunList",  resourceService.selectAll());
        return "view/res/add";
    }

    /**
     * 保存信息
     * @param menu
     * @param model
     * @return
     */
    @PostMapping("save")
    public String save(Resource menu, Model model, RedirectAttributes redirectAttributes){
        if(StringUtils.isEmpty(menu.getId())){
            resourceService.save(menu);
        }else{
            resourceService.update(menu);
        }
        addFlashMessage(redirectAttributes,new Message(Message.Type.success,"保存成功"));
        return redirect("list");
    }

    /**
     * 编辑资源信息
     * @param id
     * @param model
     * @return
     */
    @GetMapping("edit")
    public String edit(@RequestParam String id,Model model){
        model.addAttribute("menu",resourceService.find(id));
        model.addAttribute("meunList",  resourceService.selectAll());
        return "/view/res/edit";
    }

    /**
     * 根据id删除
     * @param id
     * @return
     */
    @ResponseBody
    @GetMapping("del/{id}")
    public ResponseData del(@PathVariable("id") String id){
        ResponseData result = new ResponseData();
        resourceService.delete(id);
        return  result;
    }


    /**
     * 查询用户所有的资源信息
     * @return
     */
    @ResponseBody
    @GetMapping("selectRoleResource/{roleId}")
    public ResponseData selectRoleResource(@PathVariable String roleId){
        ResponseData<List<Resource>> result = new ResponseData<>();
        result.body= resourceService.selectRoleResource(roleId);
        return result;
    }



    @ResponseBody
    @RequestMapping("all")
    public ResponseData<Tree> getFunctionTree() {
        ResponseData<Tree> result = new ResponseData<>();
        List<Tree> treeList = new ArrayList<Tree>();
        List<Resource> functionList = resourceService.selectAll();
        Tree rootTree = new Tree("系统菜单");
        for (Resource menu : functionList) {
            String parent = menu.getParentId();
            if (null == parent || StringUtils.isEmpty(parent.toString())) {
                Tree tree = new Tree(menu.getId(), menu.getResName(), Tree.TREE_NODE_STATE_DEFAULT);
                tree.setData(menu.getUrl());
                Resource.initTree(functionList, tree);
                treeList.add(tree);
            }
        }
        rootTree.setChildren(treeList);
        result.body = rootTree;
        return result;
    }





}
