package websocket;

import java.util.HashSet;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;
/*
 * 출처 : 	http://blog.naver.com/PostView.nhn?blogId=beabeak&logNo=220471878778&parentCategory
         	No=&categoryNo=86&viewDate=&isShowPopularPosts=true&from=search
 */
public class SocketHandler2 extends TextWebSocketHandler implements InitializingBean {
	private final Logger logger = LoggerFactory.getLogger(SocketHandler2.class);

	private Set<WebSocketSession> sessionSet = new HashSet<WebSocketSession>();

	public SocketHandler2() {
		super();
		this.logger.info("create SocketHandler instance!");
	}
	
	/* WebSocket 연결이 닫혔을 때 호출 */
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		super.afterConnectionClosed(session, status);
		sessionSet.remove(session);
		this.logger.info("remove session!");
	}

	/* WebSocket 연결이 열리고 사용이 준비될 때 호출 */
	@Override
	public void afterConnectionEstablished(WebSocketSession session)

			throws Exception {

		super.afterConnectionEstablished(session);

		sessionSet.add(session);

		this.logger.info("add session!");

	}
	/* 클라이언트로부터 메시지가 도착했을 때 호출 */
	@Override
	public void handleMessage(WebSocketSession session,

			WebSocketMessage<?> message) throws Exception {

		super.handleMessage(session, message);

		this.logger.info("receive message:" + message.toString());

	}
    
	/* 전송 에러 발생할 때 호출 */
	@Override
	public void handleTransportError(WebSocketSession session,

			Throwable exception) throws Exception {

		this.logger.error("web socket error!", exception);

	}
	/* WebSocketHandler가 부분 메시지를 처리할 때 호출 */
	@Override
	public boolean supportsPartialMessages() {

		this.logger.info("call method!");

		return super.supportsPartialMessages();

	}

	public void sendMessage(String message) {

		for (WebSocketSession session : this.sessionSet) {

			if (session.isOpen()) {

				try {

					session.sendMessage(new TextMessage(message));

				} catch (Exception ignored) {

					this.logger.error("fail to send message!", ignored);

				}

			}

		}

	}

	@Override

	public void afterPropertiesSet() throws Exception {
		Thread thread = new Thread() {
			int i = 0;

			@Override
			public void run() {
				while (true) {
					try {
						sendMessage("send message index " + i++);
						Thread.sleep(1000);
					} catch (InterruptedException e) {
						e.printStackTrace();
						break;
					}
				}
			}
		};
		thread.start();
	}
}
