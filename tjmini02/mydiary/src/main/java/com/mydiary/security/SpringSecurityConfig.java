package com.mydiary.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

@Configuration
@EnableWebSecurity
public class SpringSecurityConfig extends WebSecurityConfigurerAdapter {
    @Override
    protected void configure(HttpSecurity http) throws Exception {
    	/*
        http
                .authorizeRequests()
                    .antMatchers("/").permitAll()
                    .antMatchers("/mydirary/mypage").hasRole("USER", "ADMIN", "MANAGER")
                    .anyRequest().authenticated()
                .and()
                    .formLogin()
                    .defaultSuccessUrl("/mydirary", true)
                    .permitAll()
                .and()
                    .logout();
        http.formLogin().permitAll();
        http.logout().permitAll();
        */
    }
    
    @Autowired
    public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception{
    	//auth.inMemoryAuthentication().withUser("user")
    }
    @Override
    public void configure(WebSecurity web) throws Exception {
        web.ignoring().antMatchers("/static/js/**","/static/css/**","/static/img/**","/static/frontend/**");
    }
}