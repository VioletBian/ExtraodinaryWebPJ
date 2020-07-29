
var arr_country = ["Choose a country", "Italy", "United States", "United Kingdom","Germany","China", "Greece"];
var arr_city = [
    ["Choose a city"],
    ['Roma', 'Venezia', 'Verona', 'Firenze'],
    ['New York City', 'San Francisco', 'Washington','California'],
    ['London', 'Oxford', 'Glasgow', 'Manchester'],
    ['Berlin','Darmstadt','Koeln','Frankfurt am Main'],
    ['Shanghai', 'Jiangsu', 'Beijing', 'Guangzhou','Hangzhou','Wuhan'],
    ['Athens', 'Fira', 'Cape Coast']
];
function id$(x) {
    return document.getElementById(x);
}
function class$(y){
    return document.getElementsByClassName(y);
}


//遍历的添加国家数据
for (var i = 0; i < arr_country.length; i++) {
    var op = document.createElement("option");
    if (i!=0)op.value = arr_country[i];
    else op.value = "";
    op.innerText = arr_country[i];
    id$("country").appendChild(op);
}
//设置默认值
var on = document.createElement("option");
on.innerText = arr_city[0];
id$("city").appendChild(on);

id$("country").onchange = function (){
    console.log("selectedIndex= " + this.selectedIndex);
    //selectedIndex表示选中的索引值
    var index = this.selectedIndex;

    //添加前先删除sp
    id$("city").innerHTML = "";
    //遍历的添加城市数据
    for (var i = 0; i < arr_city[index].length; i++) {
        var sp = document.createElement("option");
        sp.value = arr_city[index][i];
        sp.innerText = arr_city[index][i];
        id$("city").appendChild(sp);
    }
    if(id$("city").classList.contains("emptyInput"))id$("city").classList.remove("emptyInput");
}


// function hotCountrySelector(){
//     for (var i = 0; i < arr_country.length; i++){
//         if (arr_country[i] == this.innerText){
//             var options = id$("country").children;
//             options[i].selected=true;
//             break;
//         }
//     }


function sendSingle(type,value){
    $themeForm = document.getElementById(type+"Form");
    $themeForm.elements.item(type).value = value;
    $themeForm.submit();

}
