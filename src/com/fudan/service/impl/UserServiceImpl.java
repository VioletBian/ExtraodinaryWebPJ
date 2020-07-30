package com.fudan.service.impl;

import com.fudan.dao.ImgDao;
import com.fudan.dao.UserDao;
import com.fudan.dao.impl.ImgDaoImpl;
import com.fudan.dao.impl.UserDaoImpl;
import com.fudan.pojo.Comment;
import com.fudan.pojo.Img;
import com.fudan.pojo.User;
import com.fudan.service.UserService;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class UserServiceImpl implements UserService {

    private UserDao userDao = new UserDaoImpl();
    private ImgDao imgDao = new ImgDaoImpl();

    @Override
    public void registUser(User user) {
        userDao.saveUser(user);
    }

    @Override
    public User login(String username, String pass) {
        return userDao.queryUserByUsernameAndPassword(username, pass);
    }

    @Override
    public boolean existsUsername(String username) {

        if (userDao.queryUserByUsername(username) == null) {
           // 等于null,说明没查到，没查到表示可用
           return false;
        }

        return true;

    }

    @Override
    public User getUserByName(String username) {
        return userDao.queryUserByUsername(username);
    }

    public void refreshDb(){
        userDao.refresh();

    }

    @Override
    public List<Img> myFavor(String username) {
        return imgDao.queryImgByFavor(username);
    }

    @Override
    public List<Img> myImg(String username) {
        return imgDao.queryImgByUser(username);
    }

    @Override
    public List<Img> hotImgs() {
        return imgDao.queryImgByHot();
    }

    @Override
    public List<Img> newImgs() {
        return imgDao.queryImgByNew();
    }

    @Override
    public Img detail(String id) {
        return imgDao.queryImgByDetail(id);
    }

    @Override
    public boolean isFavored(String username, String id) {
        return imgDao.isFavored(username,id);
    }

    @Override
    public void favor(String username, String id) {
        imgDao.favor(username,id);

    }
    @Override
    public void unfavor(String username, String id) {
        imgDao.unfavor(username,id);

    }

    @Override
    public void delete(String username, String id) {
        imgDao.delete(username,id);

    }

    @Override
    public void upload(String username, Img img) {
        imgDao.upload(username,img);

    }

    @Override
    public void modify(String username, Img img) {
        imgDao.modify(username,img);

    }

    @Override
    public List<Img> search(boolean titleOrTheme, String input) {
        return imgDao.search(titleOrTheme,input);
    }

    @Override
    public List<User> friends(String username) {
        return userDao.queryUserFriends(username);
    }

    @Override
    public List<User> invitations(String username) {
        return userDao.queryInvitation(username);
    }

    @Override
    public boolean invite(String username, String target) {
        return userDao.invite(username,target);
    }

    @Override
    public void pass(String username, String target) {
        userDao.pass(username, target);

    }

    @Override
    public void block(String username) {
        userDao.block(username,true);

    }

    @Override
    public void allow(String username) {
        userDao.block(username,false);

    }

    @Override
    public List<Comment> getComments(String id) {
        System.out.println(imgDao.getComments(id));
        return imgDao.getComments(id);
    }

    @Override
    public void addComment(String id, String username, String content) {
        userDao.addComment(id, username, content);

    }

    @Override
    public void likeComment(int cid) {
        imgDao.likeComment(cid);

    }


    /**
     * 根据名字获取cookie
     * @param request
     * @param name cookie名字
     * @return
     */
    public static Cookie getCookieByName(HttpServletRequest request, String name){
        Map<String,Cookie> cookieMap = ReadCookieMap(request);
        if(cookieMap.containsKey(name)){
            Cookie cookie = (Cookie)cookieMap.get(name);
            return cookie;
        }else{
            return null;
        }
    }
    /**
     * 将cookie封装到Map里面
     * @param request
     * @return
     */
    private static Map<String,Cookie> ReadCookieMap(HttpServletRequest request){
        Map<String,Cookie> cookieMap = new HashMap<String,Cookie>();
        Cookie[] cookies = request.getCookies();
        if(null!=cookies){
            for(Cookie cookie : cookies){
                cookieMap.put(cookie.getName(), cookie);
            }
        }
        return cookieMap;
    }
}
