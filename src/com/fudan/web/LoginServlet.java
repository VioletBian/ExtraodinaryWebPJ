package com.fudan.web;

import com.alibaba.druid.support.json.JSONUtils;
import com.fudan.pojo.User;
import com.fudan.service.UserService;
import com.fudan.service.impl.UserServiceImpl;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.net.HttpCookie;

import static com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY;

public class LoginServlet extends HttpServlet {

    private UserService userService = new UserServiceImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //  1、获取请求的参数
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String kaptcha = req.getParameter("kaptcha");
        // 获取Session中的验证码
        String token = (String) req.getSession().getAttribute(KAPTCHA_SESSION_KEY);
        // 删除 Session中的验证码
        req.getSession().removeAttribute(KAPTCHA_SESSION_KEY);
//        2、检查 验证码是否正确
        if (token == null || !token.equalsIgnoreCase(kaptcha)) {
            System.out.println("验证码错误！");
            req.setAttribute("kaptcha", "0");
            req.getRequestDispatcher("pages/login.jsp").forward(req, resp);
        } else {
            // 调用 userService.login()登录处理业务
            User loginUser = userService.login(username, password);
            // 如果等于null,说明登录 失败!
            if (loginUser == null) {
                //   跳回登录页面
                System.out.println("登录失败");
                req.getRequestDispatcher("pages/login.jsp").forward(req, resp);
            } else {
                // 登录 成功
                //跳到成功页面login_success.html
//            req.getRequestDispatcher("/pages/user/login_success.html").forward(req, resp);
                //如果没有session对象，则自动创建一个
                HttpSession session = req.getSession();
                session.setAttribute("username", username);
                Cookie cookie = new Cookie("username", username);
                cookie.setMaxAge(60 * 60 * 24);//当前 Cookie 一天内有效
                resp.addCookie(cookie);
                System.out.println("登录成功");
                if (session.getAttribute("referer") != null) {
                    System.out.println(session.getAttribute("referer"));
                    resp.sendRedirect((String) session.getAttribute("referer"));
                } else resp.sendRedirect("index.jsp");
            }
        }
    }
}