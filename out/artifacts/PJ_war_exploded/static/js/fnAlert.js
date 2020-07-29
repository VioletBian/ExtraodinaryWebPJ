function fnCreateAlert(msg,trueOrFalse,target){
    var className="";
    if(trueOrFalse){
        className="toast-success";
    }else{
        className="toast-warning";
    }
    var oDiv = $('<div></div>');
    oDiv.addClass('toast-top-right');
    oDiv.addClass('tip');
    oDiv.attr({
        id:'toast-top-right',
        'aria-live':'polite',
        role:'alert'
    });
    oDiv.html('<div class="toast '+className+'" style="display: block;border-radius: 5px;">'+
        '<div class="toast-title"><svg t="1595614833248" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="10832" width="30" height="30"><path d="M192.992 796c0 17.696 14.304 32 32 32H799.04c17.696 0 32-14.304 32-32v-232.992c0-176.224-142.816-319.008-319.008-319.008-176.192 0-319.008 142.816-319.008 319.008v232.992z m72-232.992a247.04 247.04 0 0 1 494.016 0v192.992H404v-171.008a10.016 10.016 0 0 0-10.016-9.984h-43.968a10.016 10.016 0 0 0-10.016 9.984v171.008H264.992v-192.992z m-48.096-252.48l39.616-39.616a8 8 0 0 0 0-11.296L188.608 191.68a8 8 0 0 0-11.296 0L137.696 231.296a8 8 0 0 0 0 11.296l67.904 67.904a8 8 0 0 0 11.296 0z m669.6-79.232l-39.584-39.584a8 8 0 0 0-11.328 0l-67.872 67.904a8 8 0 0 0 0 11.296l39.584 39.584a8 8 0 0 0 11.296 0l67.904-67.904a8 8 0 0 0 0-11.296zM832 892H192c-17.696 0-32 14.304-32 32v24c0 4.384 3.584 8 8 8h688a8 8 0 0 0 8-8v-24c0-17.696-14.304-32-32-32zM484 180h56a8 8 0 0 0 8-8v-96a8 8 0 0 0-8-8h-56a8 8 0 0 0-8 8v96c0 4.416 3.616 8 8 8z" p-id="10833" fill="#ffffff"></path></svg></div>'+
        '<div class="toast-message">'+msg+'</div>'+
        '</div>');
    oDiv.css('top','-80px');
    oDiv.animate({top:12},1000,function(){
        setTimeout(function(){
            oDiv.animate({opacity:0},800,function(){
                oDiv.remove();
            });
        },1000);
    });
    // $('body').append(oDiv)
    oDiv.insertBefore($(target));
}
