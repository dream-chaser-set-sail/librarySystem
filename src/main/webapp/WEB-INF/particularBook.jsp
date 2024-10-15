<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--isELIgnored是管理EL表达式效果的 = 默认为true会忽略--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <title>书籍详情页</title>
    <link rel="stylesheet" href="/static/layui/css/layui.css">
    <link rel="stylesheet" href="/static/css/index.css">
    <link rel="stylesheet" href="/static/css/particularBook.css">
    <link rel="stylesheet" href="/static/css/bookrack.css">
    <script src="/static/js/jquery-2.1.4.js"></script>
    <script src="/static/layui/layui.js"></script>
    <script src="/static/js/myLayui.js"></script>
    <script src="/static/js/index.js"></script>
    <script src="/static/js/personalCenter.js"></script>
    <script src="/static/js/particularBook.js"></script>
</head>
<body>
<div class="head-div" style="height: 11%">
    <div class="head-div-left">
        <%--alt 属性提供了图像的描述，这有助于无障碍访问和在图像无法加载时显示替代信息--%>
        <img src="/static/img/LOGO.png" alt="logo" class="head-logo">
        <a href="/" class="head-logo-txt">大学图书馆</a>
        <div class="head-div-time">
            <i class="layui-icon layui-icon-time head-i"></i>
            <span id="time" class="head-time" style="margin-left: 5px"></span>
        </div>
    </div>
    <div class="head-div-right">
        <div class="head-div-input">
            <i class="layui-icon layui-icon-search head-i"></i>
            <input type="text" id="selBook" class="head-input-text" placeholder=" 请输入您要查询的书名">
        </div>
        <div class="head-div-headPhoto">
            <img src="/lic/${sessionScope.isLogin.image}" alt="head portrait" id="headPhoto" class="head-headPhoto">
            <span class="head-div-username" id="username">${sessionScope.isLogin.name}</span>
            <dl class="head-user-list" id="user-list">
                <dd id="yourProfile">个人中心</dd>
                <dd id="myBookrack">我的书架</dd>
                <dd id="quit" onclick="out()">退出登录</dd>
            </dl>
        </div>
    </div>
</div>

<div class="book-particular-body">
    <div class="body-card">
        <div class="body-card-left">
            <div class="left-card-top">
                <div style="display: flex; align-items: center;">
                    <p id="bookName" style="padding: 0 0 0 20px; font-size: 50px"></p>
                    <p style="font-size: 20px; margin-left: 20px">
                        作者:&nbsp;
                        <p id="author" style="font-size: 16px"></p>
                    </p>
                </div>
                <div style="margin-right: 30px">
                    <i class="layui-icon layui-icon-fire" style="font-size: 80px; font-style: italic; color: rgb(119,119,119);">
                        <span id="onclickNum" style="font-family: 上首赛博体"></span>
                    </i>
                </div>
            </div>
            <div class="left-card-bottom">
                <div>
                    <div class="book-cover" style="margin: 40px 30px; width: 250px; height: 330px">
                        <img id="image">
                    </div>
                    <button id="borrow" class="particular-book-btn" onclick="borrowBookByuser()">我要借阅</button>
                    <button id="back" class="particular-book-btn" style="background: linear-gradient(to bottom, #FF5733, #C70039);" onclick="backBookByuser()">我要归还</button>
                </div>
                <div style="width: 50%; height: 84%; margin: 40px 30px; overflow: auto">
                    <p id="synopsis" style="font-family: 汉仪李胜洪侠客行; font-size: 30px"></p>
                </div>
            </div>
        </div>
        <div class="body-card-right">
            <div class="book-msg">
                <div class="book-msg-div">
                    <p>书名: </p>
                    <p id="name"></p>
                </div>
                <div class="book-msg-div">
                    <p>书号: </p>
                    <p id="isbn"></p>
                </div>
                <div class="book-msg-div">
                    <p>出版社: </p>
                    <p id="publishingHouse"></p>
                </div>
                <div class="book-msg-div">
                    <p>入馆时间: </p>
                    <p id="createTime"></p>
                </div>
                <div class="book-msg-div">
                    <a id="bookTypeName" class="book-tag"></a>
                    <p id="ontop" class="book-tag"> 置顶 </p>
                </div>
            </div>
            <div class="book-else">
                <div class="book-msg-div" style="border-top: 1px dashed black; padding-top: 10px">
                    <p>价格: </p>
                    <p id="price"></p>
                </div>
                <div class="book-msg-div" style="border-bottom: 1px dashed black; padding-bottom: 10px">
                    <p>数量: </p>
                    <p id="amount"></p>
                </div>
            </div>
            <button id="returnPage" class="particular-book-btn" style="background: linear-gradient(to bottom, #8e8eff, #4d4dff); margin-bottom: 57px"></button>
        </div>
    </div>
