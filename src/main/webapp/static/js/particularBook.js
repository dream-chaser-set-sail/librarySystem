details = {
    // 加载书籍详情
    loadParticularBook(isbn, uid){
        $.ajax({
            url: '/Book?method=selBookByisbn',
            data: {isbn: isbn, id: uid},
            type: 'get',
            dataType: 'json',
            success: function (obj) {
                console.log(obj);
                $('#bookName').text(obj.name)
                $('#author').text(obj.author)
                $('#onclickNum').text(obj.onclickNum)
                $('#image').attr('src','/lic/'+obj.image)
                if (obj.status == 1){
                    $('#borrow').css('display', 'block')
                    $('#back').css('display', 'none')
                } else {
                    $('#borrow').css('display', 'none')
                    $('#back').css('display', 'block')
                }
                $('#synopsis').text(obj.synopsis)
                $('#name').text(obj.name)
                $('#isbn').text(obj.isbn)
                $('#publishingHouse').text(obj.publishingHouse)
                $('#createTime').text(obj.createTime)
                $('#bookTypeName').text(obj.bookTypeName)
                if (obj.ontop != 1){
                    $('#ontop').css('display', 'none')
                }
                $('#price').text(obj.price+'￥')
                $('#amount').text(obj.amount+'本')
            }
        })
    },

    // 返回按钮
    backPage(type){
        switch (type){
            case "0":
                $('#returnPage').text('返回').click(function (){
                    window.history.back()
                })
                break
            case "1":
                $('#returnPage').text('返回书架').click(function (){
                    location.href = '/page/bookRack'
                })
                break
            case "2":
                $('#returnPage').text('返回书库').click(function (){
                    location.href = '/page/stackBook'
                })
                break
        }
    }
}