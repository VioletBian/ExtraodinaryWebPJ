package com.fudan.service;

import com.fudan.pojo.Img;
import com.fudan.pojo.User;

import java.util.List;

public interface UserService {
    /**
     * 注册用户
     * @param user
     */
    public void registUser(User user);

    /**
     * 登录
     * @param username
     * @return 如果返回null，说明登录失败，返回有值，是登录成功
     */
    public User login(String username, String pass);

    /**
     * 检查 用户名是否可用
     * @param username
     * @return 返回true表示用户名已存在，返回false表示用户名可用
     */
    public boolean existsUsername(String username);
    public User getUserByName(String username);

    public void refreshDb();

    public List<Img> myFavor(String username);
    public List<Img> myImg(String username);

    public List<Img> hotImgs();

    public List<Img> newImgs();

    public Img detail(String id);

    public boolean isFavored(String username, String id);

    public void favor(String username,String id);
    public void unfavor(String username,String id);
    public void delete(String username,String id);

    public void upload(String username,Img img);
    public void modify(String username,Img img);
    public List<Img> search(boolean titleOrTheme ,String input);
    public List<User> friends(String username);
    public List<User> invitations(String username);
    public boolean invite(String username, String target);
    public void pass(String username, String target);
    public void block(String username);
    public void allow(String username);


}
