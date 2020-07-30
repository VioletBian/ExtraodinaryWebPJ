package com.fudan.pojo;

import java.util.Date;

public class Comment {

    private int id;
    private String username;
    private int ImageID;
    private String content;
    private int likes;
    private Date time;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public int getImageID() {
        return ImageID;
    }

    public void setImageID(int imageID) {
        ImageID = imageID;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getLikes() {
        return likes;
    }

    public void setLikes(int likes) {
        this.likes = likes;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public String output(){
        return "<li id='"+this.id+"'>\n" +
                "<div class=\"user\">"+this.username+":<span><svg class='like' t=\"1596117182710\" class=\"icon\" viewBox=\"0 0 1024 1024\" version=\"1.1\" xmlns=\"http://www.w3.org/2000/svg\" p-id=\"5386\"><path d=\"M884.875894 423.143253L646.970506 423.143253c92.185562-340.464205-63.516616-357.853247-63.516616-357.853247-65.993017 0-52.312436 52.18247599-57.3031 60.881602 0 166.502152-176.849824 296.971645-176.849824 296.971645l1e-8 472.171899c0 46.607504 63.516616 63.393819 88.43309799 63.393819l357.452111 0c33.641191 0 61.036122-88.224344 61.036122-88.224344 88.43412199-300.70569 88.434122-390.177444 88.43412199-390.177444C944.657442 418.179195 884.875894 423.143253 884.875894 423.143253L884.875894 423.143253 884.875894 423.143253zM884.875894 423.143253\" fill=\"#cccccc\" p-id=\"5387\"></path><path d=\"M251.671415 423.299819L109.214912 423.299819c-29.420053 0-29.873378 28.89612-29.873378 28.89612l29.420053 476.202703c0 30.30930601 30.36149501 30.309306 30.36149499 30.309306L262.42022301 958.707948c25.68600901 0 25.458835-20.049638 25.458835-20.049638L287.87905801 459.411271C287.879058 422.837284 251.671415 423.299819 251.671415 423.299819L251.671415 423.299819 251.671415 423.299819zM251.671415 423.299819\" fill=\"#cccccc\" p-id=\"5388\"></path></svg>" +
                "<span class='good'>"+this.likes+"</span></span></div>\n" +
                "<div class=\"content\">"+this.content+"</div>\n" +
                "<div class=\"time\">"+this.time+"</div>\n" +
                " </li>";
    }


}
