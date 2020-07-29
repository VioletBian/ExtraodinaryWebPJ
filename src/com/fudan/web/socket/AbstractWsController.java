package com.fudan.web.socket;

import com.alibaba.fastjson.JSONObject;
import com.fudan.utils.StringUtil;

import javax.websocket.EndpointConfig;
import javax.websocket.RemoteEndpoint;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.util.List;
import com.fudan.web.socket.Message.*;

public abstract class AbstractWsController {


    /**
     * Websocket 通讯 抽象类
     *
     * @author anyesu
     */


    private Session session;
    private String userName;

    protected String getRelationID() {
        return relationID;
    }

    protected void setRelationID(String relationID) {
        this.relationID = relationID;
    }

    private String relationID;

    /**
     * 当前所有连接
     *
     * @return 当前所有连接
     */
    abstract List<AbstractWsController> getConnections();

    /**
     * 返回连接类型
     *
     * @return 连接类型
     */
    abstract String getConnectType();

    /**
     * websocket连接建立后触发
     *
     * @param session 当前连接通道
     * @param config  配置
     */
    protected void onOpen(Session session, EndpointConfig config, @PathParam(value = "relationID") String relationID) {
        getConnections().add(this);
        String[] dests = new String[1];
        dests[0] = relationID;
        broadcast2Special(new Message(getUserName(), MsgConstant.OPEN, getUsers()).toString(),dests);
        broadcast2Self(new Message(getUserName(), MsgConstant.OPEN, getUsers()).toString());
        System.out.println(getConnectType() + ": " + getUserName() + "加入了，当前总人数：" + getConnections().size());
    }

    /**
     * websocket连接断开后触发
     */
    protected void onClose() {
        getConnections().remove(this);
        broadcast2Others(new Message(getUserName(), MsgConstant.CLOSE, getUsers()).toString());
        System.out.println(getConnectType() + ": " + getUserName() + "退出了，当前总人数：" + getConnections().size());
    }

    /**
     * 接受客户端发送的字符串
     *
     * @param message 字符串消息
     */
    protected void onMessage(String message, String relation) {
        Message msg = JSONObject.parseObject(message, Message.class);
        msg.setHost(getUserName());
        msg.setDests(new String[]{relation});
        broadcast2Special(msg.toString(),msg.getDests());
    }

    /**
     * 接收客户端发送的字节流
     *
     * @param message 二进制消息
     */
    protected void onMessage(ByteBuffer message) {
        broadcast2Others(message);
    }

    /**
     * 发生错误
     */
    protected void onError(Throwable t) {
    }

    /**
     * 广播给所有用户
     *
     * @param msg 消息
     */
    protected <T> void broadcast2All(T msg) {
        for (AbstractWsController client : getConnections()) {
            client.call(msg);
        }
    }

    /**
     * 发送给指定的用户
     *
     * @param msg 消息
     */
    protected <T> void broadcast2Special(T msg, String[] dests) {
        for (AbstractWsController client : getConnections()) {
            System.out.println("relationID="+getRelationID());
            if (StringUtil.contains(dests, client.getUserName()) && getUserName().equals(client.getRelationID())) {
                System.out.println("符合私聊条件");
                client.call(msg);
            }
        }
    }
    /**
     * 发送给自己
     *
     * @param msg 消息
     */
    protected <T> void broadcast2Self(T msg) {
        for (AbstractWsController client : getConnections()) {
            if (getUserName().equals(client.getUserName()) && getRelationID().equals(client.getRelationID())) {
                System.out.println("符合自推条件");
                client.call(msg);
            }
        }
    }
    /**
     * 广播给除了自己外的用户
     *
     * @param msg 消息
     */
    protected <T> void broadcast2Others(T msg) {
        for (AbstractWsController client : getConnections()) {
            if (!client.getUserName().equals(this.getUserName())) {
                client.call(msg);
            }
        }
    }


    /**
     * 同步方式向客户端发送字符串
     *
     * @param msg 参数类型为String或ByteBuffer
     */
    protected <T> void call(T msg) {
        try {
            synchronized (this) {
                RemoteEndpoint.Basic remote = this.getSession().getBasicRemote();
                if (msg instanceof String) {
                    remote.sendText((String) msg);
                } else if (msg instanceof ByteBuffer) {
                    remote.sendBinary((ByteBuffer) msg);
                }

            }
        } catch (IOException e) {
            try {
                this.getSession().close();
            } catch (IOException ignored) {
            }
            onClose();
        }
    }

    protected void setSession(Session session) {
        this.session = session;
    }

    protected Session getSession() {
        return this.session;
    }

    protected String getUserName() {
        return userName;
    }

    protected void setUserName(String userName) {
        this.userName = userName;
    }

    protected String[] getUsers() {
        int i = 0;
        String[] destArrary = new String[getConnections().size()];
        for (AbstractWsController client : getConnections()) {
            destArrary[i++] = client.getUserName();
        }
        return destArrary;
    }
}

