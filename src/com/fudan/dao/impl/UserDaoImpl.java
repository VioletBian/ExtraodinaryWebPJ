package com.fudan.dao.impl;

import com.fudan.dao.UserDao;
import com.fudan.pojo.User;

import java.util.List;

public class UserDaoImpl extends BaseDao implements UserDao {
    @Override
    public User queryUserByUsername(String username) {
        String sql = "select `UserName`,`Pass`,`Salt`,`UID`, `State` from traveluser where UserName = ?";
        return queryForOne(User.class, sql, username);
    }

    @Override
    public User queryUserByUsernameAndPassword(String username, String password) {
        if (queryUserByUsername(username) == null) return null;
        User u = queryUserByUsername(username);
        String sql = "select `UserName`,`Pass` from traveluser where UserName = ? and Pass = ?";
        return queryForOne(User.class, sql, username,u.passConvert(password,u.getSalt()));
    }

    @Override
    public int saveUser(User user) {
        String sql = "insert into traveluser(`UserName`,`Pass`,`Email`,`Salt`) values(?,?,?,?)";
        return update(sql, user.getUsername(),user.getPass(),user.getEmail(),user.getSalt());
    }
    @Override
    public void refresh(){
        String sql = "select `UserName`,`Pass`,`Salt` from traveluser";
        List<User> Users = queryForList(User.class,sql);
        for (User u : Users){
            User you = new User(u.getUID(),u.getUsername(),"abcd1234",u.getEmail());
            String sq = "update traveluser set Salt = '" + you.getSalt() + "', Pass = '" + you.getPass() + "' where UserName = '" + you.getUsername() +"'";
            update(sq);
        }
    }

    @Override
    public List<User> queryUserFriends(String username) {
        User u = queryUserByUsername(username);
        String sql1 = "select a.UserName, a.Email, a.DateJoined, a.UID, b.relationID from traveluser as a, userfriends as b where b.UID = ? and b.FriendID = a.UID and b.Status = 1";
        String sql2 = "select a.UserName, a.Email, a.DateJoined, a.UID, b.relationID from traveluser as a, userfriends as b where b.FriendID = ? and b.UID = a.UID and b.Status = 1";
        List<User> results = queryForList(User.class,sql1,u.getUID());
        for(User uu : queryForList(User.class,sql2,u.getUID())){
            results.add(uu);
        }
        return results;
    }

    @Override
    public List<User> queryInvitation(String username) {
        User u = queryUserByUsername(username);
        String sql = "select a.UserName, a.Email, a.DateJoined, a.UID from traveluser as a, userfriends as b where b.FriendID = ? and b.UID = a.UID and b.Status = 0";
        return queryForList(User.class,sql,u.getUID());
    }
    @Override
    public boolean invite(String username, String target){
        if(queryUserByUsername(target) == null) {
            System.out.println(1);
            System.out.println(target);
            return false;
        }
        else{
            User targetUser = queryUserByUsername(target);
            User me = queryUserByUsername(username);
            // 我的朋友里没有他
            for(User u : queryUserFriends(username)){
                if(u.getUID() == targetUser.getUID()) {
                    return false;}
            }
            // 我的好友申请里没有他
            for(User u : queryInvitation(username)){
                if(u.getUID() == targetUser.getUID()) {
                    return false;}
            }
            // 他的好友申请里没有我
            for(User u : queryInvitation(targetUser.getUsername())){
                if(u.getUID() == me.getUID()) {
                    return false;}
            }
            User user = queryUserByUsername(username);
            String sql = "insert into userfriends(`UID`,`FriendID`) values (?,?)";
            update(sql,user.getUID(),targetUser.getUID());
            return true;
        }
    }

    @Override
    public void pass(String username, String target) {
        String sql = "update userfriends set Status = 1 where UID = ? and FriendID = ?";
        update(sql,queryUserByUsername(target).getUID(),queryUserByUsername(username).getUID());

    }

    @Override
    public void block(String username,boolean blockOrAllow) {
        int i = (blockOrAllow)? 0:1;
        String sql = "update traveluser set State = ? where UserName = ?";
        update(sql,i,username);

    }

    @Override
    public void addComment(String id, String username, String content) {
        id = id.replace("ImageID=","");
        int ID = Integer.parseInt(id);
        String sql = "insert into `comments` (ImageID,UserName,content) values (?,?,?)";
        update(sql,id,username,content);

    }



}
