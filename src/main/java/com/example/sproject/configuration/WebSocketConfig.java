package com.example.sproject.configuration;

import javax.servlet.ServletContext;
import javax.websocket.server.ServerContainer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.autoconfigure.websocket.servlet.TomcatWebSocketServletWebServerCustomizer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
import org.springframework.web.socket.server.standard.ServletServerContainerFactoryBean;

import com.example.sproject.handler.SampleSocketHandler;
import com.example.sproject.handler.SocketHandler;


@Configuration
@EnableWebSocket
public class WebSocketConfig implements WebSocketConfigurer {

	
//	@Autowired
//    private ServletContext servletContext;
	
	
	@Autowired
	@Qualifier("socketHandler")
	SocketHandler socketHandler;

	@Autowired
	@Qualifier("sampleSocketHandler")
	SampleSocketHandler sampleSocketHandler;	
	
	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		registry.addHandler(socketHandler, "/taking/{roomNumber}");
		registry.addHandler(sampleSocketHandler, "/socket/sample");
	}
	
//	@Bean
//	public TomcatWebSocketServletWebServerCustomizer tomcatWebSocketServletWebServerCustomizer() {
//	    return new TomcatWebSocketServletWebServerCustomizer();
//	}
	
	@Bean
	public ServletServerContainerFactoryBean createWebSocketContainer() {
//	ServerContainer serverContainer = (ServerContainer) this.servletContext.getAttribute("javax.websocket.server.ServerContainer");
	ServletServerContainerFactoryBean container = new ServletServerContainerFactoryBean();
	container.setMaxTextMessageBufferSize(3000000);
	container.setMaxBinaryMessageBufferSize(3000000);
	return container;
	}

}
