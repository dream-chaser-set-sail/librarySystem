<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--isELIgnored是管理EL表达式效果的 = 默认为true会忽略--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <title>个人中心</title>
    <link rel="stylesheet" href="/static/layui/css/layui.css">
    <link rel="stylesheet" href="/static/css/index.css">
    <link rel="stylesheet" href="/static/css/personal.css">
    <script src="/static/js/jquery-2.1.4.js"></script>
    <script src="/static/layui/layui.js"></script>
    <script src="/static/js/myLayui.js"></script>
    <script src="/static/js/index.js"></script>
    <script src="/static/js/personalCenter.js"></script>
    <style>
        body {
            background-image: url("/static/img/点彩水墨画.png");
            background-size: cover; /* 确保背景图覆盖整个区域 */
            background-position: center; /* 背景图居中 */
            height: 100vh; /* 设置高度为视口高度 */
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }
    </style>
</head>
<body>
<div class="self-body">
    <div class="self-body-left-div">
        <button class="self-body-left-menu" onclick="refresh()" style="color: #ffffff">个人信息</button>
        <button class="self-body-left-menu" onclick="myBookRack()">我的书架</button>
        <button class="self-body-left-menu" onclick="window.history.back()">返回</button>
    </div>
    <div class="self-body-right-div">
        <div class="self-body-top">
            <div class="self-img-div">
                <img src="/lic/${sessionScope.isLogin.image}">
            </div>
            <div class="self-msg-div">
                <div>
                    <p>姓名: <span id="name"></span></p>
                    <p>卡号: <span id="borrowCard"></span></p>
                    <p>单位: <span id="unitName"></span></p>
                </div>
                <div>
                    <p>身份: <span id="roleName"></span></p>
                    <p>信誉: <span id="credit"></span></p>
                    <p>注册时间: <span id="creatTime"></span></p>
                </div>
            </div>
            <div class="self-btn-div">
                <button id="updateSelf">修改信息</button>
            </div>
        </div>
        <div class="self-body-bottom">
            <div class="self-body-bottom-left">
                <div style="text-align: center; font-size: 20px">
                    <h1 style="font-family: 汉仪李胜洪侠客行">借阅记录</h1>
                    <div class="self-borrowMsg"></div>
                </div>
            </div>
            <div class="self-body-bottom-right">
                <div style="text-align: center; font-size: 20px">
                    <h1 style="font-family: 汉仪李胜洪侠客行">足迹</h1>
                    <div style="margin-top: 5px; border-top: 1px solid rgba(164,155,155,0.5); text-align: left">
                        <p style="margin-top: 10px; font-family: 汉呈疯狂行草; font-size: 25px; font-weight: bold">借阅书籍: &nbsp; <span id="bookNum">0</span>&nbsp;本</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%--对话框--%>
<div id="isUpdate" style="display: none">
<div class="update">
    <div class="update-top">
        <div class="update-img-div">
            <img src="/lic/${sessionScope.isLogin.image}">
        </div>
        <input type="hidden" id="imgName">
        <button type="button" class="layui-btn demo-class-accept" style="width: 100%; margin-top: 5px" lay-options="{accept: 'file'}">
            <i class="layui-icon layui-icon-upload"></i>
            修改头像
        </button>
    </div>
    <div class="update-bottom">
        <input type="text" placeholder=" 请输入您的新姓名" id="uname">
        <select id="unit">
            <option>请选择您的新单位</option>
        </select>
        <select id="role">
            <option>请选择您的新身份</option>
        </select>
        <div style="display: flex; justify-content: space-between">
            <button class="body-renewal-btn" style="height: 40px; width: 50%" onclick="sumbit()">提交</button>
            <button class="body-renewal-btn" style="height: 40px; width: 50%" onclick="refer()">取消</button>
        </div>
    </div>
</div>
</div>

</body>
</html>
<script>
    personalCenter.selUser(${sessionScope.isLogin.borrowCardNum})
    personalCenter.borrowBookNum(${sessionScope.isLogin.borrowCardNum})
    personalCenter.LoanRecord(${sessionScope.isLogin.borrowCardNum})

    indexJs.selDownList('/Department?method=selAll','#unit')
    indexJs.selDownList('/Role?method=selAll','#role')

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
                        data:{'imgName': $('#imgName').val(), 'id': ${sessionScope.isLogin.borrowCardNum}, "role": 1},
                        success: function (obj){
                            console.log(obj);
                            if (obj == true){
                                myLayui.message('执行成功', 1)
                                setTimeout(function (){
                                    location.reload()
                                },1000)
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



    $('#updateSelf').click(function (){
        $('#isUpdate').css('display', 'block')
    })

    function sumbit(){
        var name = $('#uname').val();
        var unit = $('#unit').val();
        var role = $('#role').val();
        $.ajax({
            url: '/BorrowCard?method=upByself',
            data: {name:name, unit:unit, role:role, borrowCardNum:${sessionScope.isLogin.borrowCardNum}},
            dataType: 'json',
            type: 'post',
            success: function (obj){
                if (obj){
                    myLayui.message('修改成功', 1)
                    $('#isUpdate').css('display', 'none')
                    setTimeout(function() {
                        location.reload();
                    }, 1000)
                }else {
                    myLayui.message('修改失败', 2)
                }
            }
        })
    }

    function refer(){
        $('#isUpdate').css('display', 'none')
    }

    function refresh(){
        location.href = '/page/personalCenter'
    }

    function myBookRack(){
        location.href = '/page/bookRack'
    }
</script>