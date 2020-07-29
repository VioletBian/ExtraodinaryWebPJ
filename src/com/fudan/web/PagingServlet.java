package com.fudan.web;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public class PagingServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String page = request.getParameter("pagenumber");
        String type = request.getParameter("pagetype");
        System.out.println(type+"PageNumber： "+page);
        //用于返回给前台页面的XML文档
        StringBuffer xmlDOM = new StringBuffer();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }


    public String pagesCreater(int i) {
        String tags = "<a id='previous'>&lt&lt</a>";
        for (int p = 1; p <= i; p++) {
            tags += "<a id='page" + p + "' class='page'>" + p + "</a>";
        }
        tags += "<a id='next'>&gt&gt</a>";
        return tags;
    }
    /**
     * @category 打印出XMLDOM文档,用于前台页面的接收
     * @param request
     * @param response
     * @param xmlDOM
     * @throws IOException
     */
    private void print(HttpServletRequest request, HttpServletResponse response,String xmlDOM) throws IOException{
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/xml");
        PrintWriter out = response.getWriter();
        out.print(xmlDOM);
        out.close();
    }

}
