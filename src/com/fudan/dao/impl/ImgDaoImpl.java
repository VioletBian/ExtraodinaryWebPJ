package com.fudan.dao.impl;

import com.fudan.dao.ImgDao;
import com.fudan.pojo.Comment;
import com.fudan.pojo.Img;
import com.sun.tools.corba.se.idl.toJavaPortable.StringGen;

import java.util.ArrayList;
import java.util.List;

public class ImgDaoImpl extends BaseDao implements ImgDao {
    @Override
    public Img queryImgByID(String id) {
        String sql = "select a.Title, a.Description, a.PATH, a.Content, a.Time, b.CountryName, c.AsciiName, a.CityCode, a.CountryCodeISO from travelimage as a, geocountries as b, geocities as c where a." + id + " and b.ISO = a.CountryCodeISO and c.GeoNameID = a.CityCode";
        Img img = queryForOne(Img.class, sql);
        return img;

    }

    @Override
    public List<Img> queryImgByFavor(String username) {
        String sql = "select a.ImageID, a.Title, a.Description, a.PATH from travelimage as a, traveluser as b, travelimagefavor as c where c.UID = b.UID and c.ImageID = a.ImageID and b.UserName ='" + username + "'";
        List<Img> Imgs = queryForList(Img.class, sql);
        return Imgs;
    }

    @Override
    public List<Img> queryImgByUser(String username) {
        String sql = "select a.ImageID, a.Title, a.Description, a.PATH from travelimage as a, traveluser as b where a.UID = b.UID and b.UserName ='" + username + "'";
        List<Img> Imgs = queryForList(Img.class, sql);
        return Imgs;
    }

    @Override
    public List<Img> queryImgByHot() {
        String sql = "SELECT F.ImageID, COUNT(F.ImageID), I.PATH, I.Title, I.Description FROM travelimagefavor AS F, travelimage AS I WHERE F.ImageID = I.ImageID GROUP BY F.ImageID ORDER BY COUNT(F.ImageID) DESC limit 5";
        List<Img> Imgs = queryForList(Img.class, sql);
        return Imgs;
    }

    @Override
    public List<Img> queryImgByNew() {
        String sql = "SELECT I.ImageID, I.PATH, I.Title, I.Time, F.UserName, I.Content FROM traveluser AS F, travelimage AS I WHERE F.UID = I.UID ORDER BY I.ImageID DESC limit 6";
        List<Img> Imgs = queryForList(Img.class, sql);
        return Imgs;
    }

    @Override
    public Img queryImgByDetail(String id) {
        String stars = "select COUNT(travelimagefavor.ImageID) as popularity from travelimagefavor where " + id;
        String cityJudge = "select IFNULL(a.CityCode,'Unknown') as Citi from travelimage as a where a." + id;
        String sql = "select a.ImageID, a.Title, a.Description, a.PATH, a.Content, b.UserName, d.AsciiName, e.CountryName, star.popularity, a.Time from travelimage as a, traveluser as b, (" + stars + ") as star, geocities as d, geocountries as e,(" + cityJudge + ") as f where a.CountryCodeISO = e.ISO and d.GeoNameID = f.Citi and b.UID = a.UID  and a." + id;
        Img img = queryForOne(Img.class, sql);
        return img;
    }

    @Override
    public boolean isFavored(String username, String id) {
        String sql = "select a.FavorID from travelimagefavor as a, traveluser as b where a.UID=b.UID and b.UserName ='" + username + "' and a." + id;
        Img img = queryForOne(Img.class, sql);
        if (img != null) return true;
        else return false;

    }

    @Override
    public void favor(String username, String id) {

        int ID = Integer.parseInt(id.replace("ImageID=", ""));
        String sql = "INSERT INTO `travelimagefavor` (`ImageID`, `UID`) VALUES (" + ID + ",(SELECT UID from traveluser where UserName = '" + username + "'))";
        update(sql);


    }

    @Override
    public void unfavor(String username, String id) {
        String sql = "delete from travelimagefavor where " + id + " and UID = (SELECT UID from traveluser where UserName = '" + username + "')";
        update(sql);

    }

