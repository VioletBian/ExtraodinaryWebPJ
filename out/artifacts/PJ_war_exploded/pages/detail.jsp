<%@ page import="jdk.nashorn.internal.runtime.regexp.joni.Regex" %>
<%@ page import="java.util.List" %>
<%@ page import="com.fudan.pojo.Img" %>
<%@ page import="com.fudan.service.impl.UserServiceImpl" %>
<%@ page import="com.fudan.service.UserService" %>
<%@ page import="com.fudan.pojo.User" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    UserService userService = new UserServiceImpl();
    String query = request.getQueryString();
    Img img = userService.detail(query);
%>
<html>

<head>
    <meta charset="UTF-8">
    <title>Detail Projectouriscenary </title>
    <meta name="viewport" content="width=device-width">
    <base href="<%= getServletConfig().getServletContext().getInitParameter("base")%>">
    <link rel="stylesheet" href="static/css/detail.css">
    <script src='static/js/jquery-3.5.1.js'></script>
    <script src='static/js/vue.js'></script>
</head>

<body>
<nav class="light" id='nav' style="opacity: 0.8;">
    <ul>
        <nav_left></nav_left>
        <component v-bind:is="whichcomp"></component>
        <skin_changer></skin_changer>
    </ul>
</nav>

<main>
    <div class="detail-block">
        <div class="title headline"><%=img.getTitle()%>
        </div>
        <div class="left-block">

            <div class="min">
                <img src="static/img/normal/medium/<%=img.getPath()%>">
                <div class="fd"></div>
            </div>
            <div class="max">
                <img src="static/img/normal/medium/<%=img.getPath()%>">
            </div>
        </div>

        <div class="right-block">
            <div class='right-property'>
                <p>
                    <svg t="1586159935375" class="icon" viewBox="0 0 1024 1024" version="1.1"
                         xmlns="http://www.w3.org/2000/svg" p-id="2784" width="20px" height="20px">
                        <path d="M789.504 890.368H319.488c-18.432 0-33.28 14.848-33.28 33.28s14.848 33.28 33.28 33.28h470.016c18.432 0 33.28-14.848 33.28-33.28s-14.848-33.28-33.28-33.28z"
                              fill="#FA7268" p-id="2785"></path>
                        <path d="M731.648 392.192c68.096-118.272 79.36-283.136 79.872-289.792 1.024-12.288-5.632-24.576-16.384-30.72-10.752-6.144-24.064-6.144-34.816 0.512-24.576 15.872-241.152 156.16-287.744 235.52-68.096 114.688-235.52 420.864-237.056 423.936-1.536 2.56-2.048 5.12-3.072 7.68l-91.648 158.72c-9.216 15.872-3.584 36.352 12.288 45.568 5.12 3.072 10.752 4.608 16.384 4.608 11.264 0 22.528-6.144 28.672-16.896L291.84 769.536c58.368-39.936 371.2-258.048 439.808-377.344z m-201.728-51.2c23.04-39.424 122.368-115.2 206.336-173.056-9.216 54.272-27.648 130.56-61.952 190.976-39.936 68.608-190.976 189.952-310.272 278.016 54.272-98.816 126.464-229.376 165.888-295.936z"
                              fill="#3E3A39" p-id="2786"></path>
                    </svg>
                    <span class='detail-property'>Author</span> <span class='detail-value'><%=img.getUsername()%></span>
                </p>
                <p>
                    <svg t="1586160145020" class="icon" viewBox="0 0 1024 1024" version="1.1"
                         xmlns="http://www.w3.org/2000/svg" p-id="12747" width="20px" height="20px">
                        <path d="M835.1 232.3c-0.8-1.4-1.7-2.8-2.9-4.2l-0.5 0.4C751.4 138.9 635.2 82.1 505.6 82.1c-241.7 0-438.3 196.6-438.3 438.4s196.6 438.3 438.3 438.3S944 762.2 944 520.5c0-110.4-41.3-211-108.9-288.2z m-52.4 18.1c-15.4 30.6-63.7 105.4-167.4 103C522.8 350.8 492 196 483.4 134.3c7.4-0.4 14.7-1.1 22.2-1.1 108.6 0 206.7 45 277.1 117.2zM118.3 520.5c0-120.8 55.6-228.8 142.5-299.8 35.3 35.2 93.2 103.5 96.3 157.1 0.9 16.5-3.6 30.2-13.9 41.7-24.7 27.7-49.8 43.6-71.8 57.6-53.8 34.1-85 63.3-31 154.4 33.5 56.5 45.2 92.1 38.1 115.2-4.9 15.8-20.2 30-48.9 45.2-68.7-70.1-111.3-165.9-111.3-271.4z m387.3 387.2c-88.6 0-170.1-30.2-235.4-80.5 25.1-15.6 48.1-36.3 57.2-65.7 12.1-39.1-0.4-84.3-43-156.3-32.7-55.3-28.3-58.1 14.5-85.2 23.7-15 53.1-33.7 82.6-66.7 19.5-21.8 28.5-48.3 26.7-78.6-4.1-70.8-68.8-146.7-105-183.9 39.1-24.1 82.6-41.6 129.2-50.6 9.5 72.4 47.1 260.3 181.4 264.1 2.6 0.1 5.1 0.1 7.6 0.1 110 0 169.9-69.4 196.4-112.3 47 64.1 75.1 142.8 75.1 228.2 0 213.7-173.7 387.4-387.3 387.4z"
                              fill="#1E59E4" p-id="12748"></path>
                        <path d="M514.1 826c-19.8 0-35.7-5.4-45.9-15.9-31.7-32.5-6.2-101.8 36.5-163.1-21.6-17.1-48.8-46.6-56.2-90.7-5.1-30.4-1.5-76.2 25.7-105.4 44.1-47.3 141.5-42.5 218.5-16.8 84.1 28.1 137.7 76.3 143.2 128.9 3.1 29.2-9.5 62.5-35.5 94-35.8 43.3-89.6 74.1-143.1 82.5-33.3 54-85.5 79.4-125.1 85.2-6.4 0.8-12.4 1.3-18.1 1.3z m-8.9-52c5.1 1.3 17.7 1.9 34.9-3.4 15.6-4.8 54.6-21 78.6-66.7l6.5-12.4 14-1.2c53.4-4.5 97.9-37 121.7-65.8 16.7-20.2 25.7-41.1 24.1-56.1-3.2-30.7-46.9-65.2-108.6-85.8-69.3-23.2-141.7-21.8-164.9 3.2-12.9 13.9-16.2 41.7-12.7 62.1 7.3 43 46.6 66.2 54.4 70.4l26.8 14.4-18.8 23.9c-46.6 59.1-58.3 104.9-56 117.4z"
                              fill="#FF5A06" p-id="12749"></path>
                    </svg>
                    <span class='detail-property'>Country</span> <span
                        class='detail-value'><%=img.getCountryName()%></span>
                </p>
                <p>
                    <svg t="1586160017337" class="icon" viewBox="0 0 1024 1024" version="1.1"
                         xmlns="http://www.w3.org/2000/svg" p-id="8564" width="20px" height="20px">
                        <path d="M825 880v80H199v-80h626zM512 65c175.162 0 317.863 135.783 317.863 304.199 0 107.57-91.867 258.49-274.32 459.508a60 60 0 0 1-4.253 4.238c-24.612 22.189-62.551 20.224-84.77-4.42l-5.266-5.856C283.612 624.647 194.137 475.67 194.137 369.199 194.137 200.783 336.838 65 512 65z m0 72c-136.175 0-245.863 104.37-245.863 232.199 0 82.765 82.47 220.076 248.682 405.357l-3.675-4.107 1.408-1.563c80.893-90.012 141.922-168.696 183.024-235.775l1.291-2.114c41.041-67.423 60.996-121.8 60.996-161.798C757.863 241.37 648.175 137 512 137z"
                              fill="#474747" p-id="8565"></path>
                        <path d="M512 222c-77.68 0-140.682 62.888-140.682 140.5S434.32 503 512 503c77.68 0 140.682-62.888 140.682-140.5S589.68 222 512 222z m0 80c33.53 0 60.682 27.103 60.682 60.5S545.53 423 512 423s-60.682-27.103-60.682-60.5S478.47 302 512 302z"
                              fill="#1B69FD" p-id="8566"></path>
                    </svg>
                    <span class='detail-property'>City</span> <span class='detail-value'><%=img.getAsciiName()%></span>
                </p>
                <p>
                    <svg t="1586160089275" class="icon" viewBox="0 0 1024 1024" version="1.1"
                         xmlns="http://www.w3.org/2000/svg" p-id="10055" width="20px" height="20px">
                        <path d="M736.41984 556.34432a185.29792 185.29792 0 1 0-185.29792 185.29792 185.29792 185.29792 0 0 0 185.29792-185.29792z"
                              fill="#F4CA1C" p-id="10056"></path>
                        <path d="M898.23232 418.2016L604.16 121.66656A152.576 152.576 0 0 0 496.49152 76.8h-0.33792l-267.45856 0.60416A151.9616 151.9616 0 0 0 77.3888 228.7104L76.8 496.18944a152.6016 152.6016 0 0 0 44.88192 108.032l296.5504 294.03136a151.94624 151.94624 0 0 0 214.016-0.46592l265.55392-265.56928a151.95648 151.95648 0 0 0 0.43008-214.016z m-49.152 165.28896l-265.55392 265.5744a82.90816 82.90816 0 0 1-116.736 0.256l-296.576-294.0416a83.24096 83.24096 0 0 1-24.48384-58.94144l0.5632-267.47392A82.91328 82.91328 0 0 1 228.864 146.30912l267.46368-0.60416h0.1792a83.26656 83.26656 0 0 1 58.75712 24.47872l294.0416 296.53504a82.90816 82.90816 0 0 1-0.24064 116.77184z m-450.85184-332.2368a144.70144 144.70144 0 1 0 144.69632 144.70656 144.86528 144.86528 0 0 0-144.69632-144.70656z m0 220.50304a75.776 75.776 0 1 1 75.776-75.776 75.88352 75.88352 0 0 1-75.776 75.776z"
                              fill="#595BB3" p-id="10057"></path>
                    </svg>
                    <span class='detail-property'>Theme</span> <span class='detail-value'><%=img.getContent()%></span>
                </p>
                <p>
                    <svg t="1596100604132" class="icon" viewBox="0 0 1024 1024" version="1.1" width="20px" height="20px"
                         xmlns="http://www.w3.org/2000/svg" p-id="2009">
                        <path d="M1023.986784 196.335442L788.669487 0 736.852143 63.702056l235.792685 196.335442 51.341956-63.702056zM286.659253 63.702056L235.317297 0 0 195.860053l51.817344 63.702057zM537.66437 312.330231H460.651436v305.199403l243.398902 144.993487 38.506467-62.75128-204.892435-120.273285V312.330231z"
                              fill="#396AFF" p-id="2010"></path>
                        <path d="M511.993392 108.863962c-252.906671 1.901554-456.37294 208.220154-454.471386 460.651436 1.901554 252.906671 208.220154 456.37294 460.651436 454.471386 251.480505-1.901554 454.471386-206.3186 454.471386-457.799105-0.475388-253.382059-206.793988-458.274494-460.651436-457.323717z m0.475389 837.159112c0-0.475388 0-0.475388-0.475389-0.475389-209.646319-1.426165-377.458452-172.090629-376.032287-381.736949 1.426165-209.646319 172.090629-377.458452 381.736949-376.032287 208.220154 1.426165 376.032287 170.664464 376.032287 379.360007-0.475388 209.646319-171.139853 379.360006-381.26156 378.884618z"
                              fill="#396AFF" p-id="2011"></path>
                        <path d="M537.66437 312.330231H460.651436v305.199403l243.398902 144.993487 38.506467-62.75128-204.892435-120.273285V312.330231z"
                              fill="#595BB3" p-id="2012"></path>
                    </svg>
                    <span class='detail-property'>Time</span> <span class='detail-value'><%=img.getTime()%></span>
                </p>

                <p>
                    <svg t="1586160362304" class="icon" viewBox="0 0 1195 1024" version="1.1"
                         xmlns="http://www.w3.org/2000/svg" p-id="15489" width="20px" height="20px">
                        <path d="M977.661128 649.469437a40.306824 40.306824 0 0 1-28.391303-68.845231l97.97206-98.119165a230.072525 230.072525 0 0 0-325.396692-325.396692l-91.205221 91.205221A40.306824 40.306824 0 0 1 573.710262 191.236754l91.205221-91.205221a310.833278 310.833278 0 0 1 439.403218 439.550323l-98.119165 98.119166a40.159718 40.159718 0 0 1-28.538408 11.768415z"
                              fill="#FF4B9D" p-id="15490"></path>
                        <path d="M601.218933 1023.999264a40.012613 40.012613 0 0 1-28.538408-11.768415L85.615224 525.165547a293.033549 293.033549 0 0 1 0-413.954019l25.449198-25.596304a293.180654 293.180654 0 0 1 414.101125 0L632.55234 192.707806a40.306824 40.306824 0 0 1-57.371026 57.371026l-107.092583-107.386793a212.125692 212.125692 0 0 0-299.947493 0L142.692039 168.141238a212.125692 212.125692 0 0 0 0 299.947493L601.218933 926.76273l194.473068-194.473068A40.306824 40.306824 0 1 1 853.210133 789.366478L629.757341 1012.230849a39.865508 39.865508 0 0 1-28.538408 11.768415z"
                              fill="#0060F7" p-id="15491"></path>
                    </svg>
                    <span class='detail-property'>Favor Number</span> <span
                        class='detail-value'><%=img.getPopularity()%></span>
                </p>
            </div>
            <div class="button-line">
                <a href="favorServlet?<%=query%>">
                    <button id="favor">
                        <svg t="1586160471132" class="icon" viewBox="0 0 1024 1024" version="1.1"
                             xmlns="http://www.w3.org/2000/svg" p-id="16267" width="40px" height="40px">
                            <path d="M140.354 184.938l-1.152 1.157C35.466 290.97 36.39 460.083 141.264 563.82l330.698 327.108 0.595 0.58c19.13 18.412 47.886 21.918 70.722 9.228l0.66-0.373 0.578-0.304a59.96 59.96 0 0 0 14.132-10.525l8.465-8.494 0.003-0.022 179.188-179.795 148.06-147.867-0.687-0.678 1.056-1.185c92.58-105.686 88.138-266.347-12.495-366.762l-3.165-3.107c-101.891-98.425-262.45-100.261-366.53-5.634l-0.049 0.045-1.23-1.122c-106.006-95.157-269.031-91.72-370.91 10.026z m329.947 50.275l42.502 42.043 41.123-41.26c76.531-76.698 200.754-76.834 277.456-0.299l2.255 2.287c72.937 75.15 74.014 194.423 2.622 270.835l-2.147 2.261-2.529 2.578-39.629 39.762 0.23 0.226-96.817 96.69-180.824 181.438L191.897 512.63c-76.604-75.772-77.278-199.298-1.506-275.902l0.842-0.845c77.016-76.915 201.684-77.215 279.068-0.67z"
                                  fill="#474747" p-id="16268"></path>
                            <path d="M226.431 455L283 398.431 476.569 592 420 648.569z" fill="#1B69FD"
                                  p-id="16269"></path>
                        </svg>
                        <span>Like</span></button>
                </a>
                <a href="unfavorServlet?<%=query%>">
                    <button id="unfavor">
                        <svg t="1586160471132" class="icon" viewBox="0 0 1024 1024" version="1.1"
                             xmlns="http://www.w3.org/2000/svg" p-id="16267" width="40px" height="40px">
                            <path d="M140.354 184.938l-1.152 1.157C35.466 290.97 36.39 460.083 141.264 563.82l330.698 327.108 0.595 0.58c19.13 18.412 47.886 21.918 70.722 9.228l0.66-0.373 0.578-0.304a59.96 59.96 0 0 0 14.132-10.525l8.465-8.494 0.003-0.022 179.188-179.795 148.06-147.867-0.687-0.678 1.056-1.185c92.58-105.686 88.138-266.347-12.495-366.762l-3.165-3.107c-101.891-98.425-262.45-100.261-366.53-5.634l-0.049 0.045-1.23-1.122c-106.006-95.157-269.031-91.72-370.91 10.026z m329.947 50.275l42.502 42.043 41.123-41.26c76.531-76.698 200.754-76.834 277.456-0.299l2.255 2.287c72.937 75.15 74.014 194.423 2.622 270.835l-2.147 2.261-2.529 2.578-39.629 39.762 0.23 0.226-96.817 96.69-180.824 181.438L191.897 512.63c-76.604-75.772-77.278-199.298-1.506-275.902l0.842-0.845c77.016-76.915 201.684-77.215 279.068-0.67z"
                                  fill="#474747" p-id="16268"></path>
                            <path d="M226.431 455L283 398.431 476.569 592 420 648.569z" fill="#1B69FD"
                                  p-id="16269"></path>
                        </svg>
                        <span>Unfavor</span></button>
                </a>
            </div>
        </div>
        <div class="clearboth"></div>
        <section class="description"><%=img.getDescription()%>
        </section>


    </div>

