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
    <title>修改书籍</title>
    <link rel="stylesheet" href="/static/layui/css/layui.css">
    <script src="/static/layui/layui.js"></script>
    <script src="/static/js/jquery-2.1.4.js"></script>
    <script src="/static/js/myLayui.js"></script>
</head>
<body>

<form class="layui-form" lay-filter="formFilter" action="" id="sel">
    <div class="layui-form-item">
        <label class="layui-form-label">书名</label>
        <div class="layui-input-block" style="margin-top: 10px; margin-bottom: 10px">
            <input type="hidden" id="Bid" name="id">
            <input type="text" id="name" name="name" required  lay-verify="required" placeholder="请输入内容" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">作者</label>
        <div class="layui-input-block" style="margin-top: 10px; margin-bottom: 10px">
            <input type="text" id="author" name="author" required  lay-verify="required" placeholder="请输入内容" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">简介</label>
        <div class="layui-input-block" style="margin-top: 10px; margin-bottom: 10px">
            <input type="text" id="synopsis" name="synopsis" required  lay-verify="required" placeholder="请输入内容" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">出版社</label>
        <div class="layui-input-block" style="margin-top: 10px; margin-bottom: 10px">
            <input type="text" id="publishingHouse" name="publishingHouse" required  lay-verify="required" placeholder="请输入内容" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">价格</label>
        <div class="layui-input-block" style="margin-top: 10px; margin-bottom: 10px">
            <input type="text" id="price" name="price" required  lay-verify="required" placeholder="请输入内容" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">数量</label>
        <div class="layui-input-block" style="margin-top: 10px; margin-bottom: 10px">
            <input type="text" id="amount" name="amount" required  lay-verify="required" placeholder="请输入内容" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">封面</label>
        <div class="layui-input-block">
            <div class="layui-upload-list">
                <input type="hidden" name="image" id="imageId">
                <img class="layui-upload-img" id="ID-upload-demo-img" width="150px" height="150px">
                <div id="ID-upload-demo-text"></div>
            </div>
            <button type="button" class="layui-btn" id="uploadId">
                <i class="layui-icon layui-icon-upload"></i> 单图片上传
            </button>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">书籍分类</label>
        <div class="layui-input-block">
            <select name="bookType" id="TypeUp">
                <option value="0">请选择标签</option>
            </select>
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
        var upload = layui.upload;

        $.ajax({
            url: '/Book?method=selOwn',
            data: {'id' : id},
            dataType: 'json',
            type: 'get',
            success: function (obj){
                var UnitId = null
                console.log(obj)
                $(obj).each(function (){
                    var _this = $(this);
                    $('.layui-form-item:eq(0) div input').val(_this.attr('name'))
                    $('.layui-form-item:eq(1) div input').val(_this.attr('author'))
                    $('.layui-form-item:eq(2) div input').val(_this.attr('synopsis'))
                    $('.layui-form-item:eq(3) div input').val(_this.attr('publishingHouse'))
                    $('.layui-form-item:eq(4) div input').val(_this.attr('price'))
                    $('.layui-form-item:eq(5) div input').val(_this.attr('amount'))
                    $('#ID-upload-demo-img').attr('src', '/lic/'+this.image)
                    UnitId = _this.attr('bookType')
                    $('#imageId').val(this.image)
                    $('#Bid').val(id)
                })

                //下拉列表
                $.ajax({
                    url: '/BookClassify?method=selAll',
                    type: 'get',
                    dataType: 'json',
                    success: function (obj){
                        var select = $('#TypeUp');
                        $(obj).each(function (){
                            var _this = $(this);
                            var option = $('<option>', {text: _this.attr("name"), val: _this.attr("id")});
                            select.append(option)
                            select.val(UnitId)
                        })
                        form.render('select')
                    }
                })
            }
        })

        form.on('submit(formDemo)', function (data){
            var Data = data.field;
            console.log(Data)
            $.ajax({
                url: '/Book?method=update',
                data: Data,
                type: 'post',
                dataType: 'json',
                success: function (obj){
                    console.log(obj)
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

        // 图片上传
        var uploadInst = upload.render({
            elem: '#uploadId',
            url: '/upload', // 实际使用时改成您自己的上传接口即可。
            before: function(obj){
                // 预读本地文件示例，不支持ie8
                obj.preview(function(index, file, result){
                    $('#ID-upload-demo-img').attr('src', result); // 图片链接（base64）
                });
            },
            done: function(obj){
                $('#imageId').val(obj.imgName)
                if (obj.result == true){
                    myLayui.message('图片上传成功', 1)
                }else {
                    myLayui.message('图片上传失败', 2)
                }

                $('#ID-upload-demo-text').html(''); // 置空上传失败的状态
            },
            error: function(){
                // 演示失败状态，并实现重传
                var demoText = $('#ID-upload-demo-text');
                demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-xs demo-reload">重试</a>');
                demoText.find('.demo-reload').on('click', function(){
                    uploadInst.upload();
                });
            },
        });

    })
</script>
