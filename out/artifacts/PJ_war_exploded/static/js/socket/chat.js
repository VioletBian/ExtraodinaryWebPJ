console.log(getQueryString("relationID") + "," + getLogStatus());

var MODE_TEXT = 0,
    NO_SOURCE = new Image(),
    chatterClient = new WSClient({
        host: "ws://" + window.location.host + "/websocket/chat/" + getQueryString("relationID"),
        // host: "ws://" + window.location.host + "/websocket/chat/"+ getQueryString("relationID") + "/" + getLogStatus(),
        type: MODE_TEXT,
        onopen: function () {
            $(".mainedit").ctrlEnter(".submit", function (event) {
                var message = {
                    type: 3,
                    msg: $(Console.targetClass).find(".mainedit").val()
                };
                if (message.msg.trim() != '') {
                    chatterClient.sendString(JSON.stringify(message));
                    console.log("open时，message=" + message);
                    $(Console.targetClass).find(".mainedit").val('')
                } else Console.log("You can not send empty message", false, 3000)
            });
            Console.log('WebSocket已连接.')
        },
        onclose: function () {
            $(".mainedit").ctrlEnter(".submit", function (event) {
                Console.log('WebSocket is break off, Please refresh it.', true)
            });
            Console.log('WebSocket已断开.', true)
        },
        wsonopen: function (msg) {
            console.log("咦嘿嘿嘿")
            chatterClient.initUserList(msg.dests);
            if (chatterClient.isMe(msg.host)) {
                msg = "You have entered the chat room."
            } else {
                msg = msg.host + " has entered the chat room"
            }
            Console.log(msg)
        },
        wsonclose: function (msg) {
            if (chatterClient.isMe(msg.host)) {
                chatterClient.initUserList(null);
                msg = "您已退出聊天室"
            } else {
                chatterClient.initUserList(msg.dests);
                msg = msg.host + "退出了聊天室"
            }
            Console.log(msg, true)
        },
        wsonmessage: function (msg) {
            // msg.msg = msg.msg.replace(/\n/g, "<br/>");
            msg.msg = msg.msg.replace(/\n/g, "<br/>");
            window.mss = msg;
            if (chatterClient.isMe(msg.host)) chatterClient.addOtherMsg(msg);
            else chatterClient.addMyMsg(msg)
        },
        // wsrequirelogin: function (msg) {
        //     document.location.href = "http://" + window.location.host + "/login.htm?to_url=" + document.location.href
        // },
        wssetname: function (msg) {
            chatterClient.setRoomInfo(msg.roomInfo);
            $("#user").text(chatterClient.option.userName);
        }
    });
chatterClient.addMyMsg = function (msg) {
    var console = Console.targetClass + " .console",
        obj = '<div class="row"><span class="headpic src" title="' + msg.host + '"></span><i class="src" style="border-bottom:5px solid #e8e8e8;"></i><div class="src" style="border:3px solid #f6f6f6;background-color: #fff""><p></p><br><p class="time">' + new Date().toLocaleString() + '</p></div>';
    obj = $(obj);
    obj.find("p").eq(0).html(msg.msg);
    obj.fadeIn('slow').appendTo(console);
    scrollToBottom($(console))
};
chatterClient.addOtherMsg = function (msg) {
    var console = Console.targetClass + " .console",
        obj = '<div class="row"><span class="headpic" title="' + msg.host + '"></span><i></i><div class="dest"><p></p><br><p class="time">' + new Date().toLocaleString() + '</p></div>';
    obj = $(obj);
    obj.find("p").eq(0).html(msg.msg);
    obj.fadeIn('slow').appendTo(console);
    scrollToBottom($(console))
};

