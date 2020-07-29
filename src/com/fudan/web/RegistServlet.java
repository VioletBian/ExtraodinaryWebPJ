package com.fudan.web;

import com.fudan.pojo.User;
import com.fudan.service.UserService;
import com.fudan.service.impl.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

import static com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY;

public class RegistServlet extends HttpServlet {

    private UserService userService = new UserServiceImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //  0、获取请求的参数与验证码
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String email = req.getParameter("email");
        String kaptcha = req.getParameter("kaptcha");

        // 获取Session中的验证码
        String token = (String) req.getSession().getAttribute(KAPTCHA_SESSION_KEY);
        // 删除 Session中的验证码
        req.getSession().removeAttribute(KAPTCHA_SESSION_KEY);

//        1、检查 验证码是否正确
        if (token == null || !token.equalsIgnoreCase(kaptcha)) {
            System.out.println("验证码错误！");
            req.setAttribute("kaptcha","0");
            req.getRequestDispatcher("/pages/signup.jsp").forward(req, resp);
        }
//        2、检查 用户名是否可用
                //     不可用
         else if (userService.existsUsername(username)) {
                System.out.println("用户名[" + username + "]已存在!");
//        跳回注册页面
                req.setAttribute("occupied","1");
                req.getRequestDispatcher("/pages/signup.jsp").forward(req, resp);

            }
//        3、 检查是否有空值
            else if (username.length() == 0 || password.length() == 0 || email.length() == 0){
                String ignore = " ";
                if (username.length() == 0 ) ignore += "username ";
                if (password.length() == 0 ) ignore += "password ";
                if (email.length() == 0 ) ignore += "email ";

                req.setAttribute("empty",ignore);
                System.out.println("22222");
                req.getRequestDispatcher("/pages/signup.jsp").forward(req, resp);


            }

            else {
                //      可用
//                调用Service保存到数据库
                userService.registUser(new User(null, username, password, email));
                System.out.println("33333");
//                req.setAttribute("status",'3');
                String referer = req.getHeader("Referer");
                //如果没有session对象，则自动创建一个
                HttpSession session = req.getSession();
                session.setAttribute("username",username);
                Cookie cookie = new Cookie("username", username);
                cookie.setMaxAge(60 * 60 * 24);//当前 Cookie 一天内有效
                resp.addCookie(cookie);
                if(session.getAttribute("referer") != null) resp.sendRedirect((String) session.getAttribute("referer"));
                else resp.sendRedirect("index.jsp");

            }

        }
    }