</main>


</body>

<footer id="footer"></footer>
<script src='static/js/nav&footer.js'></script>
<script src='static/js/change_skin.js'></script>
<%
    String username = User.getCookieValue(request.getCookies(), "username");
    if (username == null) {
%>
<script>document.getElementById('favor').hidden = 'hidden';
document.getElementById('unfavor').hidden = 'hidden';
</script>
<%
} else {

    if (session.getAttribute("footprint") == null) {
        List<Img> foots = new ArrayList<>();
        foots.add(img);
        session.setAttribute("footprint", foots);
    } else {
        List<Img> foots = (List<Img>) session.getAttribute("footprint");
        // 以一种方法：两个循环(最蠢的方法)
        for (int i = 0; i < foots.size(); i++) {
            if (foots.get(i).getImageID() == img.getImageID()) {
                foots.remove(i);//删除重复元素
            }
        }
        if (foots.size() == 10) {
            foots.remove(0);
        }
        foots.add(img);
        session.setAttribute("footprint", foots);

    }
    if (userService.isFavored(User.getCookieValue(request.getCookies(), "username"), query)) {
%>
<script>document.getElementById('favor').hidden = 'hidden';</script>
<%} else {%>
<script>document.getElementById('unfavor').hidden = 'hidden';</script>
<%
        }
    }
