<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ page import="com.sun.org.apache.xpath.internal.operations.Bool" %>
<%! int status;
    String[] empty;
    String para;

%>
<%
    String re = request.getHeader("Referer");
    String base = getServletConfig().getServletContext().getInitParameter("base");
    if (re != null && !re.equals(base + "loginServlet") && !re.equals(base + "pages/login.jsp") && !re.equals(base + "pages/signup.jsp") && !re.equals(base + "registServlet")){
        session.setAttribute("referer", re);
        System.out.println("re=" + session.getAttribute("referer"));
    }

%>
<html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width">
    <title>Signup Projectouriscenary</title>
    <base href="<%= getServletConfig().getServletContext().getInitParameter("base")%>">
    <link rel="stylesheet" href="static/css/signup.css">
    <link rel="stylesheet" href="static/css/base/toastr.min.css">

    <script src='static/js/jquery-3.5.1.js'></script>
    <script src='static/js/vue.js'></script>
    <script src="static/js/fnAlert.js"></script>
    <script src="static/js/signup.js"></script>
    <script>

    </script>

</head>
<%
    if (request != null && request.getAttribute("occupied") != null) {
        status = 1;
        System.out.println("111");
    }
    if (request != null && request.getAttribute("empty") != null) {
        status = 2;
        System.out.println("222");
    }
    if (request != null && request.getAttribute("kaptcha") != null) {
        status = 4;
        System.out.println("444");
    }
%>

<body>

<main>
    <div class="bg"></div>

    <div id="sign_in_out">
        <div class="window">
            <div class='wrap'>
                <div class="tab_menu">
                    <a href="pages/signup.jsp" class=selected>Signup</a>
                    <a href="pages/login.jsp">Login</a>
                </div>
                <form id="signup_form" class="" action="registServlet" method="POST">

                    <p><input type="text" name="username" data-autofocus="" placeholder="Your username"
                              maxlength="100" id="id_username" pattern="^[a-zA-Z]{1}[a-zA-Z0-9_.]{3,14}$"
                              oninvalid="setCustomValidity('Required 4 to 15 digits beginning with a letter. [a-zA-Z0-9_.] allowed.')"
                              oninput="setCustomValidity('')" required>
                        <% if (status == 2 || status == 4) {%>
                        <script>document.getElementById("id_username").value = '<%=request.getParameter("username")%>';</script>
                        <% }%>
                    </p>

                    <p><input type="text" name="email" placeholder="Your email"
                              maxlength="100" id="id_email" pattern="^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$"
                              oninvalid="setCustomValidity('Email required is invalid')" oninput="setCustomValidity('')" required></p>
                    <% if (status == 2 || status == 4) {%>
                    <script>document.getElementById("id_email").value = '<%=request.getParameter("email")%>';</script>
                    <% }%>
                    <p><input type="password" name="password" placeholder="Password" id="password" pattern="^.{6,12}$"
                              oninvalid="setCustomValidity('Required 6 to 12 digits long.')"
                              oninput="setCustomValidity('')" required>
                            <% if (status == 2 || status == 4){%>
                        <script>document.getElementById("password").value = '<%=request.getParameter("password")%>';</script>
                            <% }%>
                        <span class="red" id="A">Pass Strength</span>
                    <table height="8" border="1" align="left" cellpadding="0" cellspacing="0" bordercolor="#EEEEEE"
                           style="border-collapse:collapse;">
                        <tr>
                            <td bgcolor="#EEEEEE" width="1" align="center" valign="middle" id="B"></td>
                        </tr>
                    </table>
                    </p>

                    <p><input type="password" name="confirm_password" placeholder="Confirm password"
                              id="confirm_password" required>
                    </p>

                    <p><input type="text" name="kaptcha" placeholder="Confirm Kaptcha" id="kaptcha" required>
                        <img id="kaptcha_img" src="kaptcha.jpg" alt="Loading...">
                    </p>

                    <div>
                        <button type='submit' class="sign_in_button button-green" value="Signup" id="sub" required>
                            Signup
                        </button>

                    </div>
                </form>
            </div>
            <div class='have-account'>
                <a href="pages/login.jsp">Already have an account?</a>
            </div>
        </div>
    </div>
</main>
</body>
<script>
    var btn = document.getElementById("sub");
    btn.addEventListener("click", function () {
        console.log("::" + document.getElementById("id_email").value);
    })
</script>
<%

    if (status == 1) {
%>
<script>
    fnCreateAlert('UserName has been occupied.', false, "#signup_form");
    $("#kaptcha").click();
</script>
<%
        request.setAttribute("occupied", null);
    }

    if (status == 2) {
        para = (String) request.getAttribute("empty");
        System.out.println(para);
        request.setAttribute("empty", null);
%>
<script>
    fnCreateAlert('You must enter<%= para %>.', false, "#signup_form");
    $("#kaptcha").click();
</script>
<%
    }
    if (status == 4) {%>
<script>
    fnCreateAlert('Kaptcha is wrong.', false, "#signup_form");
    request.setAttribute("kaptcha",null);
    $("#kaptcha").click();
</script>
<% }
%>
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
    });</script>
</html>