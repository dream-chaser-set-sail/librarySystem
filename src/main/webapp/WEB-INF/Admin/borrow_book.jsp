<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>借阅管理</title>
    <link rel="stylesheet" href="/static/layui/css/layui.css">
    <link rel="stylesheet" href="/static/css/system.css">
    <script src="/static/js/jquery-2.1.4.js"></script>
    <script src="/static/layui/layui.js"></script>
    <script src="/static/js/myLayui.js"></script>
</head>
<body>
<form class="layui-form">
    <div class="layui-inline">
        <input type="text" name="isbn" lay-affix="clear" placeholder="书号" class="layui-input">
    </div>
    <div class="layui-inline">
        <input type="text" name="borrowCardNum" lay-affix="clear" placeholder="卡号" class="layui-input">
    </div>
    <%--    下拉菜单--%>
    <div class="layui-inline">
        <select name="status" id="TypeUn">
            <option value="">请选择借阅状态</option>
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
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
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
            url: '/BorrowBook?method=selPage',
            page: true,
            toolbar: "#toolbarDemo",
            cols: [[
                {type: 'checkbox', fixed: 'left'},
                {field:'isbn', fixed: 'left', title: '书号'},
                {field:'borrowCardNum', fixed: 'left', title: '卡号'},
                {field:'status', fixed: 'left', title: '状态', templet: function (d) {
                        if (d.status == 2){
                            return '<span style="color:blue;">已借阅</span>'
                        }else if (d.status == 3){
                            return '<span style="color:red;">已逾期</span>'
                        }else if (d.status == 1){
                            return '<span style="color:green;">已归还</span>'
                        }
                    }},
                {field:'createTime', fixed: 'left', title: '借书时间'},
                {field:'endTime', fixed: 'left', title: '还书时间'},
                {fixed: 'right', title: '操作', toolbar: '#barDemo'}
            ]]
        })

        table.on('tool(test)', function (obj){
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            if (layEvent === 'del'){
                myLayui.inquiry('删除', '你确定要删除吗？', function (){
                    console.log(data.id)
                    $.ajax({
                        url: "/BorrowBook?method=del",
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
                            url: '/BorrowBook?method=delAll',
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
            url: '/Status?method=selAll',
            type: 'get',
            dataType: 'json',
            success: function (obj){
                var select = $('#TypeUn');
                $(obj).each(function (){
                    var _this = $(this);

                    if (_this.attr("name") == '未借阅'){
                        return
                    }

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