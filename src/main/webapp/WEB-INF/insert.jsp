<%--
  Created by IntelliJ IDEA.
  User: Dell
  Date: 2024/9/1
  Time: 17:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>注册</title>
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
  <div class="body-login" style="height: 80%">
    <p class="login-title">注&nbsp;&nbsp;&nbsp;&nbsp;册</p>
    <input class="login-input" type="text" id="name" name="name" placeholder=" 请输入您的姓名">
    <select class="login-input" id="unit">
      <option>请选择您的单位</option>
    </select>
    <select class="login-input" id="roles">
      <option>请选择您的身份</option>
    </select>
    <div class="imgup-div">
      <input type="hidden" name="image" id="image">
      <input type="file" id="fileInput" accept="image/*">
      <div id="preview" class="img-div"></div>
      <label for="fileInput" class="custom-file-upload">上传头像</label>
    </div>
    <div class="login-verificationCode">
      <input class="login-verificationCode-input" type="text" id="verificationCode" name="verificationCode" maxlength="4" placeholder=" 请输入验证码">
      <img src="/verifyCode" class="login-code" id="verifyCodeImg">
    </div>
    <button class="login-btn" type="button" id="insert">注 册</button><br>
    <a class="register" href="/page/login" style="margin-bottom: 6px">返回登录</a>
  </div>
</div>
</body>
</html>
<script>
    indexJs.time()
    indexJs.uploads('#fileInput', '#preview', '#image')
    indexJs.selDownList('/Department?method=selAll', '#unit')
    indexJs.selDownList('/Role?method=selAll', '#roles')

    // 点击刷新验证码图片
    $('#verifyCodeImg').click(function (){
      indexJs.BrushverifyCode('#verifyCodeImg')
    })

    // 点击提交表单...
    $('#insert').click(function (){
      var name = $('input[name = name]').val();
      var image = $('#image').val();
      var unit = $('#unit option:selected').val();
      var roles = $('#roles option:selected').val();
      var verificationCode = $('#verificationCode').val();

      $.ajax({
        url: '/BorrowCard?method=register',
        data: {'name':name, 'image':image, 'unit':unit, 'role':roles, 'verificationCode':verificationCode},
        type: 'post',
        dataType: 'json',
        success: function (obj){
          console.log(obj)
          if (obj){
            myLayui.message("注册成功，请返回登录", 1)
          }else {
            myLayui.message("注册失败", 2)
          }
          setTimeout(function (){
            location.reload();
          },1000)
        }
      })

    })
</script>