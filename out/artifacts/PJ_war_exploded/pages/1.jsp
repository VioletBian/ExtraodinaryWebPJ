<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <base href="<%= getServletConfig().getServletContext().getInitParameter("base")%>">
    <link rel="stylesheet" href="static/css/my_photos.css">
    <link rel="stylesheet" href="static/css/friends.css">
    <title>Index</title>
    <script type="text/javascript">
        var ws = null;
        function startWebSocket() {
            if ('WebSocket' in window)
                ws = new WebSocket("ws://localhost:8080/PJ_war_exploded/websocket/{user}");
            else if ('MozWebSocket' in window)
                ws = new MozWebSocket("ws://localhost:8080/PJ_war_exploded/websocket/{user}");
            else
                alert("not support");


            ws.onmessage = function(evt) {
                alert(evt.data);
            };

            ws.onclose = function(evt) {
                alert("close");
            };

            ws.onopen = function(evt) {
                alert("open");
            };
        }

        function sendMsg() {
            ws.send(document.getElementById('writeMsg').value);
        }
    </script>
</head>
<body onload="startWebSocket();">
<div id="chat">
    <ul class="chat-thread">
        <li>Are we meeting today?</li>
        <li>yes, what time suits you?</li>
        <li>I was thinking after lunch, I have a meeting in the morning</li>
    </ul>

    <form class="chat-window">
        <input id="writeMsg" class="chat-window-message" name="chat-window-message" type="text" autocomplete="off" autofocus />
        <input type="button" value="send" onclick="sendMsg()"></input>
    </form>
</div>
</body>
</html>
