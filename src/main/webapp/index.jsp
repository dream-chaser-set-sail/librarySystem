<%@ page import="Bean.BorrowCard" %>

<%--isELIgnored是管理EL表达式效果的 = 默认为true会忽略--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>首页</title>
    <link rel="stylesheet" href="static/layui/css/layui.css">
    <link rel="stylesheet" href="static/css/index.css">
    <script src="static/js/jquery-2.1.4.js"></script>
    <script src="static/layui/layui.js"></script>
    <script src="static/js/myLayui.js"></script>
    <script src="static/js/index.js"></script>

    <style>
        body{
            padding: 0;
            margin: 0;
            display: flex;
            flex-direction: column; /* 垂直排列子项 */
        }
        html {
            scroll-behavior: smooth;
        }
    </style>

</head>
<body>
<div class="head-div">
    <p id="home"></p>
    <div class="head-div-left">
        <%--alt 属性提供了图像的描述，这有助于无障碍访问和在图像无法加载时显示替代信息--%>
        <img src="static/img/LOGO.png" alt="logo" class="head-logo">
        <p class="head-logo-txt">大学图书馆</p>
        <div class="head-div-time">
            <i class="layui-icon layui-icon-time head-i"></i>
            <span id="time" class="head-time" style="margin-left: 5px"></span>
        </div>
    </div>
    <div class="head-div-right">
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

<div class="body-div">
    <div class="body-div-h1">
        <h1 class="body-h1">欢迎<span>${isLogin.name}</span>
            <c:choose>
                <c:when test="${isLogin.role == 1}">
                    <span>老师</span>
                </c:when>
                <c:when test="${isLogin.role == 2}">
                    <span>同学</span>
                </c:when>
                <c:otherwise>
                    <span>用户</span>
                </c:otherwise>
            </c:choose>
            访问校园图书馆</h1>
    </div>

    <div style="margin-bottom: 80px; margin-top: 160px">
        <div class="body-div-isStatus" id="isStatus1">
            <button type="button" class="body-unborrowed-btn">我要借书</button>
        </div>
        <div class="body-div-isStatus" id="isStatus2">
            <%--判断借书数量是否达到最大--%>
            <div class="body-div-isBooknum" id="isBooknum0">
                <button type="button" class="body-unborrowed-btn">我要借书</button>
                <button type="button" class="body-borrowed-btn">我要还书</button>
                <button type="button" class="body-renewal-btn">我要续期</button>
            </div>
            <div class="body-div-isBooknum" id="isBooknum1">
                <button type="button" class="body-borrowed-btn">我要还书</button>
                <button type="button" class="body-renewal-btn">我要续期</button>
            </div>
        </div>
        <div class="body-div-isStatus" id="isStatus3">
            <%--有一本书逾期也是逾期--%>
            <%--判断信誉 > 50 可以接着借 < 50 不能--%>
            <div class="body-div-isCredit" id="isCredit0">
                <div class="body-div-isBooknum" id="isbookNum_iscredit0">
                    <h1 class="body-reminder-h1">您订阅的书籍已有逾期，请查看书架后立刻归还书籍。</h1><br>
                    <button type="button" class="body-unborrowed-btn" style="margin-left: 200px">我要借书</button>
                    <button type="button" class="body-borrowed-btn">我要还书</button>
                </div>
                <div class="body-div-isBooknum" id="isbookNum_iscredit1">
                    <h1 class="body-reminder-h1">您订阅的书籍已有逾期，请查看书架后立刻归还书籍。</h1><br>
                    <button type="button" class="body-borrowed-btn" style="margin-left: 290px">我要还书</button>
                </div>
            </div>
            <div class="body-div-isCredit" id="isCredit1">
                <h1 class="body-reminder-h1">由于您的信誉过低已将您移入失信人员名单！您借阅的书籍已逾期，请立刻归还书籍！</h1><br>
                <button type="button" class="body-borrowed-btn" style="margin-left: 450px">我要还书</button>
            </div>
        </div>
        <div style="margin-top: 30px; text-align: center">
            <a href="#goodBook">
                <i class="layui-icon layui-icon-down" style="font-size: 40px"></i>
            </a>
        </div>
    </div>
</div>

