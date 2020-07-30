package com.fudan.dao.impl;

import com.fudan.dao.ImgDao;
import com.fudan.pojo.Img;
import com.sun.tools.corba.se.idl.toJavaPortable.StringGen;

import java.util.ArrayList;
import java.util.List;

public class ImgDaoImpl extends BaseDao implements ImgDao {
    @Override
    public Img queryImgByID(String id) {
        String sql = "select a.Title, a.Description, a.PATH, a.Content, a.Time, b.CountryName, c.AsciiName, a.CityCode, a.CountryCodeISO from travelimage as a, geocountries as b, geocities as c where a."+id+" and b.ISO = a.CountryCodeISO and c.GeoNameID = a.CityCode";
        Img img = queryForOne(Img.class,sql);
        return img;

    }

    @Override
    public List<Img> queryImgByFavor(String username) {
        String sql = "select a.ImageID, a.Title, a.Description, a.PATH from travelimage as a, traveluser as b, travelimagefavor as c where c.UID = b.UID and c.ImageID = a.ImageID and b.UserName ='" + username + "'";
        List<Img> Imgs = queryForList(Img.class,sql);
        return Imgs;
    }

    @Override
    public List<Img> queryImgByUser(String username) {
        String sql = "select a.ImageID, a.Title, a.Description, a.PATH from travelimage as a, traveluser as b where a.UID = b.UID and b.UserName ='"+username+"'";
        List<Img> Imgs = queryForList(Img.class,sql);
        return Imgs;
    }

    @Override
    public List<Img> queryImgByHot() {
        String sql = "SELECT F.ImageID, COUNT(F.ImageID), I.PATH, I.Title, I.Description FROM travelimagefavor AS F, travelimage AS I WHERE F.ImageID = I.ImageID GROUP BY F.ImageID ORDER BY COUNT(F.ImageID) DESC limit 5";
        List<Img> Imgs = queryForList(Img.class,sql);
        return Imgs;
    }

    @Override
    public List<Img> queryImgByNew() {
        String sql = "SELECT I.ImageID, I.PATH, I.Title, I.Time, F.UserName, I.Content FROM traveluser AS F, travelimage AS I WHERE F.UID = I.UID ORDER BY I.ImageID DESC limit 6";
        List<Img> Imgs = queryForList(Img.class,sql);
        return Imgs;
    }

    @Override
    public Img queryImgByDetail(String id) {
        String stars = "select COUNT(travelimagefavor.ImageID) as popularity from travelimagefavor where "+ id;
        String cityJudge = "select IFNULL(a.CityCode,'Unknown') as Citi from travelimage as a where a."+ id;
        String sql = "select a.ImageID, a.Title, a.Description, a.PATH, a.Content, b.UserName, d.AsciiName, e.CountryName, star.popularity, a.Time from travelimage as a, traveluser as b, ("+stars+") as star, geocities as d, geocountries as e,("+cityJudge+") as f where a.CountryCodeISO = e.ISO and d.GeoNameID = f.Citi and b.UID = a.UID  and a."+ id;
        Img img = queryForOne(Img.class,sql);
        return img;
    }

    @Override
    public boolean isFavored(String username, String id) {
        String sql = "select a.FavorID from travelimagefavor as a, traveluser as b where a.UID=b.UID and b.UserName ='"+username+"' and a."+id;
        Img img = queryForOne(Img.class,sql);
        if (img != null) return true;
        else return false;

    }

    @Override
    public void favor(String username, String id){

        int ID = Integer.parseInt(id.replace("ImageID=",""));
        String sql = "INSERT INTO `travelimagefavor` (`ImageID`, `UID`) VALUES ("+ID+",(SELECT UID from traveluser where UserName = '"+username+"'))";
        update(sql);


    }

    @Override
    public void unfavor(String username, String id) {
        String sql = "delete from travelimagefavor where "+id+" and UID = (SELECT UID from traveluser where UserName = '"+username+"')";
        update(sql);

    }

    @Override
    public void delete(String username, String id) {
        String sql = "delete from travelimage where "+ id;
        update(sql);
    }

    @Override
    public void modify(String username,Img img) {
        String country = "(SELECT ISO from geocountries where CountryName = '"+img.getCountryName()+"')";
        String city = "(SELECT a.GeoNameID from geocities as a, "+country+" as b where a.AsciiName = \""+ img.getAsciiName()+"\" and a.CountryCodeISO = b.ISO )";
        String file = (img.getPath() != null)?", PATH = '"+img.getPath()+"'" : "";
        String sql = "update travelimage set Title = '"+img.getTitle()+"', Description = '"+img.getDescription()+"', CountryCodeISO = "+country+", CityCode = "+city+", Content = '"+img.getContent()+"', Time = CURRENT_TIME"+file+" where ImageID= "+img.getImageID()+"";
        update(sql);



    }

    @Override
    public void upload(String username, Img img) {
        String UID = "(SELECT UID from traveluser where UserName = '"+username+"')";
        String country = "(SELECT ISO from geocountries where CountryName = '"+img.getCountryName()+"')";
        String city = "(SELECT a.GeoNameID from geocities as a, "+country+" as b where a.AsciiName = \""+ img.getAsciiName() + "\" and a.CountryCodeISO = b.ISO )";
        String sql = "  insert into  `travelimage` (`Title`, `Description`, `PATH`,`Content`,`UID`,`CountryCodeISO`,`CityCode`) values ('"+img.getTitle()+"','"+img.getDescription()+"','"+img.getPath()+"','"+img.getContent()+"'," +
                UID+", "+country+", "+city+")";
        update(sql);

    }

    @Override
    public List<Img> search(boolean titleOrTheme, String input) {
//        String stars = "select COUNT(f.ImageID) as popularity from travelimagefavor as f, travelimage as a where f.ImageID = a.ImageID";
//        String cityJudge = "select IFNULL(a.CityCode,'Unknown') as Citi from travelimage as a";
        String type = (titleOrTheme)? "Title":"Content";
        String id = "select ImageID from travelimage as a where a."+type+" like '%"+input+"%'";
//        String sql = "select a.ImageID, a.Title, a.Description, a.PATH, a.Content, b.UserName, d.AsciiName, e.CountryName, star.popularity, a.Time from travelimage as a, traveluser as b, ("+stars+") as star, geocities as d, geocountries as e,("+cityJudge+") as f where a.CountryCodeISO = e.ISO and d.GeoNameID = f.Citi and b.UID = a.UID  and a."+type+" LIKE '%"+input+"%'  GROUP by a.ImageID";
        List<Img> imgs = queryForList(Img.class,id);
        List<Img> results = new ArrayList<>();
        for(Img im : imgs){
            results.add(queryImgByDetail("ImageID="+im.getImageID()));

        }

        return results;

    }
}
//    select x.ImageID, a.Title, a.Description, a.PATH, a.Content, b.UserName, d.AsciiName, e.CountryName, star.popularity, a.Time from travelimage as a, traveluser as b, (select ImageID from travelimage as a where a.Title like '%a%') as x, (select COUNT(f.ImageID) as popularity from travelimagefavor as f, travelimage as a where f.ImageID = x.ImageID) as star, geocities as d, geocountries as e,(select IFNULL(a.CityCode,'Unknown') as Citi from travelimage as a where a.ImageID = x.ImageID) as f where a.CountryCodeISO = e.ISO and d.GeoNameID = f.Citi and b.UID = a.UID  and a.Title LIKE '%a%' and a.ImageID=x.ImageID GROUP by x.ImageID