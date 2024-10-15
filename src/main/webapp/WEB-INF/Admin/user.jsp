<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户管理</title>
    <link rel="stylesheet" href="/static/layui/css/layui.css">
    <link rel="stylesheet" href="/static/css/system.css">
    <script src="/static/js/jquery-2.1.4.js"></script>
    <script src="/static/layui/layui.js"></script>
    <script src="/static/js/myLayui.js"></script>
</head>
<body>
<form class="layui-form">
    <div class="layui-inline">
        <input type="text" name="name" lay-affix="clear" placeholder="姓名" class="layui-input">
    </div>
    <%--    下拉菜单--%>
    <div class="layui-inline">
        <select name="typeUnit" id="TypeUn">
            <option value="">请选择单位</option>
        </select>
    </div>
    <div class="layui-inline">
        <select name="typeRole" id="TypeOp">
            <option value="">请选择身份</option>
        </select>
    </div>
    <%--    日期时间选择器--%>
    <div class="layui-inline">
        <input type="text" name="createTime" class="layui-input" id="createTime" placeholder="开始时间">
    </div>
    <div class="layui-inline">
        <input type="text" name="updateTime" class="layui-input" id="updateTime" placeholder="结束时间">
    </div>
    <%--    按钮--%>
    <div class="layui-inline">
        <button class="layui-btn" lay-submit lay-filter="formDemo">查询</button>
        <button type="reset" class="layui-btn layui-btn-primary">重置</button>
    </div>
</form>

<table class="layui-hide" id="blogTable" lay-filter="test"></table>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="empower">授权</a>
</script>
<script type="text/html" id="toolbarDemo">
    <button class="layui-btn layui-bg-red layui-btn-radius layui-btn-sm" lay-event="DelAll"><i class="layui-icon layui-icon-delete"></i></button>
</script>

<script type="text/html" id="imgURL">
    <img src="/lic/{{d.image}}"/>
</script>

