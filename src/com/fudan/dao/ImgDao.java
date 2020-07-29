package com.fudan.dao;


import com.fudan.pojo.Img;

import java.util.List;

public interface ImgDao {
    public Img queryImgByID(String id);
    public List<Img> queryImgByFavor(String username);
    public List<Img> queryImgByUser(String username);
    public List<Img> queryImgByHot();
    public List<Img> queryImgByNew();
    public Img queryImgByDetail(String id);
    public boolean isFavored(String username, String id);
    public void favor(String username,String id);
    public void unfavor(String username,String id);
    public void delete(String username,String id);
    public void modify(String username,Img img);
    public void upload(String username, Img img);
    public List<Img> search(boolean titleOrTheme ,String input);


}


