package com.fudan.test;

import com.fudan.pojo.User;
import com.fudan.service.UserService;
import com.fudan.service.impl.UserServiceImpl;
import org.junit.Test;

import static org.junit.Assert.*;

public class UserServiceTest {

    UserService userService = new UserServiceImpl();

    @Test
    public void registUser() {
        userService.registUser(new User(null, "bbb168", "666666", "bbb168@qq.com"));
        userService.registUser(new User(null, "aaa168", "666666", "aaa168@qq.com"));
    }

    @Test
    public void login() {
        System.out.println( userService.login("bianyuzhe","abcd1234"));
    }
    @Test
    public void existsUsername() {
        if (userService.existsUsername("byz168")) {
            System.out.println("用户名已存在！");
        } else {
            System.out.println("用户名可用！");
        }
    }
}