package com.security.handlers;

import com.google.gson.Gson;
import com.security.core.MyJdbcRealm;
import com.security.entity.Module;
import com.security.services.MenuService;
import com.security.utils.JsonUtil;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * LoginController负责打开登录页面(GET请求)和登录出错页面(POST请求)，
 * 真正登录的POST请求由Filter完成,
 * Created by zhaodongchao on 2017/3/18.
 */
@RequestMapping("index")
@Controller
public class loginHandler {
    @Autowired
    private MenuService menuService ;

  /*  @RequestMapping("login")
    public ModelAndView login(@RequestParam(value = "username",required = false) String username , @RequestParam(value = "password",required = false) String password) {
        UsernamePasswordToken token = new UsernamePasswordToken(username, password);
        org.apache.shiro.subject.Subject subject = SecurityUtils.getSubject();
        try {
            subject.login(token);
        } catch (IncorrectCredentialsException ice) {
            // 捕获密码错误异常
            ModelAndView mv = new ModelAndView("account/login");
            mv.addObject("message", "password error!");
            return mv;
        } catch (UnknownAccountException uae) {
            // 捕获未知用户名异常
            ModelAndView mv = new ModelAndView("account/login");
            mv.addObject("message", "username error!");
            return mv;
        } catch (ExcessiveAttemptsException eae) {
            // 捕获错误登录过多的异常
            ModelAndView mv = new ModelAndView("error/403");
            mv.addObject("message", "times error");
            return mv;
        }
        User user = accountService.findUserByLoginName(username);
        subject.getSession().setAttribute("user", user);
        return new ModelAndView("home/home");
    }*/
    //登录提交地址，和application-shiro中配置的loginurl一致
    @RequestMapping("login")
    public ModelAndView login(HttpServletRequest request, HttpSession session) throws Exception{
        /*
         * 从request中获取登录认证异常信息,shiroLoginFailure就是shiro异常类的全限定名
         * 如果不为空表示登录异常，根据shiro返回的异常类路径判断登录异常的原因，将错误登录信息带到登录界面
         * 反之，表示当前已经登录或者是index.jsp第一次使用get的访问/login，
         * FormAuthenticationFilter不会进行登录验证因此，request.getAttribute("shiroLoginFailure") == null
         */
        ModelAndView mv = null ;
        if(null!=request.getAttribute("shiroLoginFailure")){
            String exceptionClassName = request.getAttribute("shiroLoginFailure").toString();
                mv= new ModelAndView("framework/login");
            if (UnknownAccountException.class.getName().equals(exceptionClassName)) {
                //最终会抛给异常处理器
                mv.addObject("errorMsg","账号不存在");
            } else if (IncorrectCredentialsException.class.getName().equals(exceptionClassName)) {
                mv.addObject("errorMsg","用户名/密码错误");
            } else if("randomCodeError".equals(exceptionClassName)){
                mv.addObject("errorMsg","验证码错误");
            } else{
                mv.addObject("errorMsg","系统未知错误！");
            }
            return mv ;
        }
        /*
          从shiro的session中取出当前登录的用户activeUser
          如果存在就就直接转到主页面，反之，当前没有登录，跳转到登录页面
         */
        MyJdbcRealm.ShiroUser activeUser = getActiveUser();
        if(null != activeUser){
            mv = new ModelAndView("framework/home") ;
            List<Module> moduleList = menuService.getAllMoule(activeUser.getId());

            mv.addObject("userJson", JsonUtil.Object2JsonString(activeUser));
            mv.addObject("modulesJson", JsonUtil.Object2JsonString(moduleList));
        }else{
            /*
              到此步，表示要访问登录页面
             */
            mv = new ModelAndView("framework/login");
        }
        //登录成功
        return mv;
    }
    @RequestMapping("admin")
    public ModelAndView goManagePage(){
        ModelAndView modelAndView = new ModelAndView("home/admin");
        MyJdbcRealm.ShiroUser activeUser = getActiveUser();
        Gson gson = new Gson();
        List<Module> moduleList = menuService.getAllMoule(activeUser.getId());
        modelAndView.addObject("userJson",gson.toJson(activeUser));
        modelAndView.addObject("modulesJson", gson.toJson(moduleList));
        return modelAndView ;
    }
    @RequestMapping("leftTree")
    public String getLeftTree(){
        return "framework/common/left_tree";
    }
    private MyJdbcRealm.ShiroUser getActiveUser(){
        return (MyJdbcRealm.ShiroUser) SecurityUtils.getSubject().getPrincipal();
    }
}
