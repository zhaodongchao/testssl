package com.security.handlers;

import com.newtouch.exception.ExcelException;
import com.newtouch.utils.ExcelUtil;
import com.security.entity.User;
import com.security.services.AccountService;
import com.sun.tools.jdi.LinkedHashMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletResponse;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by zhaodongchao on 2017/3/25.
 */
@RequestMapping("user")
@Controller
public class UserManagerHandler {
    @Autowired
    private AccountService accountService ;
    @RequestMapping("go")
    public ModelAndView go(){
        ModelAndView modelAndView = new ModelAndView("system/userManager/userManager");

        return modelAndView;
    }
    @RequestMapping("queryUsers")
    public @ResponseBody List<User> queryUsersByCondtion(){
        return accountService.getAllUser() ;
    }
    @RequestMapping("find_username")
    public @ResponseBody List<String> findUsername(@RequestParam(value = "term") String term){
        return accountService.findLoginName(term);
    }
    @RequestMapping("export")
    public void export2Excel(HttpServletResponse response) throws FileNotFoundException, ExcelException {
        List<User> lists = accountService.getAllUser();
        java.util.LinkedHashMap<String,String> filedMap = new java.util.LinkedHashMap<String,String>();
        filedMap.put("loginName","登录名");
        filedMap.put("realName","真实姓名");
        filedMap.put("sex","性别");
        filedMap.put("age","年龄");
        filedMap.put("birthday","生日");
        filedMap.put("telphone","电话号码");
        filedMap.put("email","电子邮件");
        filedMap.put("createTime","创建时间");
        filedMap.put("loginCount","登录次数");
        filedMap.put("isLock","是否锁定");
        filedMap.put("expiredTime","过期时间");
        filedMap.put("lastLoginTime","最后一次登录");
        OutputStream out = new FileOutputStream("D:\\huang\\用户表.xls");
        ExcelUtil.listToExcel(lists,filedMap,"用户表",lists.size()+1,response);
    }
}