// 用于创建聊天室的信息，比如聊天室所属用户，创建时间。
chatterClient.setRoomInfo = function (roomInfo) {
    if (!roomInfo) {
        return;
    }
    var _str = new StringBuffer();
    var creator = roomInfo.creator || "神秘用户";
    var createTime = roomInfo.createTime || new Date().toLocaleString();
    _str.append('<span class="host">' + creator + '</span>');
    _str.append('创建于' + createTime);
    $(".mwd .pageTop .title").html(_str.toString())
};
chatterClient.initUserList = function (list) {
    console.log(list);
    var userlist = ".mwd .mode-text .pageRight";
    console.log("啊哈哈哈哈哈哈");
    if (list == null || typeof (list) == "undefined" || list.length == 0) {
        $(userlist).html('');
        console.log("哦吼吼吼");
        return;
    }
    var _str = new StringBuffer();
    //
    // if (host != creator) {
    //     console.log("kkp:host=" + host + ", creator=" + creator);
    //     list = [list, host];
    //     console.log("list====" + list)
    // } else if (list.length == 1) {
    //     console.log("list=" + list[0])
    //     list[0] = host;
    // }
    {
        for (var i = 0; i < list.length; i++) {
            _str.append('<div class="row">');
            if (i % 2 == 0) {
                _str.append('<img class="headpic" height="40" width="40" title="' + list[i] + '" src="../static/img/websocket/headpic.jpg"></img>');
            }else{
                _str.append('<img class="headpic" height="40" width="40" title="' + list[i] + '" src="../static/img/websocket/headpic2.jpg"></img>');

            }
            _str.append('<a class="user" id=n_' + list[i] + ' title="' + list[i] + '">' + list[i] + '</a>');
            _str.append('</div>')
        }
    }
    $(userlist).html(_str.toString())
};


var Console = {
    targetClass: ".mwd .mode-text",
    mode: MODE_TEXT,
    isFull: false,
    isMin: false,
    setMode: function (mode) {
        if (Console.mode == mode) {
            return
        }
        Console.mode = mode;
        switch (mode) {
            case MODE_TEXT:
                Console.targetClass = ".mwd .mode-text";
                break;
        }
        $(Console.targetClass).siblings("[class^='mode-']").hide();
        $(Console.targetClass).show()
    },
    log: function (message, error, delay) {
        if (message == "") return;
        delay = delay || 10000;
        var v = $(Console.targetClass).find(".edit .buttons .info");
        v.html(message);
        v.attr("title", message);
        if (error) v.addClass("error");
        setTimeout(function () {
            v.removeClass("error").html("")
        }, 5000)
    },
    resize: function () {
        var padding = parseInt($(Console.targetClass).find(".pageRight").css("padding-left"));
        $(Console.targetClass).find(".pageLeft").width(parseInt($(".mwd").width() - $(Console.targetClass).find(".pageRight").width() - padding * 2));
        $(".content").height(parseInt($(".mwd").height() - $(".pageTop").height() - $(".edit").height() - 19))
    },
    toggleFullScreen: function () {
        Console.isFull = !Console.isFull;
        if (Console.isFull) {
            $(".mwd").addClass("mwd_full");
            $("h2").hide()
        } else {
            $(".mwd").removeClass("mwd_full");
            $("h2").show()
        }
        Console.resize()
    },
    toggleMin: function () {
        Console.isMin = !Console.isMin;
        if (Console.isMin) {
            $(".mwd").fadeOut('quick');
            $("#min-max").fadeIn('quick')
        } else {
            $("#min-max").fadeOut('quick');
            $(".mwd").fadeIn('quick')
        }
    },
    minToMax: function () {
        Console.toggleMin();
        Console.isMin = false;
        if (!Console.isFull) Console.toggleFullScreen()
    },
    close: function () {
        chatterClient.online && chatterClient.close();
        videoClient.online && videoClient.close();
        audioClient.online && audioClient.close();
        CloseWindow()
    }
};

function getQueryString(name) {
    var reg = new RegExp('(^|&)' + name + '=([^&]*)(&|$)', 'i');
    var r = window.location.search.substr(1).match(reg);
    if (r != null) {
        return unescape(r[2]);
    }
    return null;
}

function getLogStatus() {
    var arr = document.cookie.match(new RegExp("(^| )" + "username" + "=([^;]*)(;|$)"));
    if (arr != null) {
        return unescape(arr[2]);
    }
    return false;
}

