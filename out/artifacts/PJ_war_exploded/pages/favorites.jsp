<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ page import="com.fudan.pojo.Img" %>
<%@ page import="com.fudan.service.UserService" %>
<%@ page import="com.fudan.service.impl.UserServiceImpl" %>
<%@ page import="com.fudan.pojo.User" %>
<%!
    UserService userService = new UserServiceImpl();
    List<Img> imgs;
    Boolean status = true;// status = true 是自己的收藏，false是好友的。
    int pageSize = 8;
    int totalPage = 1;
    int currentPage = 1;

    public String pagesCreater(int i) {
        String tags = "<a id='previous'>&lt&lt</a>";
        for (int p = 1; p <= totalPage; p++) {
            tags += "<a id='page" + p + "' class='page'>" + p + "</a>";
        }
        tags += "<a id='next'>&gt&gt</a>";
        return tags;
    }
%>
<%
    if (request.getQueryString() != null) {
        System.out.println(request.getQueryString());
        status = false;
    }
    System.out.println("debug1 " + UserServiceImpl.getCookieByName(request, "username").getValue());
    System.out.println("debug2 " + userService.getUserByName("bianyuzhe"));
    System.out.println("status= " + status);
    User user = (status) ? userService.getUserByName(UserServiceImpl.getCookieByName(request, "username").getValue()) : userService.getUserByName(request.getQueryString().replace("UserName=", ""));
    System.out.println("status=" + status);
%>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width">
    <title>Favorite Projectouriscenary </title>
    <base href="<%= getServletConfig().getServletContext().getInitParameter("base")%>">
    <link rel="stylesheet" href="static/css/favorites.css">
    <script src='static/js/jquery-3.5.1.js'></script>
    <script src='static/js/vue.js'></script>
</head>

<body>
<nav class="dark" id='nav' style="opacity: 0.8;">
    <ul>
        <nav_left></nav_left>
        <component v-bind:is="whichcomp"></component>
        <skin_changer></skin_changer>
    </ul>
