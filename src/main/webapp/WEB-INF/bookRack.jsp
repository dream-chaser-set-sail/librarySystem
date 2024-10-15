<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--isELIgnored是管理EL表达式效果的 = 默认为true会忽略--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <title>我的书架</title>
  <link rel="stylesheet" href="/static/layui/css/layui.css">
  <link rel="stylesheet" href="/static/css/index.css">
  <link rel="stylesheet" href="/static/css/personal.css">
  <link rel="stylesheet" href="/static/css/bookrack.css">
  <script src="/static/js/jquery-2.1.4.js"></script>
  <script src="/static/layui/layui.js"></script>
  <script src="/static/js/myLayui.js"></script>
  <script src="/static/js/index.js"></script>
  <script src="/static/js/personalCenter.js"></script>

  <style>
    body {
      background-image: url("/static/img/bookrack.jpeg");
      background-size: cover; /* 确保背景图覆盖整个区域 */
      background-position: center; /* 背景图居中 */
      display: flex;
      flex-direction: column;
      justify-content: space-between;
    }
  </style>

</head>
<body>
<div class="head-div">
  <div class="head-div-left">
    <img src="/static/img/LOGO.png" alt="logo" class="head-logo">
    <p class="head-logo-txt">大学图书馆</p>
    <div class="head-div-time">
      <i class="layui-icon layui-icon-time head-i"></i>
      <span id="time" class="head-time" style="margin-left: 5px"></span>
    </div>
  </div>
  <div class="head-div-right" style="width: 18%">
    <h1 style="font-family: 汉呈疯狂行草; font-size: 48px; font-weight: bold">我的书架</h1>
  </div>
</div>


<div class="self-body" style="margin-top: 0px">
  <div class="self-body-left-div">
    <button class="self-body-left-menu" onclick="refresh()">个人信息</button>
    <button class="self-body-left-menu" onclick="myBookRack()" style="color: #ffffff">我的书架</button>
    <button class="self-body-left-menu" onclick="window.history.back()">返回</button>
  </div>
  <div id="bookList" style="width: 66%; height: 100%;">
    <div class="right-book-div" id="bookPackage"></div>
  </div>
</div>


<div class="container">
  <div id="popup" class="popup">
    <div class="popup-content">
      <h2 style="margin-bottom: 10px; font-family: 上首赛博体; font-size: 30px; color: #00ffcc">续期时间</h2>
      <select id="addDay" style="font-family: 上首赛博体">
        <option value="7">7天</option>
        <option value="15">15天</option>
      </select>
      <div style="display: flex; margin-bottom: 10px">
        <input type="number" class="cyberpunk-input" placeholder="输入天数">
        <button class="cyberpunk-button">自定义</button>
      </div>
      <button class="cyberpunk-button" id="ok" style="margin-bottom: 5px"><span>OK</span></button>
      <span class="close" onclick="closePopup()">&times;</span>
    </div>
  </div>
</div>
<input type="hidden">

</body>
</html>
<script>
  indexJs.time()
  bookRack.myBookRacks(${sessionScope.isLogin.borrowCardNum})

  // 点击事件 👇
  function refresh(){
    location.href = '/page/personalCenter'
  }

  function myBookRack(){
    location.href = '/page/bookRack'
  }

  // 还书
  function returnBook (inputIsbn){
    bookRack.backBooks('/BorrowBook?method=returnBook', inputIsbn, ${sessionScope.isLogin.borrowCardNum})
  }

  // 续期弹出框
  let isbn = null;

  function closePopup() {
    document.getElementById('popup').style.display = 'none';
  }

  function openPopup(inputIsbn) {
    isbn = inputIsbn
    document.getElementById('popup').style.display = 'flex';
  }

  $('.cyberpunk-button:first').click(function (){
    var inputBox = $('.cyberpunk-input');
    $(this).animate({width: '40%'}, 1000);
    inputBox.css('display', 'block');
  })

  $('#ok').click(function () {
    let add = null
    let inputBox = $('.cyberpunk-input');

    // 检查输入框的值
    if (inputBox.val() != null && inputBox.val() != ''){
      add = $('.cyberpunk-input').val();
    }else {
      add = $('#addDay').val();
    }

    $.ajax({
      url: '/BorrowBook?method=renewal',
      data: {add: add, isbn: isbn, borrowCardNum: ${sessionScope.isLogin.borrowCardNum}},
      dataType: 'json',
      type: 'post',
      success: function (obj){
        console.log(obj);
        if (obj){
          myLayui.message("续期完成", 1)
          location.reload()
        }else {
          myLayui.message("续期失败", 2)
        }
      }
    })
  })
</script>