// <=== 页面回显部分 ===>

personalCenter = {
    // <=== 个人中心页 ↓ ===>

    // 个人信息部分
    selUser(id){
        $.ajax({
            url: '/BorrowCard?method=selUser',
            data:{'id': id},
            type: 'post',
            dataType: 'json',
            success: function (obj){
                $('#name').text(obj.name)
                $('#borrowCard').text(obj.borrowCardNum)
                $('#unitName').text(obj.unitName)
                $('#roleName').text(obj.roleName)
                $('#credit').text(obj.creditScore)
                $('#creatTime').text(obj.createTime)
            }
        })
    },

    // 借书数量部分
    borrowBookNum(id){
        $.ajax({
            url: '/BorrowBook?method=borrowBookNum',
            data:{'id': id},
            type: 'post',
            dataType: 'json',
            success: function (obj){
                if (obj != 0){
                    $('#bookNum').text(obj)
                }
            }
        })
    },

    // 借阅记录部分
    LoanRecord(id){
        $.ajax({
            url: '/BorrowBook?method=selBook',
            data:{'id': id},
            type: 'post',
            dataType: 'json',
            success: function (obj){
                $(obj).each(function (){
                    var bookName = $('<span>').text(this.name);
                    var author = $('<span>').text(this.author);
                    var bookNameP = $('<a>',{href : '#'}).text('书名: ').append(bookName);
                    var authorP = $('<p>').text('作者: ').append(author);
                    var div = $('<div>', { class: 'self-borrowMsg-div' }).append(bookNameP, authorP);
                    $('.self-borrowMsg').append(div);
                })
            }
        })
    }
}

bookRack = {
    // 加载书架
    myBookRacks(id){
        $.ajax({
            url: '/Book?method=borrowBook',
            type: 'post',
            dataType: 'json',
            data: {id: id},
            success: function (obj) {
                console.log(obj);
                if (obj.length != 0) {
                    $(obj).each(function () {
                        if (this.status == 3) {
                            var link = $('<a>').attr('href', '/page/particularBook?isbn='+this.isbn+'&type=1').append(img)
                            var img = $('<img>', {src: /lic/ + this.image});
                            var divImg = $('<div>', {class: 'book-cover'}).append(link);
                            var input = $('<input>', {type: 'hidden'}).val(this.isbn);
                            var p = $('<p>', {class: 'book-show'}).text(this.name);
                            var pTime = $('<p>', {class: 'book-time'}).text('还书时间: ' + this.endTime).css('color', 'red');
                            var button1 = $('<button>', {
                                class: 'book-btn',
                                onclick: 'returnBook(' + this.isbn + ')'
                            }).text('我要还书');
                            var div = $('<div>', {class: 'book'}).append(input, divImg, p, pTime, button1);
                            $('#bookPackage').append(div)
                        } else {
                            var input = $('<input>', {type: 'hidden'}).val(this.isbn);
                            var img = $('<img>', {src: /lic/ + this.image});
                            var link = $('<a>').attr('href', '/page/particularBook?isbn='+this.isbn+'&type=1').append(img)
                            var divImg = $('<div>', {class: 'book-cover'}).append(link);
                            var p = $('<p>', {class: 'book-show'}).text(this.name);
                            var pTime = $('<p>', {class: 'book-time'}).text('还书时间: ' + this.endTime);
                            var button1 = $('<button>', {
                                class: 'book-btn',
                                onclick: 'returnBook(' + this.isbn + ')'
                            }).text('我要还书');
                            var button2 = $('<button>', {
                                class: 'book-btn',
                                onclick: 'openPopup(' + this.isbn + ')'
                            }).text('我要续期').css('background-color', '#178177');
                            var div = $('<div>', {class: 'book'}).append(input, divImg, p, pTime, button1, button2);
                            $('#bookPackage').append(div)
                        }
                    })
                } else {
                    $('#bookPackage').css('display', 'none')
                    var link = $('<a>').text('选书').attr('href', '/page/stackBook').css('color','#00ffcc');
                    var text = $('<h1>').text('还没有借阅书籍哦，快去 ').append(link).append(' 吧！').css({
                        'font-family':'上首赛博体',
                        'font-size':'50px',
                        'color':'#00ffcc'
                    });
                    var blankDiv = $('<div>', { class: 'book-blank' }).append(text).css({
                        'display':'flex',
                        'justify-content': 'center',
                        'align-items':'center'
                    });
                    $('#bookList').append(blankDiv).css('margin-top','60px')
                }
            }
        })
    },

    // 还书
    backBooks(url, bid, uid) {
        $.ajax({
            url: url,
            type: 'post',
            data: {bid: bid, uid: uid},
            dataType: 'json',
            success: function (obj){
                if (obj){
                    myLayui.message('记录完成', 1)
                    location.reload()
                }else {
                    myLayui.message('记录失败', 2)
                    location.reload()
                }
            }
        })
    }
}
