package com.fudan.web;

import com.fudan.pojo.User;
import com.fudan.service.UserService;
import com.fudan.service.impl.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class CommentServlet extends HttpServlet {
    UserService userService = new UserServiceImpl();
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = User.getCookieValue(request.getCookies(), "username");
        String query = request.getQueryString();
        userService.addComment(query,username,request.getParameter("content"));
        response.sendRedirect(request.getHeader("Referer"));


    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println(request.getParameter("like"));
        if(request.getParameter("like").equals("like")){
            int cid = Integer.parseInt(request.getParameter("id"));
            System.out.println("要喜欢");
            userService.likeComment(cid);
            System.out.println("喜欢了！");

        }

    }
}
