<%--
  Created by IntelliJ IDEA.
  User: Dell
  Date: 2024/9/16
  Time: 11:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>书籍管理</title>
    <link rel="stylesheet" href="/static/layui/css/layui.css">
    <link rel="stylesheet" href="/static/css/system.css">
    <script src="/static/js/jquery-2.1.4.js"></script>
    <script src="/static/layui/layui.js"></script>
    <script src="/static/js/myLayui.js"></script>
</head>
<body>
<form class="layui-form">
    <div class="layui-inline">
        <input type="text" name="name" lay-affix="clear" placeholder="书名" class="layui-input">
    </div>
    <%--    下拉菜单--%>
    <div class="layui-inline">
        <select name="typeUnit" id="TypeUn">
            <option value="">请选择书籍分类</option>
        </select>
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
</script>
<script type="text/html" id="toolbarDemo">
    <button class="layui-btn layui-bg-blue layui-btn-radius layui-btn-sm" lay-event="Add"><i class="layui-icon layui-icon-edit"></i></button>
    <button class="layui-btn layui-bg-red layui-btn-radius layui-btn-sm" lay-event="DelAll"><i class="layui-icon layui-icon-delete"></i></button>
    <button class="layui-btn layui-bg-green layui-btn-radius layui-btn-sm" lay-event="Download"><i class="layui-icon layui-icon-export"></i></button>
    <button class="layui-btn layui-bg-orange layui-btn-radius layui-btn-sm" lay-event="Upload"><i class="layui-icon layui-icon-upload"></i></button>
</script>

<script type="text/html" id="imgURL">
    <img src="/lic/{{d.image}}"/>
</script>

<script type="text/html" id="Top">
    <input type="checkbox" name="status" value="{{= d.id }}" title="置顶|未置顶"
           lay-skin="switch" lay-filter="istop" {{= d.ontop == 1 ? "checked" : "" }}>
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
            url: '/Book?method=selPage',
            page: true,
            toolbar: "#toolbarDemo",
            cols: [[
                {type: 'checkbox', fixed: 'left'},
                {field:'isbn', width:120, fixed: 'left', title: '书号'},
                {field:'name', width:150, title: '书名'},
                {field:'synopsis', width:150, title: '简介'},
                {field:'author', width:150, title: '作者'},
                {field:'publishingHouse', width:150, title: '出版社'},
                {field:'bookTypeName', width:150, title: '书籍分类'},
                {field:'image', width:150, title: '封面', templet: '#imgURL'},
                {field:'price', width:160, title: '价格', templet: function (d) {
                        return d.price + '元 / 本'
                    }},
                {field:'amount', width:150, title: '数量', templet: function (d) {
                        return d.amount + ' 本'
                    }},
                {field:'ontop', width:90, title: '置顶', templet: function (d) {
                        if (d.ontop == 0){
                            return '<span style="color: green;">未置顶</span>'
                        }else if (d.ontop == 1){
                            return '<span style="color: blue;">已置顶</span>'
                        }
                    }},
                {field:'isTop', width:90, title: 'is置顶', templet: '#Top'},
                {field:'createTime', width:160, title: '入库时间'},
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
                        url: "/Book?method=del",
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
                    myLayui.pageIframe('编辑', '/page//Admin/update/book?id='+data.id, '70%', '80%')
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
                case 'Add':
                    myLayui.pageIframe('添加','/page//Admin/add/book','70%','80%')
                    break;
                case 'DelAll':
                    var data = checkStatus.data;
                    var ids = new Array()
                    $(data).each(function (){
                        ids.push(this.id)
                    })
                    myLayui.inquiry('删除', '你确定要删除吗？', function (obj) {
                        $.ajax({
                            url: '/Book?method=delAll',
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
                case 'Download':
                    location.href = '/Book?method=exportExcel'
                    break

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

        // 状态 - 开关操作
        form.on('switch(istop)', function(obj){
            var id = this.value;
            var checked = obj.elem.checked
            var isTop = checked ? 1 : 0

            console.log(id)
            console.log(isTop)
            $.ajax({
                type:'post',
                url:'/Book?method=isTop',
                dataType:'json',
                data:{'isTop':isTop, 'id':id},
                success: function (obj){
                    if (obj == true){
                        myLayui.message('执行成功', 1)
                    }else {
                        myLayui.message('执行失败', 2)
                    }
                    table.reload('blogTable')
                }
            })
        });

        // 下拉列表
        $.ajax({
            url: '/BookClassify?method=selAll',
            type: 'get',
            dataType: 'json',
            success: function (obj){
                var select = $('#TypeUn');
                $(obj).each(function (){
                    var _this = $(this);
                    var option = $('<option>', {text: _this.attr("name"), val: _this.attr("id")});
                    select.append(option)
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