<%--好书推荐--%>
<div class="body-index">
    <p id="goodBook"></p>
    <div class="body-index-div">
        <div class="body-index-right-div">
            <div class="body-index-carousel">
                <div style="font-family: 汉仪李胜洪侠客行; font-size: 100px; letter-spacing: 30px; margin-right: 10px"><p style="writing-mode: vertical-rl">好书推荐</p></div>
                <div class="layui-carousel" id="ID-carousel-demo-image">
                    <div carousel-item>
                        <a id="img1"><img src=""></a>
                        <a id="img2"><img src=""></a>
                        <a id="img3"><img src=""></a>
                        <a id="img4"><img src=""></a>
                        <a id="img5"><img src=""></a>
                    </div>
                </div>
            </div>
            <div style="margin-top: 30px; margin-left: 150px">
                <a href="#hotBook">
                    <i class="layui-icon layui-icon-down" style="font-size: 40px"></i>
                </a>
            </div>
        </div>
    </div>
</div>

<%--热门书籍--%>
<div class="body-index">
    <p id="hotBook"></p>
    <div id="hot-book" class="hotBook-div">
        <div style="font-family: 汉仪李胜洪侠客行; font-size: 100px; letter-spacing: 30px; margin-right: 10px"><p style="writing-mode: vertical-rl">热门书籍</p></div>
        <div class="hotBook-frame">
            <div class="hot-book">
                <div class="image-container">
                    <a><img src="static/img/点彩水墨画.png"></a>
                </div>
                <div class="hot-book-text">《繁星》</div>
            </div>
        </div>
        <div class="hotBook-frame">
            <div class="hot-book">
                <div class="image-container">
                    <a><img src="static/img/点彩水墨画.png"></a>
                </div>
                <div class="hot-book-text">《繁星》</div>
            </div>
        </div>
        <div class="hotBook-frame">
            <div class="hot-book">
                <div class="image-container">
                    <a><img src="static/img/点彩水墨画.png"></a>
                </div>
                <div class="hot-book-text">《繁星》</div>
            </div>
        </div>
        <div style="margin-top: 640px">
            <a href="#home" style="color: black; font-weight: bold">
                <i class="layui-icon layui-icon-top" style="font-size: 40px"></i>
            </a>
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

<%--退出弹出框--%>
<div class="index-modal">
    <div class="modal-title">
        <h2>退出</h2>
        <span class="model-close">&times;</span>
    </div>
    <div class="model-body">
        <div>
            <h2 style="margin: 20px 0">您确定要退出吗 ?</h2>
        </div>
        <div style="display: flex;">
            <button id="model-ok" class="model-btn" style="margin-left: 53px">确定</button>
            <button id="model-no" class="model-btn" style="margin-left: 55px">取消</button>
        </div>
    </div>
</div>
</body>
</html>
<script>
    $.ajax({
        url: '/BorrowCard?method=selUser',
        type: 'get',
        data: {id: ${sessionScope.isLogin.borrowCardNum}},
        dataType: 'json',
        success: function (obj){
            indexJs.filtrateBtn(obj.status, obj.borrowedBooksNum, obj.permission, obj.creditScore)
        }
    })
    indexJs.time()
    indexJs.pullDownlist('#username, #headPhoto', '#user-list')
    // indexJs.filtrateBtn(1,5,5,49)
    indexJs.goodBook()
    indexJs.hotBook()

    function out(){
        $('.index-modal').css('display', 'block');
    }

    $('.model-close, #model-no').click(function (){
        $('.index-modal').css('display', 'none');
    })

    $('#model-ok').click(function (){
        location.href = '/BorrowCard?method=quit'
    })

    $('#yourProfile').click(function (){
        location.href = '/page/personalCenter'
    })

    $('#myBookrack').click(function (){
        location.href = '/page/bookRack'
    })

    layui.use(['carousel'], function(){
        var carousel = layui.carousel;
        carousel.render({
            elem: '#ID-carousel-demo-image',
            width: '60%',
            height: '100%',
            interval: 3000
        });
    });

    // 借书按钮
    $('.body-unborrowed-btn').click(function (){
        location.href = '/page/stackBook' // 书库
    })

    // 还书按钮
    $('.body-borrowed-btn').click(function () {
        location.href = '/page/bookRack'
    })

    // 逾期按钮
    $('.body-renewal-btn').click(function (){
        location.href = '/page/bookRack'
    })

</script>