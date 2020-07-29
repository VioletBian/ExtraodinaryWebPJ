
var ratio = document.getElementsByName("filter-way");
var inputs = document.getElementsByName('input');
var btn = document.getElementById('submit');
var lst = document.getElementById('list');

if (lst.childElementCount != 0) document.getElementById('placeholder').style = 'display:none';

btn.onclick = function(){

}
function ratioBound(i){
    ratio.item(i).onclick = function(){
        inputs.item(i).required = 'required';
        inputs.item(i).disabled = null;
        inputs.item(1-i).required = null;
        inputs.item((1-i)).disabled = 'disabled';
    }
}
