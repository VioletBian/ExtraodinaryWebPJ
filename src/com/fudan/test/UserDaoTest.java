package com.fudan.test;

import com.fudan.dao.UserDao;
import com.fudan.dao.impl.UserDaoImpl;
import com.fudan.pojo.User;
import org.junit.Test;

import static org.junit.Assert.*;

public class UserDaoTest {

    UserDao userDao = new UserDaoImpl();

    @Test
    public void queryUserByUsername() {

        if (userDao.queryUserByUsername("admin1234") == null ){
            System.out.println("用户名可用！");
        } else {
            System.out.println("用户名已存在！");
        }
    }

    @Test
    public void queryUserByUsernameAndPassword() {
        if ( userDao.queryUserByUsernameAndPassword("bianyuzhe","abcd1234") == null) {
            System.out.println("用户名或密码错误，登录失败");
        } else {
            System.out.println("查询成功");
        }
    }

    @Test
    public void saveUser() {
        User u = new User(null,"byz168", "123456", "byz168@qq.com");
        System.out.println( userDao.saveUser(u) );
        System.out.println("刚创建时是"+u.getPass() + "和" + u.getSalt());
    }
}