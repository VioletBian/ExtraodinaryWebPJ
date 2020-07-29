<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%
    String re = request.getHeader("Referer");
    String base = getServletConfig().getServletContext().getInitParameter("base");
    if (re != null && !re.equals(base + "loginServlet") && !re.equals(base + "pages/login.jsp") && !re.equals(base + "pages/signup.jsp") && !re.equals(base + "registServlet")) {
        session.setAttribute("referer", re);
        System.out.println("re=" + session.getAttribute("referer"));
    }

%>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width">
    <title>Login Projectouriscenary</title>
    <base href="<%= getServletConfig().getServletContext().getInitParameter("base")%>">
    <link rel="stylesheet" href="static/css/login.css">
    <script src='static/js/jquery-3.5.1.js'></script>
    <script src='static/js/vue.js'></script>
    <script src="static/js/fnAlert.js"></script>
    <link rel="stylesheet" href="static/css/base/toastr.min.css">
    <link rel="stylesheet" type="text/css" href="static/css/base/web-icons.min.css">
     

</head>

<body>

<main>
    <div class="bg"></div>
    <div id="sign_in_out">
        <div class="window">
            <div class='wrap'>
                <div class="tab_menu">
                    <a href="pages/signup.jsp">Signup</a>
                    <a href="pages/login.jsp" class="selected">Login</a>
                </div>
                <form id="login_form" spellcheck="false" class="" action="loginServlet" method="post">
                    <p><input type="text" name="username" data-autofocus="" placeholder="Username"
                              maxlength="100" required id="id_username"></p>
                    <%
                        if (request.getAttribute("kaptcha") != null) {
                    %>
                    <script>
                        document.getElementById("id_username").value = '<%=request.getParameter("username")%>';
                        fnCreateAlert("Kaptcha is wrong.", false, "#login_form");
                        $("#kaptcha").click();
                    </script>
                    <%
                    } else if (request.getParameter("username") != null) {
                    %>
                    <script>
                        document.getElementById("id_username").value = '<%=request.getParameter("username")%>';
                        fnCreateAlert("Wrong username or password, try again.", false, "#login_form");
                    </script>
                    <%
                        }
                    %>
                    <p><input type="password" name="password" placeholder="Password" required id="id_password">
                    </p>
                    <p><input type="text" name="kaptcha" placeholder="Confirm Kaptcha" id="kaptcha" required>
                        <img id="kaptcha_img" src="kaptcha.jpg" alt="Loading...">
                    </p>
                    <div>
                        <input class="sign_in_button button-green" type="submit" value="Login">
                    </div>
                </form>
            </div>
            <div class='no-account'>
                <a href="pages/signup.jsp">Have no account?</a>
            </div>
        </div>
    </div>
</main>
</body>

<footer id="footer">
    <p>备案号：苏ICP备20030033号
        <br>
        All rights reserved.
        <br>
        Email:18307110428@fudan.edu.cn
        <br>
        <img src="static/img/2071584682073.jpg" width=80px height=80px>
    </p>
</footer>

<script>
    $("#kaptcha_img").click(function () {
        this.src = "kaptcha.jpg";
    });
</script>
</html>