    @Override
    public void delete(String username, String id) {
        String sql = "delete from travelimage where " + id;
        update(sql);
    }

    @Override
    public void modify(String username, Img img) {
        String country = "(SELECT ISO from geocountries where CountryName = '" + img.getCountryName() + "')";
        String city = "(SELECT a.GeoNameID from geocities as a, " + country + " as b where a.AsciiName = \"" + img.getAsciiName() + "\" and a.CountryCodeISO = b.ISO )";
        String file = (img.getPath() != null) ? ", PATH = '" + img.getPath() + "'" : "";
        String sql = "update travelimage set Title = '" + img.getTitle() + "', Description = '" + img.getDescription() + "', CountryCodeISO = " + country + ", CityCode = " + city + ", Content = '" + img.getContent() + "', Time = CURRENT_TIME" + file + " where ImageID= " + img.getImageID() + "";
        update(sql);


    }

    @Override
    public void upload(String username, Img img) {
        String UID = "(SELECT UID from traveluser where UserName = '" + username + "')";
        String country = "(SELECT ISO from geocountries where CountryName = '" + img.getCountryName() + "')";
        String city = "(SELECT a.GeoNameID from geocities as a, " + country + " as b where a.AsciiName = \"" + img.getAsciiName() + "\" and a.CountryCodeISO = b.ISO )";
        String sql = "  insert into  `travelimage` (`Title`, `Description`, `PATH`,`Content`,`UID`,`CountryCodeISO`,`CityCode`) values ('" + img.getTitle() + "','" + img.getDescription() + "','" + img.getPath() + "','" + img.getContent() + "'," +
                UID + ", " + country + ", " + city + ")";
        update(sql);

    }

    @Override
    public List<Img> search(boolean titleOrTheme, String input) {
        String type = (titleOrTheme) ? "Title" : "Content";
        String sql1 = "";
        String sql2 = "";
        input = input.trim();
        List<Img> results = new ArrayList<>();
        String[] inputs = input.split(" ");
        if (inputs.length == 1) {
            sql1 = "select ImageID from travelimage as a where a." + type + " like '%" + input + "%'";
            sql2 = "select ImageID from travelimage as a where SUBSTRING(SOUNDEX(a." + type + "),1,4) LIKE SUBSTRING(SOUNDEX('" + input + "'),1,4)";
            List<Img> imgs1 = queryForList(Img.class, sql1);
            List<Img> imgs2 = queryForList(Img.class, sql2);
            noRepeatAdd(results,imgs1);
            noRepeatAdd(results,imgs2);
        }
        else {
            sql1 = "select ImageID from travelimage as a where a." + type + " like '%" + inputs[0] + "%'";
            for (int i = 1; i < inputs.length; i++) {
                sql1 += " and a." + type + " like '%" + inputs[i] + "%'";
            }
            System.out.println(sql1);
            List<Img> imgs1 = queryForList(Img.class, sql1);
            noRepeatAdd(results,imgs1);
        }

        return results;

    }

    private void noRepeatAdd(List<Img> results,List<Img> imgs){
    for (Img im : imgs) {
        Boolean isIn = false;
        stop:for (Img rm : results) {
            if (rm.getImageID() == im.getImageID()) {
                isIn = true;
                break stop;
            }
        }
        if(!isIn)results.add(queryImgByDetail("ImageID=" + im.getImageID()));
    }
}

    @Override
    public List<Comment> getComments(String id) {
        String sql = "select id, ImageID, UserName, content, Likes, Time from comments where " + id;
        return queryForList(Comment.class,sql);
    }
    @Override
    public Comment getComment(int cid) {
        String sql = "select id, ImageID, UserName, content, Likes, Time from comments where id=" + cid;
        return queryForOne(Comment.class,sql);
    }

    @Override
    public void likeComment(int cid) {

        Comment cmt = getComment(cid);
        int likes = cmt.getLikes() + 1;
        String sql = "update comments set Likes = ? where id= ?";
        update(sql,likes,cid);

    }
}
