package com.fudan.web;

import com.fudan.service.UserService;
import com.fudan.service.impl.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public class FriendServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserService userService = new UserServiceImpl();
//        userService.invite(request.getParameter("username"),request.getParameter("target"));
        System.out.println("username=" + request.getParameter("username") + " ,target=" + request.getParameter("target"));
        if (request.getParameter("flag").equals("invite"))
            if (userService.invite(request.getParameter("username"), request.getParameter("target"))) {
                response.getWriter().write("success");

            } else {
                System.out.println("denied.");
                response.getWriter().write("denied");
            }
        if (request.getParameter("flag").equals("pass")) {
            userService.pass(request.getParameter("username"), request.getParameter("target"));
        }
        if (request.getParameter("flag").equals("block")) {
            userService.block(request.getParameter("username"));
        }
        if (request.getParameter("flag").equals("allow")) {
            userService.allow(request.getParameter("username"));
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
