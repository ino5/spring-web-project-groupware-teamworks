package com.example.sproject.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
import org.springframework.web.socket.server.standard.ServletServerContainerFactoryBean;

import com.example.sproject.handler.SocketHandler;


@Configuration
@EnableWebSocket
public class WebSocketConfig implements WebSocketConfigurer {

	@Autowired
	SocketHandler socketHandler;
	
	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		registry.addHandler(socketHandler, "/taking/{roomNumber}");

	}
	
	@Bean
	public ServletServerContainerFactoryBean createWebSocketContainer() {
	ServletServerContainerFactoryBean container = new ServletServerContainerFactoryBean();
	container.setMaxTextMessageBufferSize(500000);
	container.setMaxBinaryMessageBufferSize(500000);
	return container;
	}

}