</nav>
<main>

    <div class="">

        <ul id="my-photos">
            <li class="headline"><%= status? "My favorites" :  user.getUsername()+"'s favorites"%>
                    <%if(status){
%>
                <svg id="footprint_btn" t="1595096347483" class="icon" viewBox="0 0 1024 1024" version="1.1"
                     xmlns="http://www.w3.org/2000/svg" p-id="1149" width="20" height="20">
                    <path d="M867.421091 109.381818a205.265455 205.265455 0 0 0-146.990546-61.905454 184.925091 184.925091 0 0 0-86.900363 21.224727 178.408727 178.408727 0 0 0-78.103273 220.485818c25.6 62.836364 41.239273 129.256727 46.219636 196.887273v14.801454l320.744728-31.883636 2.792727-210.757818a205.265455 205.265455 0 0 0-57.762909-148.852364z m-282.903273 453.445818a134.516364 134.516364 0 0 0 24.994909 167.796364 184.878545 184.878545 0 0 0 306.874182-135.912727V514.792727l-329.076364 32.814546c0.465455 5.12-0.465455 8.331636-2.792727 15.266909z m-199.68-298.123636a184.925091 184.925091 0 0 0-86.900363-21.271273 205.265455 205.265455 0 0 0-204.753455 210.292364l6.050909 210.804364 320.279273 30.021818v-14.801455c4.328727-66.699636 18.990545-132.328727 43.473454-194.56a178.408727 178.408727 0 0 0-78.149818-220.485818z m44.404364 478.859636l-329.076364-32.814545v79.965091a184.878545 184.878545 0 0 0 309.201455 134.981818 134.516364 134.516364 0 0 0 24.948363-167.796364c-2.327273-4.189091-3.258182-9.309091-5.12-14.336z"
                          fill="#565db0" p-id="1150"></path>
                </svg>
                <button id="privilege"
                        class="<%= (user.getState() == 1 )? "block":"allow"%>"><%= (user.getState() == 1) ? "block" : "allow"%>
                    friends' access
                </button>
                    <%}%>
                <aside>
            <li class="headline"><%= status ? "My" : user.getUsername() + "'s"%> footprints</li>
            <%
                if (status && session.getAttribute("footprint") != null) {
                    List<Img> foots = (List<Img>) session.getAttribute("footprint");
                    for (Img foot : foots) {
            %>
            <a href="pages/detail.jsp?ImageID=<%=foot.getImageID()%>"><%=foot.getTitle()%>
            </a><br>
            <%
                    }
                }
            %>
            </aside>
            </li>
            <li class="placeholder headline" id="placeholder">
                Empty here, favor pictures now!
                <svg t="1591878697641" class="icon" viewBox="0 0 1024 1024" version="1.1"
                     xmlns="http://www.w3.org/2000/svg" p-id="6001" width="200" height="200">
                    <path d="M855.6 427.2H168.5c-12.7 0-24.4 6.9-30.6 18L4.4 684.7C1.5 689.9 0 695.8 0 701.8v287.1c0 19.4 15.7 35.1 35.1 35.1H989c19.4 0 35.1-15.7 35.1-35.1V701.8c0-6-1.5-11.8-4.4-17.1L886.2 445.2c-6.2-11.1-17.9-18-30.6-18zM673.4 695.6c-16.5 0-30.8 11.5-34.3 27.7-12.7 58.5-64.8 102.3-127.2 102.3s-114.5-43.8-127.2-102.3c-3.5-16.1-17.8-27.7-34.3-27.7H119c-26.4 0-43.3-28-31.1-51.4l81.7-155.8c6.1-11.6 18-18.8 31.1-18.8h622.4c13 0 25 7.2 31.1 18.8l81.7 155.8c12.2 23.4-4.7 51.4-31.1 51.4H673.4zM819.9 209.5c-1-1.8-2.1-3.7-3.2-5.5-9.8-16.6-31.1-22.2-47.8-12.6L648.5 261c-17 9.8-22.7 31.6-12.6 48.4 0.9 1.4 1.7 2.9 2.5 4.4 9.5 17 31.2 22.8 48 13L807 257.3c16.7-9.7 22.4-31 12.9-47.8zM375.4 261.1L255 191.6c-16.7-9.6-38-4-47.8 12.6-1.1 1.8-2.1 3.6-3.2 5.5-9.5 16.8-3.8 38.1 12.9 47.8L337.3 327c16.9 9.7 38.6 4 48-13.1 0.8-1.5 1.7-2.9 2.5-4.4 10.2-16.8 4.5-38.6-12.4-48.4zM512 239.3h2.5c19.5 0.3 35.5-15.5 35.5-35.1v-139c0-19.3-15.6-34.9-34.8-35.1h-6.4C489.6 30.3 474 46 474 65.2v139c0 19.5 15.9 35.4 35.5 35.1h2.5z"
                          p-id="6002" fill="#5a5252e0"></path>
                </svg>
            </li>
            <%
                imgs = userService.myFavor(user.getUsername());
                totalPage = ((imgs.size() % pageSize == 0) ? (imgs.size() / pageSize) : (imgs.size() / pageSize + 1));
                if (!status && user.getState() == 0) {
                    System.out.println(user.getUsername());
                    System.out.println(user.getState());
                    System.out.println("111");
            %>
            <script>
                document.getElementById('placeholder').innerText = 'Access to friend\'s favorites is blocked.';
            </script>
            <%
            } else if (imgs.size() != 0) {
                System.out.println("222");

            %>
            <script>
                document.getElementById('placeholder').style = 'display:none';
            </script>
            <%
                if (status || user.getState() == 1)
                    System.out.println("333");

                for (Img im : imgs) {
            %>
            <%=im.getFavorImg()%>
            <%
                    }
                }%>


            <%--                    if (imgs.size() <= pageSize) {--%>
            <%--                        for (Img im : imgs) {--%>
            <%--                %>--%>
            <%--                <%=im.getFavorImg()%>--%>
            <%--                <%--%>
            <%--                    }--%>
            <%--                } else {--%>
            <%--                    totalPage = ((imgs.size() % pageSize == 0) ? (imgs.size() / pageSize) : (imgs.size() / pageSize + 1));--%>
            <%--                    if (session.getAttribute("favoritePageNumber") != null) {--%>
            <%--//                        currentPage = pageContext.;--%>
            <%--                    }--%>
            <%--                    if (currentPage != totalPage) {--%>
            <%--                        for (int i = 9 * currentPage - 9; i < 9 * currentPage; i++) {--%>
            <%--                %>--%>
            <%--                <%=imgs.get(i).getFavorImg()%>--%>
            <%--                <%--%>
            <%--                    }--%>
            <%--                } else {--%>
            <%--                    for (int i = 9 * totalPage - 9; i < imgs.size(); i++) {--%>
            <%--                %>--%>
            <%--                <%=imgs.get(i).getFavorImg()%>--%>
            <%--                <%--%>
            <%--                            }--%>
            <%--                        }--%>
            <%--                    }--%>
            <%--                %>--%>
        </ul>
        <ul>
        </ul>
        <input id="pageSize" hidden value="<%=pageSize%>">
        <input id="totalCount" hidden value="<%=imgs.size()%>">
        <input id="totalPage" hidden value="<%=totalPage%>">
        <input id="currentPage" hidden value="<%=currentPage%>">
        <blockquote id="pages">
            <%
                if (imgs.size() <= pageSize) {
            %>
            <a class='highlight' id="page1">1</a>
            <%
            } else {
            %>
            <%=pagesCreater(totalPage)%>
            <%
                }
                System.out.println("totalPage=" + totalPage + " currentPage=" + currentPage);
            %>
        </blockquote>
        <div class="clearboth"></div>
    </div>
    </div>
</main>


</body>

<footer id="footer"></footer>
<script src="static/js/paging.js"></script>
<script src="static/js/friends.js"></script>
<script src='static/js/nav&footer.js'></script>
<script src='static/js/change_skin.js'></script>
<script>
    document.getElementById("footprint_btn").onclick = function () {
        var aside = document.getElementsByTagName('aside')[0];
        aside.style.display = (aside.style.display != "block") ? "block" : "none";
    };
</script>

</html>