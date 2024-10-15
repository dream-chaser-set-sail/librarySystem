<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>后台管理</title>
    <link rel="stylesheet" href="/static/layui/css/layui.css">
    <link rel="stylesheet" href="/static/css/system.css">
    <script src="/static/js/jquery-2.1.4.js"></script>
    <script src="/static/layui/layui.js"></script>
    <script src="/static/js/myLayui.js"></script>
</head>
<body>

<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo layui-hide-xs layui-bg-black">大学图书馆管理系统</div>
        <!-- 头部区域（可配合layui 已有的水平导航） -->
        <ul class="layui-nav layui-layout-left"></ul>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item layui-hide layui-show-sm-inline-block">
                <a href="javascript:;">
                    <img src="/lic/${sessionScope.isLogin.image}" class="layui-nav-img">
                    ${sessionScope.isLogin.name}
                </a>
                <dl class="layui-nav-child">
                    <dd><a href="javascript:;" onclick="myself()">个人信息</a></dd>
                    <dd><a href="javascript:;" onclick="out()">退出</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item" lay-header-event="menuRight" lay-unselect>
                <a href="javascript:;" onclick="out()">
                    <i class="layui-icon layui-icon-logout"></i>
                    注销
                </a>
            </li>
        </ul>
    </div>
    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree" lay-filter="test">
                <li class="layui-nav-item">
                    <a href="javascript:;"
                       data-url = "/page//Admin/admin"
                       class="site-demo-active">
                        管理员管理
                    </a>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;"
                       data-url = "/page//Admin/user"
                       class="site-demo-active">
                        用户管理
                    </a>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;"
                       data-url = "/page//Admin/book"
                       class="site-demo-active">
                        书籍管理
                    </a>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;"
                       data-url = "/page//Admin/borrow/book"
                       class="site-demo-active">
                        借阅管理
                    </a>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;"
                       data-url = "/page//Admin/integrated"
                       class="site-demo-active">
                        综合管理
                    </a>
                </li>
            </ul>
        </div>
    </div>
    <div class="layui-body" style="padding: 0">
        <!-- 内容主体区域 -->
        <iframe name="rightframe" width="99%" height="97%" src="/page//Admin/background/color"></iframe>
    </div>
    <div class="layui-footer">
        <!-- 底部固定区域 -->
        底部固定区域
    </div>
</div>

</body>
</html>
<script>
    //JS
    layui.use(['element', 'layer', 'util'], function() {
        var element = layui.element
            , layer = layui.layer
            , util = layui.util
            , $ = layui.jquery;

        $('.site-demo-active').click(function () {
            window.open($(this).data('url'), "rightframe");
        });
        element.render();// element.init();
        function openURL(url) {
            window.open(url, "rightframe");
        }
    })

    function myself(){
        layer.open({
            type: 2,
            title: '个人信息',
            shadeClose: true,
            shade: 0.8,
            area: ['60%', '80%'],
            content: '/page//Admin/personal'// iframe 的 url
        })
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
</script>