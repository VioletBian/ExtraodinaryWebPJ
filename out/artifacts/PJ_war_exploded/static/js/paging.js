var pages = new Vue({
    el: "#pages",
    data:{
        "pageSize": $("#pageSize").val(),
        "totalCount": $("#totalCount").val(),
        "totalPage": $("#totalPage").val(),
        "currentPage": $("#currentPage").val(),
    }

    });

var current = document.getElementById('page1');
current.classList.add('highlight');
itemDisplay(1,1);

$(".page").click(function () {
    var targetPage = this.innerText;
    var currentPage = pages.currentPage;
    jumpPages(currentPage,targetPage);
});
$("#previous").click(function(){
    if(pages.currentPage != 1){
        jumpPages(pages.currentPage,pages.currentPage-1);
    }
});
$("#next").click(function(){
    if(pages.currentPage != pages.totalPage){
        jumpPages(pages.currentPage,pages.currentPage-(-1));
    }
});


function jumpPages(currentPage,targetPage){
    itemDisplay(currentPage,targetPage);
    document.getElementById('page' + targetPage).classList.add('highlight');
    document.getElementById('page' + currentPage).classList.remove('highlight');
    pages.currentPage = targetPage;
}


function itemDisplay(currentPage, targetPage) {
    for (let i = pageIndexRange(currentPage)[0]; i <= pageIndexRange(currentPage)[1]; i++) {
        document.getElementsByClassName("item").item(i).style.display = "none";
    }
    for (let i = pageIndexRange(targetPage)[0]; i <= pageIndexRange(targetPage)[1]; i++) {
        document.getElementsByClassName("item").item(i).style.display = "block";
    }
}

function pageIndexRange(currentPage,totalPage = pages.totalPage, totalCount = pages.totalCount, pageSize = pages.pageSize) {
    if (totalPage == 1) return [0, totalCount - 1];
    if (currentPage != totalPage) return [pageSize * currentPage - pageSize, pageSize * currentPage - 1];
    else return [pageSize * totalPage - pageSize, totalCount - 1];
}


