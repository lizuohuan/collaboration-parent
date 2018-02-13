package com.magicbeans.collaboration.controller.admin;

import com.magicbeans.collaboration.Message;
import com.magicbeans.base.ajax.ResponseData;
import com.magicbeans.base.Pages;
import com.magicbeans.collaboration.controller.BaseController;
import com.magicbeans.collaboration.entity.Admin;
import com.magicbeans.collaboration.service.IAdminService;
import com.magicbeans.collaboration.service.IRoleService;
import org.apache.shiro.crypto.SecureRandomNumberGenerator;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;

/**
 * @author :Jason
 * @date ：2017/8/31 0031
 * @description
 **/
@Controller
@RequestMapping("account")
public class AdminController extends BaseController {

    @Autowired
    private IAdminService adminService;

    @Autowired
    private IRoleService roleService;
    /**
     * 管理员列表
     * @param page
     * @param model
     * @return
     */
    @RequestMapping(value = "list")
    public String list(Pages page , Model model){
        adminService.findPage(page,null,null);
        model.addAttribute("page",page);
        return "view/admin/list";
    }

    /**
     * 跳转添加页面
     * @return
     */
    @GetMapping("add")
    public String toAdd(Model model){
        model.addAttribute("allRole",roleService.selectAll());
        return "view/admin/add";
    }

    @PostMapping("save")
    public String save(@Valid Admin validAdmin, Model model, RedirectAttributes redirectAttributes){
        if(StringUtils.isEmpty(validAdmin.getId())){
            Admin admin = new Admin();
            String salt = new SecureRandomNumberGenerator().nextBytes().toHex();
            admin.setSalt(salt);
            String password =new SimpleHash("md5",validAdmin.getPassword(), ByteSource.Util.bytes(salt),2).toHex();
            admin.setPassword(password);
            admin.setUsername(validAdmin.getUsername());
            adminService.insertOrUpdate(admin,validAdmin.getRoles());
        }else{
            Admin admin = new Admin();
            admin.setId(validAdmin.getId());
            admin.setUsername(validAdmin.getUsername());
            adminService.insertOrUpdate(admin,validAdmin.getRoles());
        }
        addFlashMessage(redirectAttributes,new Message(Message.Type.success,  "保存成功"));
        return  redirect("list");
    }

    /**
     * 刪除管理
     * @param id
     * @return
     */
    @GetMapping("del/{id}")
    @ResponseBody
    public ResponseData del(@PathVariable String id){
        ResponseData result = new ResponseData();
        adminService.delete(id);
        return result;
    }

    @GetMapping("edit")
    public String edit(@RequestParam String id,Model model){
        model.addAttribute("admin",adminService.find(id));
        model.addAttribute("adminRoles",roleService.findByAdmin(id));
        model.addAttribute("allRole",roleService.selectAll());
        return "view/admin/add";
    }
}
