var myimg = document.getElementById('myimg');
var file = document.getElementById('file');
var footer = document.getElementById('footer');
var btnUpload = document.getElementById('btn-upload');
var btnModify = document.getElementById('btn-modify');

var formUl = document.getElementById('upload-info');
var form = document.forms["info"];
var txt =document.getElementsByClassName("txt");
var selects = document.getElementsByTagName("select");
var inputs = document.getElementsByClassName("upload");
var urlQuery =  getQueryString("ImageID");
if(urlQuery) {
    var path = myimg.src.match(/^.+[\/]static[\/]img[\/]normal[\/]medium[\/](.+)$/)[1];
    console.log(path);
    console.log(urlQuery);
}
file.onchange = function () {
    var url;
    var agent = navigator.userAgent;   //检测浏览器版本
    if (agent.indexOf("MSIE") >= 1) {
        url = file.value;
    } else if (agent.indexOf("Firefox") > 0) {
        url = window.URL.createObjectURL(file.files.item(0));
    } else if (agent.indexOf("Chrome") > 0) {
        url = window.URL.createObjectURL(file.files.item(0));
    }
    myimg.src = url
    myimg.style.display = "block";
    formUl.style.display = "block";
    footer.style.positon = "";
    footer.style.bottom = "";
    footer.style.marginTop = "5%";


 

}
window.onload = function () {
    var bodyHeight = $(document.body).height();//获取文档的的高度
    var windowHeight = $(window).height();     //获取窗口的的高度
    var windowWidth = $(window).width();

    var footer = document.getElementById('footer');

    //文档高度小于窗口高度时，给footer绝对定位。position:absolute;bottom:0;

    if(!myimg.style.display) {
        if (windowWidth > 460) {
            if (windowHeight > bodyHeight) {
                footer.style.position = "absolute";
                footer.style.bottom = "0"
                this.console.log('absolute positioned footer');
            } else {
                footer.style.positon = "";
                footer.style.bottom = "";
            }
        }
    }
}
// 给表单组件绑定聚焦失焦的判断是否填入提示
for(var i of inputs){
    i.isTxt = i.classList.contains("txt");
    i.addEventListener("blur",function(){
        if(this.isTxt){
            if (!this.value) {
                this.classList.add("emptyInput");
                // this.value = "You must enter " + this.name.toUpperCase() + "!";
            }
        }
        else {
            if (this.selectedIndex == 0 && this.options[0].innerText.split(" ")[0] == "Choose"){
                this.classList.add("emptyInput");
            }
        }
    })
    
    i.addEventListener("focus",function(){

        if (this.classList.contains("emptyInput")){
            this.classList.remove("emptyInput");
            if(this.isTxt)this.value = null;
        }
    });
}

function justifyInfo(){
    for (ele of inputs){
        if(ele.classList.contains("emptyInput")) {ele.empty = true;return false;}
        else if (ele.isTxt && !ele.value) {ele.empty = true;return false;}
        else if (!ele.isTxt && ele.selectedIndex == 0 && ele.options[0].innerText.split(" ")[0] == "Choose") {ele.empty = true;return false;}
        else ele.empty = false;
    }
    
    return true;
}

var xhr;

function createXMLHttpRequest() {
    if (window.ActiveXObject) {
        xhr = new ActiveXObject("Microsoft.XMLHTTP");
    } else if (window.XMLHttpRequest) {
        xhr = new XMLHttpRequest();
    }
}

function UpladFile(v) {
    var form = new FormData();
    if (v) {
        inputs['ImageID'].value = urlQuery;
        form.append("ImageID",inputs['ImageID'].value);
    }
    if(file.files[0]){
        var fileObj = file.files[0];
        form.append("file", fileObj);
        if(v)  {
            form.append('original',path+"");

        }
    }
    var title = inputs['title'].value;
    var description = inputs['description'].value;
    var country = inputs['country'].options[inputs['country'].selectedIndex].innerText;
    var city = inputs['city'].options[inputs['city'].selectedIndex].innerText;
    var theme = inputs['theme'].options[inputs['theme'].selectedIndex].innerText;
    var FileController = (v)? 'uploadServlet?type=modify':'uploadServlet?type=upload';
    form.append("title", title);
    form.append("description", description);
    form.append("country", country);
    form.append("city", city);
    form.append("theme", theme);
    createXMLHttpRequest();
    xhr.onreadystatechange = handleStateChange;
    xhr.open("post", FileController, true);
    xhr.send(form);
}

function handleStateChange() {
    if (xhr.readyState == 4) {
        if (xhr.status == 200 || xhr.status == 0) {
            var result = xhr.responseText;
            // var json = eval("(" + result + ")");
            // alert('图片链接:\n' + json.file);
            alert("Successfully done.\n"+result);

        }
    }
}
function selectByData(v,x){
    var ser = inputs[v];
    for(var i=0; i < ser.length; i++){
        if (ser[i].value == x)ser[i].selected = true;
    }
}
if(btnUpload) btnUpload.onclick = function(){

    if(justifyInfo()){
        UpladFile(false);

    }
    else {
        for (ele of inputs){
            if (ele.empty) ele.classList.add("emptyInput");
        }
    }

}


if(btnModify) btnModify.onclick = function() {

    if(justifyInfo()){
        UpladFile(true);
    }
    else {
        for (ele of inputs){
            if (ele.empty) ele.classList.add("emptyInput");
        }
    }

}
function getQueryString(name) {
    var reg = new RegExp('(^|&)' + name + '=([^&]*)(&|$)', 'i');
    var r = window.location.search.substr(1).match(reg);
    if (r != null) {
        return unescape(r[2]);
    }
    return null;
}
