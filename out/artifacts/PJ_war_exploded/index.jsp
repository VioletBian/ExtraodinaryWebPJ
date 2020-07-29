<%@ page import="java.util.List" %>
<%@ page import="com.fudan.pojo.Img" %>
<%@ page import="com.fudan.service.UserService" %>
<%@ page import="com.fudan.service.impl.UserServiceImpl" %><%--
  Created by IntelliJ IDEA.
  User: fortunebian
  Date: 2020/7/7
  Time: 8:43 下午
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width">
    <title>Welcome To Projectouriscenary</title>
    <base href="<%= getServletConfig().getServletContext().getInitParameter("base")%>">
    <link rel="stylesheet" href="static/css/home.css">
    <link rel="stylesheet" href="static/css/font-awesome.min.css">
    <link href="static/css/bootstrap.css" rel="stylesheet">
    <script src='static/js/jquery-3.5.1.js'></script>
    <script src='static/js/vue.js'></script>
    <script src="static/js/bootstrap.min.js"></script>
</head>


<body>
<nav class="dark" id='nav' style="opacity: 0.8;">
    <ul>
        <nav_left></nav_left>
        <component v-bind:is="whichcomp"></component>
        <skin_changer></skin_changer>
    </ul>
</nav>

<!-- Collect the nav links, forms, and other content for toggling -->
<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
    <!-- Indicators
    <ol class="carousel-indicators">
      <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
      <li data-target="#carousel-example-generic" data-slide-to="1"></li>
      <li data-target="#carousel-example-generic" data-slide-to="2"></li>
    </ol> -->
    <div id="bg"></div>
    <!-- Wrapper for slides -->
    <div class="carousel-inner" role="listbox">
        <%
            UserService userService = new UserServiceImpl();
            List<Img> hotImgs = userService.hotImgs();
            for (Img im : hotImgs) {%>
        <%=im.getSlide()%>
        <%
            }
        %>
        <script>document.getElementsByClassName("item")[0].classList.add("active")</script>

    </div>

    <!-- Controls -->
    <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
        <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
    </a>
    <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
        <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
    </a>
</div>



<div class="hot-images">
    <ul>
        <%
        List<Img> newImgs = userService.newImgs();
        for (Img im : newImgs) {%>
        <%=im.getNew()%>
        <%} %>



        <div class="clearboth"></div>
    </ul>
</div>
</body>
<footer id="footer"></footer>

<div class="float-button" id="float_button"></div>
<script src='static/js/nav&footer.js'></script>
<script src='static/js/change_skin.js'></script>
<script src='static/js/float_button.js'></script>