%>
<script>
    var min = document.querySelector(".min");
    var max = document.querySelector(".max");
    var img = document.querySelector(".max img");
    var fd = document.querySelector(".fd");
    var rt = document.querySelector(".right-block");

    var ratio = document.getElementsByTagName("img")[0].width / document.getElementsByTagName("img")[0].height;
    max.style.height = "300px";
    max.style.width = 300 * ratio + "px";


    min.onmouseover = function () {
//                1.鼠标覆盖显示max和fd
        max.style.display = "block";
        fd.style.display = "block";
        rt.style.display = "none";

    }
    //            离开时隐藏
    min.onmouseout = function () {
        max.style.display = "none";
        fd.style.display = "none";
        rt.style.display = "block";
    }
    //            2. fd的移动范围
    min.onmousemove = function () {
//                鼠标触摸的点
        var x = event.clientX - min.offsetLeft - fd.offsetWidth / 2;
        var y = event.clientY - min.offsetTop - fd.offsetHeight / 2;
//                最大移动距离
        var maxX = min.clientWidth - fd.offsetWidth;
        var maxY = min.clientHeight - fd.offsetHeight;
//                边界判断
        if (x <= 0) {
            x = 0;
        } else if (x >= maxX) {
            x = maxX;
        }
        if (y <= 0) {
            y = 0;
        } else if (y >= maxY) {
            y = maxY;
        }
//                fd的位置
        fd.style.left = x + 'px';
        fd.style.top = y + 'px';
        //fd/min = max/img
        //移动比例
        var moveX = x / maxX;
        var moveY = y / maxY;
//                移动
//                3. max的对应显示
//                对于大图而言,放大镜在小图上移动的比例相当于img在可显示区域上移动的比例
//                放大镜右移等于图片左移
//                也就是本质上为img-max 然而而需要负值,则*-1简化后为max-img
        img.style.left = moveX * (max.clientWidth - img.offsetWidth) + 'px';
        img.style.top = moveY * (max.clientHeight - img.offsetHeight) + 'px';
        console.log(img.width + ":" + img.height);
        // max.style.width

    }
</script>
</html>
