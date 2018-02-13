package com.magicbeans.collaboration.controller.admin;

import com.magicbeans.collaboration.Message;
import com.magicbeans.base.Pages;
import com.magicbeans.collaboration.controller.BaseController;
import com.magicbeans.base.ajax.ResponseData;
import com.magicbeans.collaboration.entity.Role;
import com.magicbeans.collaboration.service.IRoleService;
import org.apache.commons.collections.MapUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.List;
import java.util.Map;

/**
 * @author :Jason
 * @date ：2017/8/31 0031
 * @description
 **/
@Controller
@RequestMapping("role")
public class RoleController extends BaseController {

    @Autowired
    private IRoleService roleService;

    @RequestMapping(value = "list")
    public String list(Pages page, HttpSession session, Model model) {
        Session session1 = SecurityUtils.getSubject().getSession();
        roleService.findPage(page,null,null);
        model.addAttribute("page", page);
        return "view/role/list";
    }

    @RequestMapping(value = "toAdd")
    public String toAdd() {
        return "view/role/add";
    }

    /**
     * 保存角色
     *
     * @param role
     * @param model
     * @return
     */
    @PostMapping(value = "save")
    public String save(@Valid Role role, Model model, RedirectAttributes redirectAttributes) {
        if (StringUtils.isEmpty(role.getId())) {
            roleService.save(role);
        } else {
            roleService.update(role);
        }

        addFlashMessage(redirectAttributes,new Message(Message.Type.success,"保存成功"));
        return redirect("list");
    }

    /**
     * 根据ID刪除
     *
     * @param id
     * @return
     */
    @GetMapping(value = "del/{id}")
    @ResponseBody
    public ResponseData del(@PathVariable String id) {
        ResponseData result = new ResponseData();
        roleService.delete(id);
        return result;
    }

    /**
     * 编辑角色信息
     *
     * @param id
     * @param model
     * @return
     */
    @GetMapping("edit")
    public String edit(String id, Model model) {
        model.addAttribute("role", roleService.find(id));
        return "view/role/add";
    }


    /**
     * 保存角色的权限
     * @param params
     * @return
     */
    @ResponseBody
    @PostMapping("saveResource")
    public ResponseData saveRoleResource(@RequestBody Map<String, Object> params) {
        ResponseData result = new ResponseData();
        String roleId = MapUtils.getString(params, "role", null);
        List<String> res = (List<String>) params.get("res");
        roleService.delResByRole(roleId);
        roleService.bathInsertRes(roleId,res);
        return result;
    }

}
