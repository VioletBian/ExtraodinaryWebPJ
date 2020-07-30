<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ page import="com.fudan.pojo.Img" %>
<%@ page import="com.fudan.service.UserService" %>
<%@ page import="com.fudan.service.impl.UserServiceImpl" %>
<%!
    UserService userService = new UserServiceImpl();
    List<Img> imgs;
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
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width">
    <title>My Projectouriscenary photos</title>
    <base href="<%= getServletConfig().getServletContext().getInitParameter("base")%>">
    <link rel="stylesheet" href="static/css/my_photos.css">
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
            <ul id="my-photos">
                <li class="headline">My photos</li>
                <li class="placeholder headline" id="placeholder">
                    Empty here, upload yours now!
                    <svg  t="1591878697641" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="6001" width="200" height="200"><path d="M855.6 427.2H168.5c-12.7 0-24.4 6.9-30.6 18L4.4 684.7C1.5 689.9 0 695.8 0 701.8v287.1c0 19.4 15.7 35.1 35.1 35.1H989c19.4 0 35.1-15.7 35.1-35.1V701.8c0-6-1.5-11.8-4.4-17.1L886.2 445.2c-6.2-11.1-17.9-18-30.6-18zM673.4 695.6c-16.5 0-30.8 11.5-34.3 27.7-12.7 58.5-64.8 102.3-127.2 102.3s-114.5-43.8-127.2-102.3c-3.5-16.1-17.8-27.7-34.3-27.7H119c-26.4 0-43.3-28-31.1-51.4l81.7-155.8c6.1-11.6 18-18.8 31.1-18.8h622.4c13 0 25 7.2 31.1 18.8l81.7 155.8c12.2 23.4-4.7 51.4-31.1 51.4H673.4zM819.9 209.5c-1-1.8-2.1-3.7-3.2-5.5-9.8-16.6-31.1-22.2-47.8-12.6L648.5 261c-17 9.8-22.7 31.6-12.6 48.4 0.9 1.4 1.7 2.9 2.5 4.4 9.5 17 31.2 22.8 48 13L807 257.3c16.7-9.7 22.4-31 12.9-47.8zM375.4 261.1L255 191.6c-16.7-9.6-38-4-47.8 12.6-1.1 1.8-2.1 3.6-3.2 5.5-9.5 16.8-3.8 38.1 12.9 47.8L337.3 327c16.9 9.7 38.6 4 48-13.1 0.8-1.5 1.7-2.9 2.5-4.4 10.2-16.8 4.5-38.6-12.4-48.4zM512 239.3h2.5c19.5 0.3 35.5-15.5 35.5-35.1v-139c0-19.3-15.6-34.9-34.8-35.1h-6.4C489.6 30.3 474 46 474 65.2v139c0 19.5 15.9 35.4 35.5 35.1h2.5z" p-id="6002" fill="#5a5252e0"></path></svg>
                </li>
                <%
                    imgs = userService.myImg(UserServiceImpl.getCookieByName(request, "username").getValue());
                    totalPage = ((imgs.size() % pageSize == 0) ? (imgs.size() / pageSize) : (imgs.size() / pageSize + 1));

                    if (imgs.size() != 0) {%>
                <script>
                    document.getElementById('placeholder').style = 'display:none';
                </script>
                <%
                    }
                    for (Img im : imgs) {
                %>
                <%=im.getMyImg()%>
                <%
                    }%>
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

    </main>



</body>

<footer id="footer"></footer>
<script src='static/js/nav&footer.js'></script>
<script src="static/js/paging.js"></script>
<script src='static/js/change_skin.js'></script>
<script>
    $("#delete a").click(function(){
        if(confirm("Confirm deleting this image?")){
            location.href($("#delete a").attr(href));
        }else{
            return false;
        }
    });

</script>

</html>