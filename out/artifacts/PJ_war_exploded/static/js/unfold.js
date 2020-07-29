function id$(x) {
    return document.getElementById(x);
}
id$('unfold').onclick = function(){
    if (document.getElementById('aside').style.display == 'none'){
        document.getElementById('aside').style.display = 'block';
        document.getElementById('unfold-logo').classList.remove('down');
        document.getElementById('unfold-logo').classList.add('up');

        
    }
    else {
        document.getElementById('aside').style.display = 'none';
        document.getElementById('unfold-logo').classList.remove('up');
        document.getElementById('unfold-logo').classList.add('down');
    }
    
    
}