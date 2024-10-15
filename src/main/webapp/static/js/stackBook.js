var stackJs = {
    // 书籍标签(分类)
    selClassify(){
        $.ajax({
            url: '/BookClassify?method=selAll',
            dataType: 'json',
            type: 'get',
            success: function (obj) {
                $(obj).each(function () {
                    var p = $('<p>').text(this.name);
                    var li = $('<li>', {id: this.id}).append(p);
                    $('#book-classify').append(li)
                })
            }
        })
    },

    // 加载分页内容
    books(page, name, typeId){
        $.ajax({
            url: '/Book?method=selPage',
            type: 'post',
            dataType: 'json',
            data: {
                page: page,
                limit: 10,
                name: name,
                typeUnit: typeId,
            },
            success: function (obj) {
                $('#countPage').val(obj.count)
                $('#book-list').empty();
                $(obj.data).each(function (){
                    // 分页内容加载
                    var img = $('<img>').attr('src','/lic/'+this.image);
                    var link = $('<a>').attr('href', '/page/particularBook?isbn='+this.isbn+'&type=2').append(img);
                    var imgDiv = $('<div>', {class:'item-img-div'}).append(link);

                    var name = $('<p>').text(this.name);
                    var synopsis = $('<p>').text(this.synopsis);
                    var i = $('<i>', {class: 'layui-icon layui-icon-user'}).css('margin-right','3px');
                    var tittle = $('<p>').append(i).append(this.author + ' | ' + this.bookTypeName);
                    var txtDiv = $('<div>', {class:'item-content-div'}).append(name, tittle, synopsis);

                    var div = $('<div>', {class: 'book-item'}).append(imgDiv, txtDiv);
                    $('#book-list').append(div)
                })
            }
        })
    },

}