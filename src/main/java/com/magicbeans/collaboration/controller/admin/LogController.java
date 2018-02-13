package com.magicbeans.collaboration.controller.admin;


import com.magicbeans.base.Pages;
import com.magicbeans.base.db.Order;
import com.magicbeans.collaboration.controller.BaseController;
import com.magicbeans.collaboration.service.ILogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;


import java.util.Arrays;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author magicbeans
 * @since 2017-12-26
 */
@Controller
@RequestMapping("/log")
public class LogController extends BaseController {


    @Autowired
    private ILogService logService;

    @GetMapping("")
    public String list(Pages pages, Model model ){
        model.addAttribute("page",logService.findPage(pages,null, Arrays.asList(new Order[]{Order.desc("createTime")})));
        return "log/list";
    }
}
