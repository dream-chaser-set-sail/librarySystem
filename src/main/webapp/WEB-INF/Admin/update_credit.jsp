<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>修改黑名单</title>
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
            <input type="hidden" id="Bid" name="id">
            <input type="text" id="name" name="borrowCardNum" required  lay-verify="required" placeholder="请输入内容" autocomplete="off" class="layui-input">
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
    var queryString = window.location.search;
    var urlParams = new URLSearchParams(queryString);
    var id = urlParams.get("id");

    layui.use('form', function (){
        var form = layui.form;

        $.ajax({
            url: '/Credit?method=selOwn',
            data: {'id' : id},
            dataType: 'json',
            type: 'get',
            success: function (obj){
                console.log(obj)
                $(obj).each(function (){
                    var _this = $(this);
                    $('#name').val(_this.attr('borrowCardNum'))
                    $('#Bid').val(id)
                })
            }
        })

        form.on('submit(formDemo)', function (data){
            var Data = data.field;
            console.log(Data.id)
            $.ajax({
                url: '/Credit?method=update',
                data: Data,
                type: 'post',
                dataType: 'json',
                success: function (obj){
                    if (obj == true){
                        myLayui.message('修改成功', 1)
                    }else {
                        myLayui.message('修改失败', 2)
                    }
                    setInterval(function (){
                        //关闭子页面
                        var index = parent.layer.getFrameIndex(window.name)
                        parent.layer.close(index)
                        // 刷新父页面
                        window.parent.location.reload()
                    },1000)
                }
            })
            return false
        })

    })
</script>
