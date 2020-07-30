package com.fudan.web.socket;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpSession;
import javax.websocket.HandshakeResponse;
import javax.websocket.server.HandshakeRequest;
import javax.websocket.server.ServerEndpointConfig;


public class WsConfigurator extends ServerEndpointConfig.Configurator {
	@Override
	public void modifyHandshake(ServerEndpointConfig config, HandshakeRequest request, HandshakeResponse response) {
		// 通过配置来获取httpSession
		HttpSession httpSession = (HttpSession) request.getHttpSession();
		String username = "";
		String[] cookies = request.getHeaders().get("cookie").toString().split("; ");
		System.out.println(cookies);
		for(int i = 0; i < cookies.length; i++){
			String x  =  cookies[i];
			System.out.println(x);
			if (x.contains("username=")){
				System.out.println("yes,x="+x);
				username = x.replace("username=","");
				System.out.println(username);
			}
		}
		if (httpSession != null) {
			if(httpSession.getAttribute("username") == null){httpSession.setAttribute("username",username);}
			System.out.println(HttpSession.class.getName());
			config.getUserProperties().put(HttpSession.class.getName(), httpSession);
		}
	}
}
