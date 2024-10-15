<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>个人信息</title>
    <link rel="stylesheet" href="/static/layui/css/layui.css">
    <link rel="stylesheet" href="/static/css/system.css">
    <script src="/static/js/jquery-2.1.4.js"></script>
    <script src="/static/layui/layui.js"></script>
    <script src="/static/js/myLayui.js"></script>
</head>
<body>
<div class="layui-panel">
    <div style="padding: 20px;">
        <div class="show-body">
            <div class="left-show">
                <div class="left-show-img">
                    <img src="/lic/${sessionScope.isLogin.image}">
                </div>
                <h2>管理员${sessionScope.isLogin.name}</h2>
                <p>注册日期: ${sessionScope.isLogin.createTime}</p>
                <div style="margin-top: 15px; margin-bottom: 15px">
                    <input type="hidden" id="imgName">
                    <button type="button" class="layui-btn demo-class-accept" lay-options="{accept: 'file'}">
                        <i class="layui-icon layui-icon-upload"></i>
                        修改头像
                    </button>
                </div>
                <p>基本信息</p>
                <div style="margin-top: 15px; margin-bottom: 15px">
                    <p style="margin-bottom: 10px">卡号: ${sessionScope.isLogin.adminCardNum}</p>
                    <p style="margin-bottom: 10px; display: block" id="spass">密码: ${sessionScope.isLogin.password}</p>
                    <input type="password" id="pass" style="display: none; margin-bottom: 10px" placeholder="输入新密码">
                    <button type="button" class="layui-btn" onclick="upPass()">修改密码</button>
                </div>
            </div>

            <div class="right-show">
                <h2>详细信息</h2>
                <div class="right-show-div">
                    <p>卡号: <span id="cardNum"></span></p>
                </div>
                <div class="right-show-div">
                    <p>姓名: <span id="name"></span></p>
                </div>
                <div class="right-show-div">
                    <p>单位: <span id="unit"></span></p>
                </div>
                <div class="right-show-div">
                    <p>身份: <span id="role"></span></p>
                </div>
                <div class="right-show-div">
                    <p>信誉: <span id="credit"></span></p>
                </div>
                <div class="right-show-div">
                    <p>注册日期: <span id="date"></span></p>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
<script>
    layui.use(function(){
        var upload = layui.upload;
        var layer = layui.layer;
        // 渲染
        upload.render({
            elem: '.demo-class-accept', // 绑定多个元素
            url: '/upload', // 此处配置你自己的上传接口即可
            accept: 'file', // 普通文件
            done: function(res){
                if (res.result === true){
                    $('#imgName').val(res.imgName);
                    $.ajax({
                        type:'post',
                        url:'/Admin?method=upImg',
                        dataType:'json',
                        data:{'imgName': $('#imgName').val(), 'id': ${sessionScope.isLogin.adminCardNum}, 'role': 0},
                        success: function (obj){
                            if (obj == true){
                                myLayui.message('执行成功', 1)
                                location.reload()
                            }else {
                                myLayui.message('执行失败', 2)
                            }
                        }
                    })
                }else {
                    layer.msg('上传失败');
                }
            }
        });
    });

    $.ajax({
        type:'post',
        url:'/BorrowCard?method=selUser',
        dataType:'json',
        data:{'id': ${sessionScope.isLogin.adminCardNum}},
        success: function (obj){
            $('#cardNum').text(obj.borrowCardNum)
            $('#name').text(obj.name)
            $('#unit').text(obj.unitName)
            $('#role').text(obj.roleName)
            $('#credit').text(obj.creditScore)
            $('#date').text(obj.createTime)
        }
    })

    function upPass(){
        $('#pass').css('display','block')
        $('#spass').css('display','none')
    }
    $('#pass').blur(function (){
        $.ajax({
            type:'post',
            url:'/Admin?method=upPass',
            dataType:'json',
            data:{'pass': $('#pass').val(), 'id': ${sessionScope.isLogin.id}},
            success: function (obj){
                if (obj == true){
                    location.reload()
                    // $('#pass').css('display','none')
                    // $('#spass').css('display','block')
                }else {
                    myLayui.message('执行失败', 2)
                }
            }
        })
    })

    window.onunload = function() {
        window.parent.location.reload();
    };
</script>