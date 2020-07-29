package com.fudan.web;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class LogoutServlet extends HttpServlet {


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("已退出登录");
        Cookie newCookie=new Cookie("username",null); //假如要删除名称为username的Cookie
        newCookie.setMaxAge(0); //立即删除型
        newCookie.setPath(getServletContext().getInitParameter("base")); //项目所有目录均有效，这句很关键，否则不敢保证删除
        response.addCookie(newCookie); //重新写入，将覆盖之前的
        System.out.println("referer"+request.getHeader("referer"));
        response.sendRedirect(request.getHeader("referer"));

    }
}
