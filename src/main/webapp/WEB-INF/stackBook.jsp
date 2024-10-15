<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>书库</title>
    <link rel="stylesheet" href="/static/layui/css/layui.css">
    <link rel="stylesheet" href="/static/css/index.css">
    <link rel="stylesheet" href="/static/css/stackBook.css">
    <script src="/static/js/jquery-2.1.4.js"></script>
    <script src="/static/layui/layui.js"></script>
    <script src="/static/js/myLayui.js"></script>
    <script src="/static/js/index.js"></script>
    <script src="/static/js/stackBook.js"></script>
</head>
<body>
<div class="head-div">
    <p id="home"></p>
    <div class="head-div-left">
        <%--alt 属性提供了图像的描述，这有助于无障碍访问和在图像无法加载时显示替代信息--%>
        <img src="/static/img/LOGO.png" alt="logo" class="head-logo">
        <p id="back" class="head-logo-txt">大学图书馆</p>
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

<div class="body-stack">
    <div class="container">
    <%--左侧--%>
        <div class="left-classify">
            <h2>书籍分类</h2>
            <ul id="book-classify"></ul>
        </div>
    <%--右侧--%>
        <div class="book-list-container">
            <h2>书籍列表</h2>
            <div class="book-list" id="book-list">
                <%--<div class="book-item">
                    <div class="item-img-div">
                        <a><img src="/static/img/点彩水墨画.png"></a>
                    </div>
                    <div class="item-content-div">
                        <p>书名1</p>
                        <p><i class="layui-icon layui-icon-user" style="margin-right: 3px"></i>作者1 | 标签1</p>
                        <p>简介1</p>
                    </div>
                </div>--%>
            </div>
            <!-- 分页 -->
            <div class="pagination">
                <input type="hidden" id="countPage">
                <button id="up"><i class="layui-icon layui-icon-left" style="font-size: 30px"></i></button>
                <button id="down"><i class="layui-icon layui-icon-right" style="font-size: 30px"></i></button>
            </div>
        </div>
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
    indexJs.setupEnterSubmit('selBook')
    stackJs.selClassify()
    stackJs.books(1)

    // 分页
    let page = 1
    let typeId = null
    let nameBook = null
    $('#up').click(function (){
        var count = $('#countPage').val();
        var divisor = count/10
        var num = Math.ceil(divisor)
        page -= 1
        stackJs.books(page, nameBook, typeId)
        if (page <= 1) {
            $('#up').css('display', 'none')
            $('#down').css('display', 'block')
        } else {
            $('#up').css('display', 'block')
            $('#down').css('display', 'block')
        }
    })

    $('#down').click(function (){
        var count = $('#countPage').val();
        var divisor = count/10
        var num = Math.ceil(divisor)
        page += 1
        stackJs.books(page, nameBook, typeId)
        if (page >= num) {
            $('#down').css('display', 'none')
            $('#up').css('display', 'block')
        } else {
            $('#down').css('display', 'block')
            $('#up').css('display', 'block')
        }
    })

    $('#book-classify').on('click', 'li p', function () {
        var typeIds = $(this).parent().attr('id');
        typeId = typeIds
        stackJs.books(1, '', typeIds)
    });

    $('#yourProfile').click(function (){
        location.href = '/page/personalCenter'
    })

    $('#myBookrack').click(function (){
        location.href = '/page/bookRack'
    })

    $('#back').click(function (){
        window.history.back()
    })
</script>