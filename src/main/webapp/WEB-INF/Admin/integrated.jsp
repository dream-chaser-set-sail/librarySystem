<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>综合管理</title>
    <link rel="stylesheet" href="/static/layui/css/layui.css">
    <script src="/static/js/jquery-2.1.4.js"></script>
    <script src="/static/layui/layui.js"></script>
    <script src="/static/js/myLayui.js"></script>
    <script src="/static/js/integrateds.js"></script>
</head>
<body>
<div class="layui-tab layui-tab-brief">
    <ul class="layui-tab-title">
        <li class="layui-this">单位</li>
        <li>身份</li>
        <li>书籍标签</li>
        <li>状态</li>
        <li>黑名单</li>
    </ul>

    <div class="layui-tab-content">
        <div class="layui-tab-item layui-show">

            <table class="layui-hide" id="departmentTable" lay-filter="test"></table>

            <script type="text/html" id="barDemo1">
                <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
                <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
            </script>
            <script type="text/html" id="toolbarDemo1">
                <button class="layui-btn layui-bg-blue layui-btn-radius layui-btn-sm" lay-event="Add"><i class="layui-icon layui-icon-edit"></i></button>
                <button class="layui-btn layui-bg-red layui-btn-radius layui-btn-sm" lay-event="DelAll"><i class="layui-icon layui-icon-delete"></i></button>
            </script>
        </div>

        <div class="layui-tab-item">
            <table class="layui-hide" id="RoleTable" lay-filter="test"></table>

            <script type="text/html" id="barDemo2">
                <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
                <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
            </script>
            <script type="text/html" id="toolbarDemo2">
                <button class="layui-btn layui-bg-blue layui-btn-radius layui-btn-sm" lay-event="Add"><i class="layui-icon layui-icon-edit"></i></button>
                <button class="layui-btn layui-bg-red layui-btn-radius layui-btn-sm" lay-event="DelAll"><i class="layui-icon layui-icon-delete"></i></button>
            </script>
        </div>

        <div class="layui-tab-item">
            <table class="layui-hide" id="ClassifyTable" lay-filter="test"></table>

            <script type="text/html" id="barDemo3">
                <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
                <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
            </script>
            <script type="text/html" id="toolbarDemo3">
                <button class="layui-btn layui-bg-blue layui-btn-radius layui-btn-sm" lay-event="Add"><i class="layui-icon layui-icon-edit"></i></button>
                <button class="layui-btn layui-bg-red layui-btn-radius layui-btn-sm" lay-event="DelAll"><i class="layui-icon layui-icon-delete"></i></button>
            </script>
        </div>

        <div class="layui-tab-item">
            <table class="layui-hide" id="StatusTable" lay-filter="test"></table>

            <script type="text/html" id="barDemo4">
                <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
                <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
            </script>
            <script type="text/html" id="toolbarDemo4">
                <button class="layui-btn layui-bg-blue layui-btn-radius layui-btn-sm" lay-event="Add"><i class="layui-icon layui-icon-edit"></i></button>
                <button class="layui-btn layui-bg-red layui-btn-radius layui-btn-sm" lay-event="DelAll"><i class="layui-icon layui-icon-delete"></i></button>
            </script>
        </div>

        <div class="layui-tab-item">
            <table class="layui-hide" id="CreditTable" lay-filter="test"></table>

            <script type="text/html" id="barDemo5">
                <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
                <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
            </script>
            <script type="text/html" id="toolbarDemo5">
                <button class="layui-btn layui-bg-blue layui-btn-radius layui-btn-sm" lay-event="Add"><i class="layui-icon layui-icon-edit"></i></button>
                <button class="layui-btn layui-bg-red layui-btn-radius layui-btn-sm" lay-event="DelAll"><i class="layui-icon layui-icon-delete"></i></button>
            </script>
        </div>
    </div>
</div>
</body>
</html>
<script>
integratedJs.thisOneData();
integratedJs.thisTwoData();
integratedJs.thisThreeData();
integratedJs.thisFourData();
integratedJs.thisFiveData();
</script>