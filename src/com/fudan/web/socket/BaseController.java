package com.fudan.web.socket;

import com.alibaba.fastjson.JSONObject;
import com.fudan.utils.StringUtil;


public abstract class BaseController extends AbstractWsController {

	private static final String CONNECT_TYPE_TEXT = "text";

	/**
	 * 接受客户端发送的字符串
	 *
	 * @param message 字符串消息
	 */
	@Override
	protected void onMessage(String message, String relation) {
		Message msg = JSONObject.parseObject(message, Message.class);
		msg.setHost(getUserName());
		msg.setDests(new String[]{relation});
		if (CONNECT_TYPE_TEXT.equals(getConnectType())) {
			msg.setMsg(StringUtil.txt2htm(msg.getMsg()));
			if (msg.getDests() == null) {
				System.out.println("无语了还是公放");
				broadcast2All(msg.toString());
			} else {
				System.out.println("太好了是私放");
				broadcast2Special(msg.toString(), msg.getDests());
				broadcast2Self(msg.toString());
			}
		} else {
			broadcast2Others(msg.toString());
		}
	}

}
