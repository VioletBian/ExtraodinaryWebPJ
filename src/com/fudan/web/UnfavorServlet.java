package com.fudan.web;

import com.fudan.pojo.User;
import com.fudan.service.UserService;
import com.fudan.service.impl.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class UnfavorServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserService userService = new UserServiceImpl();
        userService.unfavor(User.getCookieValue(request.getCookies(), "username"),request.getQueryString());
        response.sendRedirect(request.getHeader("Referer"));


    }
}
