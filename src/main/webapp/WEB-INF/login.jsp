<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" language="java" %>
<html>
<head>
    <title>登录</title>
  <link rel="stylesheet" href="/static/layui/css/layui.css">
  <link rel="stylesheet" href="/static/css/login.css">
  <link rel="stylesheet" href="/static/css/index.css">
  <script src="/static/js/jquery-2.1.4.js"></script>
  <script src="/static/layui/layui.js"></script>
  <script src="/static/js/myLayui.js"></script>
  <script src="/static/js/index.js"></script>

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
</div>

<div class="login-body-div">
  <div class="body-login">
    <p class="login-title">登&nbsp;&nbsp;&nbsp;&nbsp;录</p>
    <input class="login-input" type="text" id="borrowCardNum" name="borrowCardNum" maxlength="11" placeholder=" 请输入您的卡号">
    <input class="login-input" type="text" id="name" name="name" placeholder=" 请输入您的姓名">
    <input class="login-input" type="password" id="password" name="password" placeholder=" 请输入管理员密码" style="display: none">
    <div class="login-verificationCode">
      <input class="login-verificationCode-input" type="text" id="verificationCode" name="verificationCode" maxlength="4" placeholder=" 请输入验证码">
      <img src="/verifyCode" class="login-code" id="verifyCodeImg">
    </div>
    <button class="login-btn" type="button" id="login">登 录</button><br>
    <a class="register" href="/page/insert">没有借书卡?注册</a>
  </div>
</div>
</body>
</html>
<script>
  indexJs.time()

  //判断是否为管理员账号
  $('#borrowCardNum').blur(function (){
    indexJs.isAdminBorrowCardNum('#borrowCardNum')
  })

  // 点击刷新验证码图片
  $('#verifyCodeImg').click(function (){
    indexJs.BrushverifyCode('#verifyCodeImg')
  })

  // 点击提交登录
  $('#login').click(function (){
    var cardNum = $('#borrowCardNum').val();
    var name = $('#name').val();
    var pass = $('#password').val();
    var code = $('#verificationCode').val();

    $.ajax({
      url: '/BorrowCard?method=login',
      data: {'adminCardNum':cardNum, 'name':name, 'password':pass, 'verificationCode':code},
      type: 'post',
      dataType: 'json',
      success: function (obj){
        console.log(obj.isOk)
        if (obj.isOk == false){
          myLayui.message(obj.msg, 2)
        }else if (obj.isOk == true && obj.admin == true){
          myLayui.message(obj.msg, 1)
          location.href = '/page//Admin/adminindex'
        }else {
          myLayui.message(obj.msg, 1)
          location.href = '/'
        }

        setTimeout(function (){
          location.reload()
        },1000)
      }
    })

  })
</script>
