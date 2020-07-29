
function id$(x) {
    return document.getElementById(x);
}
var nav = document.getElementById('nav');
if (id$('light-skin') != null){
id$('light-skin').onclick = function(){
    nav.classList.remove('sky','light','dark');
    nav.classList.add('light');
    
}
}
if (id$('dark-skin') != null){
id$('dark-skin').onclick = function(){
    nav.classList.remove('sky','light','dark');
    nav.classList.add('dark');
    
}
}
if (id$('sky-skin') != null){
id$('sky-skin').onclick = function(){
    nav.classList.remove('sky','light','dark');
    nav.classList.add('sky');
    
}
}