</body>
</html>
<script>
    layui.use(['table', 'form', 'laydate'], function (){
        var table = layui.table;
        var form = layui.form;
        var laydate = layui.laydate;

        table.render({
            elem: '#blogTable',
            url: '/BorrowCard?method=selPage',
            page: true,
            toolbar: "#toolbarDemo",
            cols: [[
                {type: 'checkbox', fixed: 'left'},
                {field:'borrowCardNum', width:120, fixed: 'left', title: 'ID'},
                {field:'name', width:150, title: '姓名'},
                {field:'image', width:150, title: '头像', templet: '#imgURL'},
                {field:'unitName', width:160, title: '单位'},
                {field:'roleName', width:150, title: '身份'},
                {field:'status', width:120, title: '状态', templet: function (d) {
                        switch (d.status){
                            case 1:
                                color = 'green'; // 未借阅 - 绿色
                                return '<span style="color:' + color + '">未借阅</span>';
                            case 2:
                                color = 'blue'; // 已借阅/未逾期 - 蓝色
                                return '<span style="color:' + color + '">已借阅/未逾期</span>';
                            case 3:
                                color = 'red'; // 已借阅/已逾期 - 红色
                                return '<span style="color:' + color + '">已借阅/已逾期</span>';
                            default:
                                return '<span>未知状态</span>';
                        }
                    }},
                {field:'permission', width:120, title: '借书权限', templet: function (d) {
                        var all = d.permission + ' 本'
                        return all;
                    }},
                {field:'borrowedBooksNum', width:120, title: '借书数量'},
                {field:'creditScore', width:120, title: '信誉'},
                {field:'createTime', width:160, title: '创建时间'},
                {fixed: 'right', width: 100, field: 'adminStatus', title: '授权状态', templet: function (d) {
                        if (d.adminStatus == 1){
                            return '<span style="color: blue"><i class="layui-icon layui-icon-auz"/>已授权</span>'
                        }else {
                            return '<span style="color: green"><i class="layui-icon layui-icon-auz"/>未授权</span>'
                        }
                    }},
                {fixed: 'right', width: 170, title: '操作', toolbar: '#barDemo'}

            ]]
        })

        table.on('tool(test)', function (obj){
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            if (layEvent === 'del'){
                myLayui.inquiry('删除', '你确定要删除吗？', function (){
                    console.log(data.id)
                    $.ajax({
                        url: "/BorrowCard?method=del",
                        data: {'id': data.id},
                        type: 'post',
                        dataType: 'json',
                        success: function (obj){
                            console.log(obj)
                            if (obj == true){
                                myLayui.message('删除成功', 1)
                            }else {
                                myLayui.message('删除失败', 2)
                            }
                            table.reload('blogTable')
                        }
                    })
                })
            }

            if (layEvent == 'edit'){
                myLayui.inquiry('编辑', '你确定要编辑吗？', function (){
                    myLayui.pageIframe('编辑', '/page//Admin/update/user?id='+data.id, '70%', '80%')
                })
            }

            if (layEvent == 'empower'){
                myLayui.inquiry('授权', '你确定要授权吗？', function (){
                    // console.log(data)
                    $.ajax({
                        url: "/Admin?method=add",
                        data: {'id': data.borrowCardNum},
                        type: 'post',
                        dataType: 'json',
                        success: function (obj){
                            if (obj == true){
                                myLayui.message('授权成功', 1)
                            }else {
                                myLayui.message('授权失败', 2)
                            }
                            table.reload('blogTable')
                        }
                    })
                })
            }
        })

        table.on('toolbar(test)', function(obj){
            var data = obj.data;
            var layEvent = obj.event;
            var id = obj.config.id; // 获取表格的 ID
            var checkStatus = table.checkStatus(id); // 获取表格的选中状态
            // var othis = lay(this); 原本用于获取当前触发事件的 DOM 元素
            switch(layEvent){
                case 'DelAll':
                    var data = checkStatus.data;
                    var ids = new Array()
                    $(data).each(function (){
                        ids.push(this.id)
                    })
                    myLayui.inquiry('删除', '你确定要删除吗？', function (obj) {
                        $.ajax({
                            url: '/BorrowCard?method=delAll',
                            type: 'post',
                            data: {'ids': ids},
                            dataType: 'json',
                            success: function (obj){
                                if (obj == true){
                                    myLayui.message('删除成功', 1)
                                }else {
                                    myLayui.message('删除失败', 2)
                                }
                                table.reload('blogTable')
                            }
                        })
                    })
                    break;
            }
        })

        form.on('submit(formDemo)', function (data){
            var data = data.field
            console.log(data)
            table.reload('blogTable', {
                page: {
                    curr: 1
                },
                where: data
            })
            return false
        })

        // 下拉列表
        $.ajax({
            url: '/Role?method=selAll',
            type: 'get',
            dataType: 'json',
            success: function (obj){
                var select = $('#TypeOp');
                $(obj).each(function (){
                    var _this = $(this);
                    var name = _this.attr("name")

                    if (name === '管理员'){
                        return; // 跳过'管理员'项
                    }

                    var option = $('<option>', {text: _this.attr("name"), val: _this.attr("id")});
                    select.append(option)
                })
                form.render('select')
            }
        });

        $.ajax({
            url: '/Department?method=selAll',
            type: 'get',
            dataType: 'json',
            success: function (obj){
                var select = $('#TypeUn');
                $(obj).each(function (){
                    var _this = $(this);
                    var name = _this.attr("name");

                    if (name === '图书馆') {
                        return; // 跳过'图书馆'项
                    }

                    var option = $('<option>', {text: _this.attr("name"), val: _this.attr("id")});
                    select.append(option);
                })
                form.render('select')
            }
        });

        // 日期时间选择器 - 日期和时间选择器同时显示（全面板）
        laydate.render({
            elem: '#createTime',
            type: 'datetime',
            fullPanel: true, // 是否开启全面板
            format: 'yyyy-MM-dd HH:mm:ss'
        });

        laydate.render({
            elem: '#updateTime',
            type: 'datetime',
            fullPanel: true, // 是否开启全面板
            format: 'yyyy-MM-dd HH:mm:ss'
        });

    })
</script>