</div>

<div class="dialog-box" id="borrowBookDialog">
    <div class="dialog-header">
        <h2>我要借书</h2>
        <span class="close-btn">×</span>
    </div>
    <div class="dialog-body">
        <div class="input-group">
            <input id="addNum" type="number" placeholder="请输入借阅天数...">
            <button id="submit" type="button">提交</button>
        </div>
        <span style="color: red; display: none">借书时长不能超过60天</span>
    </div>
</div>

<div class="foot-div">
    <div class="foot-slogan">
        <h1 class="foot-div-h1">书山有路勤为径，学海无涯苦作舟</h1>
    </div>
    <div class="foot-copy">
        <h3 style="font-family: 宋体">大学图书馆&copy;版权所有</h3>
    </div>
</div>
</body>
</html>
<script>
    indexJs.time()
    indexJs.pullDownlist('#username, #headPhoto', '#user-list')
    var params = new URLSearchParams(window.location.search);
    var isbn = params.get('isbn');
    // 0 其他 1 书架 2 书库
    var type = params.get('type');
    details.loadParticularBook(isbn, ${sessionScope.isLogin.borrowCardNum})
    details.backPage(type)

    // 借书按钮
    function borrowBookByuser(){
        $('#borrowBookDialog').css('display', 'block')
    }
    // 关闭对话框
    $('.close-btn').click(function (){
        $('#borrowBookDialog').css('display', 'none')
    })

    $('#submit').click(function (){
        var addNum = $('#addNum').val();
        $.ajax({
            url: '/BorrowBook?method=add',
            data: {isbn: isbn, addNum: addNum, uid: ${sessionScope.isLogin.borrowCardNum}},
            type: 'post',
            dataType: 'json',
            success: function (obj) {
                console.log(obj);
                if (obj.hint != null){
                    myLayui.message(obj.hint, 0)
                }
                if (obj.isOk == true){
                    myLayui.message("借阅成功", 1)
                }else {
                    myLayui.message("借阅失败", 2)
                }
                setTimeout(function (){
                    location.reload()
                }, 1000)
            }
        })
    })
    // 借书输入框规则
    $('#addNum').blur(function (){
        var text = $('#addNum').val();
        if (text >= 60){
            $('.dialog-body span').css('display', 'block')
            $('#submit').prop('disabled', true)
        }else {
            $('.dialog-body span').css('display', 'none')
            $('#submit').prop('disabled', false)
        }
    })

    // 还书按钮
    function backBookByuser(){
        bookRack.backBooks('/BorrowBook?method=returnBook', isbn, ${sessionScope.isLogin.borrowCardNum})
    }

    function out(){
        layer.confirm('您确定要退出吗？', {icon: 3}, function (){
            location.href = '/BorrowCard?method=quit'
            myLayui.message('已退出…', 0)
            setTimeout(function (){
                location.reload()
            },500)
        })
    }

    $('#yourProfile').click(function (){
        location.href = '/page/personalCenter'
    })

    $('#myBookrack').click(function (){
        location.href = '/page/bookRack'
    })
</script>
