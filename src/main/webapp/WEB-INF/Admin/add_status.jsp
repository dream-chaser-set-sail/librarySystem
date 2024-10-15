<%--
  Created by IntelliJ IDEA.
  User: Dell
  Date: 2024/9/16
  Time: 22:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>添加状态</title>
    <link rel="stylesheet" href="/static/layui/css/layui.css">
    <script src="/static/layui/layui.js"></script>
    <script src="/static/js/jquery-2.1.4.js"></script>
    <script src="/static/js/myLayui.js"></script>
</head>
<body>

<form class="layui-form" lay-filter="formFilter" action="" id="sel">
    <div class="layui-form-item">
        <label class="layui-form-label">名称</label>
        <div class="layui-input-block" style="margin-top: 10px; margin-bottom: 10px">
            <input type="text" id="name" name="name" required  lay-verify="required" placeholder="请输入内容" autocomplete="off" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit lay-filter="formDemo">立即提交</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </div>
</form>
</body>
</html>
<script>
    layui.use('form', function (){
        var form = layui.form
        form.on('submit(formDemo)', function (data){
            $.ajax({
                url: '/Status?method=add',
                type: 'post',
                data: data.field,
                dataType: 'json',
                success: function (obj){
                    if (obj == true){
                        myLayui.message('添加成功', 1)
                    }else {
                        myLayui.message('添加失败', 2)
                    }
                    setInterval(function () {
                        //关闭弹出层
                        var index = parent.layer.getFrameIndex(window.name);
                        parent.layer.close(index);
                        //刷新父页面
                        window.parent.location.reload();
                    }, 500);
                }
            })
            return false
        });

    })
</script>
