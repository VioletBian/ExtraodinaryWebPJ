package com.fudan.web.socket;


import javax.servlet.http.HttpSession;
import javax.websocket.EndpointConfig;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import java.nio.ByteBuffer;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;
import com.fudan.web.socket.Message.*;


@ServerEndpoint(value = "/websocket/chat/{relationID}", configurator = WsConfigurator.class)
public class TextController extends BaseController {

    private static final List<AbstractWsController> CONNECTIONS = new CopyOnWriteArrayList<>();

    private Message.RoomInfo roomInfo;




    @Override
    @OnOpen
    public void onOpen(Session session, EndpointConfig config,@PathParam(value = "relationID") String relationID) {
        // 获取HttpSession
        HttpSession httpSession = (HttpSession) config.getUserProperties().get(HttpSession.class.getName());
        // 从HttpSession中取得当前登录的用户作为当前连接的用户
        setUserName((String) httpSession.getAttribute("username"));
        System.out.println("弄到的username = "+getUserName());
        // 设置用户信息
        setUserName(getUserName());
        setSession(session);
        setRelationID(relationID);
        Message msg;
        // 设置聊天室信息
        if (CONNECTIONS.size() == 0) {
            setRoomInfo(new RoomInfo(getUserName(), (new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(new Date())));
//            msg = new Message(getUserName(), MsgConstant.OPEN);
        } else {
            Iterator<AbstractWsController> it = CONNECTIONS.iterator();
            TextController client = (TextController) it.next();
            setRoomInfo(client.getRoomInfo());

        }
//        msg = new Message(getUserName(), MsgConstant.SET_NAME);
        msg = new Message(getUserName(), MsgConstant.SET_NAME);

        msg.setRoomInfo(getRoomInfo());
        msg.setDests(new String[]{relationID});
        call(msg.toString());
        super.onOpen(session, config,relationID);

    }

    @Override
    @OnClose
    public void onClose() {
        super.onClose();
    }

//    @Override
    @OnMessage(maxMessageSize = 10000000)
    public void onMessage(String message) {
        System.out.println("消息要发给："+getRelationID());
        super.onMessage(message,getRelationID());
    }

    @Override
    @OnMessage(maxMessageSize = 10000000)
    public void onMessage(ByteBuffer message) {
        super.onMessage(message);
    }

    @Override
    @OnError
    public void onError(Throwable t) {
    }

    @Override
    List<AbstractWsController> getConnections() {
        return CONNECTIONS;
    }

    /**
     * 设置聊天室信息
     */
    private void setRoomInfo(RoomInfo roomInfo) {
        this.roomInfo = roomInfo;
    }

    private RoomInfo getRoomInfo() {
        return roomInfo;
    }

    @Override
    String getConnectType() {
        return "text";
    }

}
