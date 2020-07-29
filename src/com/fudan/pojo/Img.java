package com.fudan.pojo;

import java.util.Comparator;
import java.util.Date;

public class Img implements Comparator {
    private String path;
    private String title;
    private String description;
    private String username;
    private String asciiName;
    private String countryName;
    private String content;
    private int ImageID;
    private Date time;
    private int popularity;
    private String CountryCodeISO;
    private String CityCode;

    public String getCountryCodeISO() {
        return CountryCodeISO;
    }

    public void setCountryCodeISO(String countryCodeISO) {
        CountryCodeISO = countryCodeISO;
    }

    public String getCityCode() {
        return CityCode;
    }

    public void setCityCode(String cityCode) {
        CityCode = cityCode;
    }



    public int getPopularity() {
        return popularity;
    }

    public void setPopularity(int popularity) {
        this.popularity = popularity;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }


    public Img() {
    }

    public Img(int ImageID, String path, String title, String description, String username, String asciiName, String countryName, String content) {
        this.ImageID = ImageID;
        this.path = path;
        this.title = title;
        this.description = description;
        this.username = username;
        this.asciiName = asciiName;
        this.countryName = countryName;
        this.content = content;
    }

    public int getImageID() {
        return ImageID;
    }

    public void setImageID(int imageID) {
        ImageID = imageID;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        if (description == null) description = "";
        this.description = description;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getAsciiName() {
        return asciiName;
    }

    public void setAsciiName(String asciiName) {
        this.asciiName = asciiName;
    }

    public String getCountryName() {
        return countryName;
    }

    public void setCountryName(String countryName) {
        this.countryName = countryName;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content.toLowerCase();
    }

    public String getFavorImg() {
        String query = "?ImageID=" + this.ImageID;
        String btns = "<span class='btns'><button id=\"undo-favor\"><a href=\"unfavorServlet?ImageID=" + this.ImageID + "\"><svg t=\"1585331001715\" class=\"icon\" viewBox=\"0 0 1024 1024\" version=\"1.1\" xmlns=\"http://www.w3.org/2000/svg\" p-id=\"3378\" width=\"20px\" height=\"20px\"><path d=\"M887.7 380.2L693 331.4c-3.6-0.9-6.7-3.2-8.7-6.3l-106.5-170c-4.6-7.3-10.8-13.5-18.1-18.1-26.8-16.8-62.2-8.7-79 18.1L374 325.2c-2 3.1-5.1 5.4-8.7 6.3l-194.7 48.8c-8.4 2.1-16.2 6.1-22.9 11.7-24.3 20.3-27.5 56.5-7.2 80.8l33.6 40.2 42.6 3.8c201.6 18 379.4 143.6 464 327.9l18.9 41.1 21 8.4c8 3.2 16.7 4.6 25.4 4 31.6-2.2 55.4-29.5 53.3-61.1l-13.8-200.2c-0.3-3.7 0.9-7.3 3.3-10.2l128.8-153.9c5.6-6.6 9.5-14.5 11.7-22.9 7.7-30.9-10.9-62-41.6-69.7z\" p-id=\"3379\" fill=\"#ffffff\"></path><path d=\"M213.1 559.2l56.4 67.4c2.4 2.8 3.6 6.5 3.3 10.2L259 836.9c-0.6 8.6 0.8 17.3 4 25.4 9 22.3 30.5 35.9 53.2 35.9 7.1 0 14.4-1.3 21.4-4.2l186.2-75c1.7-0.7 3.5-1 5.4-1 1.8 0 3.6 0.3 5.4 1l107.5 43.3c-76.6-166.6-238-286.1-429-303.1z\" p-id=\"3380\" fill=\"#ffffff\"></path></svg></a></button></span>";
        String details = "<div class=\"detail\"><span class=\"title\">" + this.title + "</span><div class=\"description\">" + this.description + "</div>" + btns + "</div>";
        String imgs = "<a href=\"pages/detail.jsp?ImageID=" + this.ImageID + "\"><img src=\"static/img/normal/medium/" + this.path + "\"></a>";
        return "<li class='item' style='display:none'>" + imgs + "</a>" + details + "</li>";

    }

    public String getMyImg() {
        String query = "?ImageID=" + this.ImageID;
        String btns = "<span class='btns'><button id=\"modify\"><a href=\"pages/upload.jsp?ImageID=" + this.ImageID + "\"><svg t=\"1585329550188\" class=\"icon\" viewBox=\"0 0 1024 1024\" version=\"1.1\" xmlns=\"http://www.w3.org/2000/svg\" p-id=\"2931\" width=\"20px\" height=\"20px\"><path d=\"M679.51874187 662.40298719H344.48989156c-18.50297531 0-33.50240531-14.99943-33.50240531-33.50240625v-50.25456657h402.03462094v50.25456657c0 18.50297531-15.00039 33.50240531-33.50336532 33.50240625z\" fill=\"#00D8A0\" p-id=\"2932\"></path><path d=\"M813.52548594 930.78966031H210.473555c-36.95414531 0-67.00576969-30.36149531-67.00577062-67.69266375V160.89437c0-37.322535 30.05162531-67.68498938 67.00577062-67.68499031h402.03462c18.50201531 0 33.50240531 15.00134906 33.50240625 33.50240531s-15.00134906 33.50240531-33.50240625 33.50240531h-402.03462V863.09699656l603.05193094 0.68689407V366.00138688c0-18.50201531 15.00134906-33.50240531 33.50336437-33.50240532s33.50240531 15.00134906 33.50240532 33.50240531V863.09699656c0 37.33116937-30.05066531 67.69266469-67.00576969 67.69266375z\" fill=\"#ffffff\" p-id=\"2933\"></path><path d=\"M495.24879688 503.26800031a33.43333219 33.43333219 0 0 1-24.27634032-10.41277969c-12.74304-13.40595094-12.22019438-34.61525063 1.19439-47.36692593L815.40677 118.99957438c13.39827563-12.73536563 34.59894188-12.20388562 47.35925063 1.18575562 12.744 13.40595094 12.22019438 34.61525063-1.19439 47.36692594L518.33074813 494.04193531c-6.47848781 6.16765875-14.78837344 9.226065-23.08195125 9.226065z\" fill=\"#ffffff\" p-id=\"2934\"></path></svg></a></button><button id=\"delete\" ><a href=\"deleteServlet?ImageID="+this.ImageID+"\"><svg t=\"1585329594694\" class=\"icon\" viewBox=\"0 0 1024 1024\" version=\"1.1\" xmlns=\"http://www.w3.org/2000/svg\" p-id=\"3069\" width=\"20px\" height=\"20px\"><path d=\"M735.351927 958.708971H288.647049c-37.516452 0-68.119447-30.234605-68.706824-67.633376L185.611371 273.366018c-1.057075-18.942421 13.456477-35.158754 32.398898-36.21583 19.395746-1.006933 35.166941 13.456477 36.224016 32.407084l34.361599 618.498546c0.033769 0.63752 0.050142 1.27504 0.050142 1.912559l446.704878 0.016373c0-0.63752 0.016373-1.292436 0.050142-1.929955l34.361599-618.498546c1.057075-18.959817 17.533328-33.229822 36.224016-32.407084 18.942421 1.057075 33.455973 17.273409 32.398898 36.21583L804.056706 891.074571c-0.584308 37.399795-31.188326 67.6344-68.704779 67.6344z\" fill=\"#ffffff\" p-id=\"3070\"></path><path d=\"M889.980657 271.461645H134.01832c-18.97619 0-34.361599-15.385409-34.361599-34.361599s15.385409-34.361599 34.361599-34.361599h755.962337c18.97619 0 34.361599 15.385409 34.361599 34.361599s-15.384385 34.361599-34.361599 34.361599z\" fill=\"#ffffff\" p-id=\"3071\"></path><path d=\"M683.814134 735.350904H340.195076v51.54291c0 18.977213 15.384385 34.361599 34.361599 34.361599h274.89586c18.977213 0 34.361599-15.384385 34.361599-34.361599V735.350904z\" fill=\"#00D8A0\" p-id=\"3072\"></path><path d=\"M676.930353 271.461645c-18.97619 0-34.361599-15.385409-34.361599-34.361599v-68.724221c0-18.950607-15.419178-34.361599-34.361598-34.361599H415.776472c-18.942421 0-34.361599 15.410991-34.361599 34.361599v68.724221c0 18.97619-15.385409 34.361599-34.361599 34.361599s-34.361599-15.385409-34.361599-34.361599v-68.724221c0-56.844659 46.24116-103.08582 103.08582-103.08582H608.206132c56.844659 0 103.08582 46.24116 103.08582 103.08582v68.724221c0 18.97619-15.385409 34.361599-34.361599 34.361599z\" fill=\"#ffffff\" p-id=\"3073\"></path></svg></a></button></span>";
        String details = "<div class=\"detail\"><span class=\"title\">" + this.title + "</span><div class=\"description\">" + this.description + "</div>" + btns + "</div>";
        String imgs = "<a href=\"pages/detail.jsp?ImageID=" + this.ImageID + "\"><img src=\"static/img/normal/medium/" + this.path + "\"></a>";
        return "<li class='item' style='display:none'>" + imgs + "</a>" + details + "</li>";

    }

    public String getSlide() {
        String block = "<div class=\"item\"><a href=\"pages/detail.jsp?ImageID=" + this.ImageID + "\"><img src=\"static/img/normal/medium/" + this.path + "\" alt=\"...\"><div class=\"carousel-caption\"></div></div>";
        return block;
    }

    public String getNew() {
        String li = "<a href='pages/detail.jsp?ImageID=" + this.ImageID + "'><li class='hot1' id='" + this.ImageID + "'><div class= 'description'><h2>" + this.title + "</h2><p>Theme:" + this.content + "<br>Author:" + this.username + "<br>Post on:" + this.time + "</p></div></li></a>";
        String scr = "<script>document.getElementById(\"" + this.ImageID + "\").style = 'background-image: url(\"static/img/normal/medium/" + this.path + "\");';</script>";
        return li + scr;
    }

    public String getSearch(){
        String img = "<img src='static/img/normal/medium/"+this.getPath()+"'>";
        String ahref= "<a href='pages/detail.jsp?ImageID="+this.getImageID()+"'>";
        return "<li class='item' style='display:none'><table><tr><td rowspan=\"2\" class=\"result-img\">"+ahref+img+"</a></td><th>"+this.getTitle()+"</th></tr><tr><td class='description'>"+this.getDescription()+"</td></tr></table></li>";

    }




    @Override
    public int compare(Object o1, Object o2) {

        return 0;
    }
}

