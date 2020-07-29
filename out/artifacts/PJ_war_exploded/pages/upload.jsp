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
    Boolean status = false;
    Img img = null;
    if (request != null && request.getQueryString() != null) {
        status = true;
        String query = request.getQueryString();
        img = userService.detail(query);
    }
%>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width">
    <title>Upload Projectouriscenary</title>
    <base href="<%= getServletConfig().getServletContext().getInitParameter("base")%>">
    <link rel="stylesheet" href="static/css/upload.css">
    <script src='static/js/jquery-3.5.1.js'></script>
    <script src="static/js/jquery.ajaxfileupload.js"></script>
    <script src='static/js/vue.js'></script>
    <script src='static/js/city.js'></script>
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
    <span class="headline">Upload your photos!</span>
    <div class="upload-form" onclick="document.querySelector('.js-file-input').click()">
        <button class="btn browse"><%=status ? "Change the file" : "Choose a file"%>
        </button>
    </div>
    <div class="display&info">
        <img class="display" src="<%=status?"static/img/normal/medium/"+img.getPath(): ""%>" alt="A Pic" id="myimg"
             style="<%=status?"display:block;":""%>">
        <form class="info" name="info" id="info" οnsubmit="return false;" method="post">
            <input type="file" id="file" class="hidden js-file-input"
                   accept="image/*" enctype="multipart/form-data"
                   multiple="">
            <ul id="upload-info" style="<%=status?"display:block;":""%>">
                <li><label>Title</label></li>
                <li><input type="text" class="upload title txt" name="title" id="title" required
                           value="<%=status? img.getTitle():""%>">
                </li>
                <li><label>Description</label></li>
                <li><textarea class="upload description txt" name="description" id="description" required
                              style="text-align: left"><%=status ? img.getDescription() : ""%></textarea></li>
                <li><label>Country</label></li>
                <select class="upload country" name="country" id="country"></select>
                <li><label>City</label></li>
                <select class="upload city" name="city" id="city"></select>
                <li><label>Theme</label></li>
                <select class="upload theme" name="theme" id="theme">
                    <option value="">Choose a theme</option>
                    <option value="scenery">Scenery</option>
                    <option value="modern">Modern</option>
                    <option value="religion">Religion</option>
                    <option value="relic">Relic</option>
                    <option value="romantic">Romantic</option>
                </select>
                <input name="original" hidden>
                <input name="ImageID" class="upload" hidden>
                <li>
                    <button class="btn" type="button"
                            id=<%=status? "btn-modify":"btn-upload"%> name="btn-upload"><%=status ? "Modify!" : "Submit!"%>
                    </button>
                </li>
            </ul>
        </form>
        <div class="clearboth"></div>
    </div>
    </div>
</main>
</body>

<footer id="footer"></footer>
<script src='static/js/nav&footer.js'></script>
<script src="static/js/upload.js"></script>
<script src='static/js/change_skin.js'></script>

<script>


    var arr_country = [];
    var arr_city = [];
    for (e in city) {
        arr_country.push(e);
        arr_city.push(city[e]);
    }

    function id$(x) {
        return document.getElementById(x);
    }

    //遍历的添加国家数据
    for (var i = 0; i < arr_country.length; i++) {
        var op = document.createElement("option");
        if (i != 0) op.value = arr_country[i];
        else op.value = "";
        op.innerText = arr_country[i];
        id$("country").appendChild(op);
    }
    //设置默认值
    var on = document.createElement("option");
    on.innerText = arr_city[0][0];
    id$("city").appendChild(on);

    id$("country").onchange = function () {
        console.log("selectedIndex= " + this.selectedIndex);
        //selectedIndex表示选中的索引值
        var index = this.selectedIndex;

        //添加前先删除sp
        id$("city").innerHTML = "";
        //遍历的添加城市数据
        for (var i = 0; i < arr_city[index].length; i++) {
            var sp = document.createElement("option");
            sp.value = arr_city[index][i];
            sp.innerText = arr_city[index][i];
            id$("city").appendChild(sp);
        }
        if (id$("city").classList.contains("emptyInput")) id$("city").classList.remove("emptyInput");
    }

</script>
<%
    if (status) {
        String city = img.getAsciiName().replace("'", "\'");
        {%>
<script>
    selectByData('theme', '<%=img.getContent()%>');
    selectByData('country', '<%=img.getCountryName()%>');
    inputs['country'].onchange();
    selectByData('city', "<%=img.getAsciiName()%>");
</script>
<%
        }
    }
%>
</html>