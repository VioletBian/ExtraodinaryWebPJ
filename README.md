# 项目说明文档

18307110428 卞雨喆



1. 完成情况

	* 基础部分：全部完成

	* bonus：除云部署外（因实例续约问题没有做）都完成了。

		内容有：

		* 项目说明文档。5分 
		* 详情页面图片局部放大功能。 5分
		* 注册与登录验证码功能。5分 
		* 用户可以对图片评论并按照时间和热度显示在详情页下方。5分 
		* 好友用户实时聊天。15分
		* 高级、全面的模糊搜索。5分

2. bonus实现思路与细节

	1. 局部放大：

		> 通过js对鼠标位置定位，计算出遮罩中心位置，并将缩放后的大图展示出来。

		

	2. 验证码

		> 配合goole-kaptcha的jar包实现后台验证码值和前台验证码图的同步，以及点击图片更换验证码。

		

	3. 实时聊天

		* 后端：

			* 使用websocket实现实时聊天。
			* WsConfigurator 继承 ServerEndpointConfig.Configurator类，从Handshake中获取httprequest，实现从cookie或session中获取用户名。

			```java
			public class WsConfigurator extends ServerEndpointConfig.Configurator {
				@Override
				public void modifyHandshake(ServerEndpointConfig config, HandshakeRequest request, HandshakeResponse response) {
					// 通过配置来获取httpSession
					HttpSession httpSession = (HttpSession) request.getHttpSession();
					String username = "";
					String[] cookies = request.getHeaders().get("cookie").toString().split("; ");
					System.out.println(cookies);
			    // 在session和cookie中查找username，确保找到。
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
			```

			

			* Message类打包message实例，设置消息类型、消息host和dests等，同时实现【可序列化】接口。

			```java
			   public Message(String host, int type, String[] dests) {
			        this(host, type);
			        setDests(dests);
			    }
			
			    @Override
			    public String toString() {
					/*
					  序列化成json串
					 */
			        return JSONObject.toJSONString(this);
			    }
			```

			

			* TextController类及父类（后台主程序）建立连接实例时，使用静态类常量储存自身；@ServerEndPoint注释注册ws服务器，@PathParam注入私聊对象名称；重写@OnOpen/@OnMessage/@OnClose等方法；通过与客户端会话session（不是http的session）找到BasicRemote()，实现同步广播给指定连接、指定客户端。

			```java
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
			```

		* 前端:
			* `window.WSClient`函数对象实现了消息类型、连接后open、message、close的函数
			* `chatterClient`的实例对象和ws主机之间实现了通信，通过路径给后台注入了私聊对象名称参数。调用上述函数正确反射，实现了`isMe()`判断消息主体，`addMyMsg()/addOtherMsg()`输出前台消息，`initUserList()`在右侧在线列表中更新在线用户。

		

	4. 高级搜索

		* "北京 大学"匹配"北京大学"、''北京xx大学''、"大学在北京"
		* "Prak" 匹配 "Park"

	5. 评论



3. 过程中的问题

	1. jvm和mysql时区相差13小时，因为 JDBC 连接到 MySQL 把 CST 时区识别成了 `Central Standard Tim UT-6:00` **美国中部标准时间**，如果是夏令时，就是 `Central Standard Tim UT-5:00`，中国所在时区是 `+8:00`，这里美国是 `-5:00`，正好相差 13 小时。

		（这个问题还蛮有意思的）

		【解决】在 Java 中 JDBC 连接配置出加入 `serverTimezone=GMT%2B8` 。

	2. 实时聊天断联

		参数传入失败，当username通过cookie保存而非此次工程生命周期期间session保存时username = null。

		【解决】在WSConfigurator类中加入判断，优先使用session，cookie作为备选。

	3. 实时聊天在线列表不更新

		发现在新用户加入时老用户才会刷新列表，判断是OnOpen时出了问题。最后发现广播OnMessage包含自己，OnOpen时没有广播给自己。

		【解决】@OnOpen加入广播对象:自己。

	4. 动不动就后台弹出警告：数据连接等类长时间连接，已停用xxx

		【解决】查询搜索引擎得知是Mysql-connector-java.jar版本适配问题。

	5. 更改了js等资源，没有效果。（这个问题最烦人了）

		【解决】Chrome会保存缓存，建议调试时使用无痕浏览。





