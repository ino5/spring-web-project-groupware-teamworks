package com.example.sproject.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import com.example.sproject.model.login.Member;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class SpringConfig extends WebSecurityConfigurerAdapter {

	public SpringConfig() {
		System.out.println("Method SpringConfig in Class SpringConfig");
	}

	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}
	
	@Override
	public void configure(WebSecurity web) throws Exception {
		web.ignoring().antMatchers("/**/css/**", "/**/js/**", "/**/img/**", "/**/lib/**", "/**/upload/**");
	}
	
	
	@Override
	protected void configure(HttpSecurity http) throws Exception {
        //URL 권한 체크
		http.authorizeRequests()
	        .antMatchers("/admin/**").hasRole("ADMIN")
	        .antMatchers("/member1/**").authenticated()
	        .antMatchers("/member2/**").authenticated()
	        .antMatchers("/drive/**").authenticated()
	        .antMatchers("/**").permitAll();
		
		//로그인 관련
		http.formLogin()
	        .loginPage("/login/login")
	        .defaultSuccessUrl("/login")
	        .permitAll()
	        .usernameParameter(Member.usernameParameter)
	        .passwordParameter(Member.passwordParameter);
		
		http.logout()
	        .logoutRequestMatcher(new AntPathRequestMatcher("/login/logout"))
	        .logoutSuccessUrl("/login/login")
	        .invalidateHttpSession(true);
		
		http.exceptionHandling()
	        .accessDeniedPage("/login/denied");
	}
	
}
