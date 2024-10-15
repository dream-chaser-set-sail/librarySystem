var indexJs = {
    // 时间
    time(){
        // 创建一个新的 Date 对象，now 变量将存储当前的日期和时间。
        var now = new Date();

        // 定义一个对象 options，用于指定日期时间的格式：

        /*
        * year: 'numeric': 年份以数值形式显示（如：2024）。
          month: 'long': 月份以长格式显示（如：八月）。
          day: 'numeric': 日期以数值形式显示（如：16）。
          hour: '2-digit': 小时以两位数形式显示（如：01, 02...）。
          minute: '2-digit': 分钟以两位数形式显示。
          second: '2-digit': 秒以两位数形式显示。
          hour12: false : 使用24小时。
        */
        var options = {
            year:'numeric',
            month:'long',
            day:'numeric',
            hour:'2-digit',
            minute: '2-digit',
            second: '2-digit',
            hour12: false,
        };

        // 使用 toLocaleString 方法，将 now 转换为当地格式的日期时间字符串。'zh-CN' 指定了使用中文（中国）的格式。
        var formData = now.toLocaleString('zh-CN', options)

        // 通过 ID 获取之前创建的 div，并将格式化后的日期时间字符串设置为该 div 的文本内容，从而在网页上显示当前的日期和时间。
        document.getElementById('time').textContent = formData;

        // 每秒更新一次日期和时间
        setInterval(indexJs.time, 1000);
        // setInterval(this.time, 1000);
    },

    // 头部分搜素框提交
    setupEnterSubmit: function(inputId) {
        // addEventListener:创建一个监听器
        document.getElementById(inputId).addEventListener('keydown', function(event) {
            if (event.key === 'Enter') {
                event.preventDefault(); // 防止表单默认提交
                // 获取输入框的值
                let input = this.value;
                console.log(input)
                nameBook = input
                stackJs.books(1, input)
            }
        });
    },

    // 点击用户名 || 头像出现下拉列表
    pullDownlist(triggerSelectors, dropdownSelector){
        $(triggerSelectors).click(function (event){
            $('#user-list').css('display','block')
            event.stopPropagation();  // 阻止事件冒泡
        })

        $(document).click(function() {
            if ($(dropdownSelector).is(':visible')) {
                $(dropdownSelector).hide();  // 点击其他地方隐藏下拉列表
            }
        });

        $(dropdownSelector).click(function (event){
            event.stopPropagation();  // 阻止事件冒泡
        })
    },

    filtrateBtn(status, bookNum, permission, credit){
        // status 状态
        // bookNum 借书数量
        // permission 允许借书数
        // credit 信誉
        switch (status){
            case 1:
                $('#isStatus1').css('display','block')
                break;
            case 2:
                $('#isStatus2').css('display','block')
                if (permission <= bookNum){
                    $('#isBooknum1').css('display','block')
                }else {
                    $('#isBooknum0').css('display','block')
                }
                break;
            case 3:
                $('#isStatus3').css('display','block')
                if (credit >= 50){
                    $('#isCredit0').css('display','block')
                    if (permission <= bookNum){
                        $('#isbookNum_iscredit1').css('display','block')
                    }else {
                        $('#isbookNum_iscredit0').css('display','block')
                    }
                }else {
                    $('#isCredit1').css('display','block')
                }
                break
        }
    },

    // 判断输入字体为中文/英文
    detectInputType(text,id){
        // 正则表达式检查汉字
        const isChinese = /[\u4e00-\u9fa5]/.test(text);

        // 正则表达式检查英文字母
        const isEnglish = /^[a-zA-Z\s]*$/.test(text);

        // 正则表达式检查数字
        const isNumber = /^-?\d+$/.test(text);

        if (isChinese) {
            console.log('输入的是汉字')
            $(id).css('font-family','抬头数点点繁星')
        } else if (isEnglish) {
            console.log('输入的是英语')
            $(id).css('font-family','Denistina')
        } else if (isNumber){
            console.log('输入的是数字')
            $(id).css('font-family','Denistina')
        }else {
            console.log('输入的是其他字符')
        }
    },

    //检测输入框是否为中文等...
    testInput(id){
        // input propertychange 用于监听输入框变化的
        $(id).on('input propertychange', function (){
            //用于跟踪上一次输入框的值
            let previousValue = '';
            if ($(this).val() != ''){
                var text = $(this).val();
                var newChar = text.slice(-1); // 获取新输入的字符
                if (text.length > previousValue.length){
                    indexJs.detectInputType(newChar, '#name')
                }
                previousValue = text // 更新之前的值
            }else {}

        })
    },

    //上传图片
    uploads(fid, pid, nid){
        // 监听文件选择事件
        $(fid).on('change', function(event) {
            // 获取文件对象
            const file = event.target.files[0];
            if (file) {
                // 创建FileReader对象
                const reader = new FileReader();

                // 文件读取完成后的回调
                reader.onload = function(e) {
                    // 创建图片元素
                    const img = $('<img>').attr('src', e.target.result);
                    // 清空预览区域
                    $(pid).empty();
                    // 将图片添加到预览区域
                    $(pid).append(img);
                };

                // 读取文件内容为Data URL
                reader.readAsDataURL(file);

                // 上传图片
                const formData = new FormData(); // 创建一个包含文件数据的 FormData 对象
                formData.append('file', file);

                $.ajax({
                    url: '/upload', // 上传接口地址
                    type: 'POST',
                    data: formData,
                    dataType: 'json',

                    // contentType: false 和 processData: false 用于发送FormData对象，以确保数据不会被自动处理或编码
                    contentType: false,
                    processData: false,

                    success: function(obj) {
                        // console.log(obj)
                        if (obj.result == true){
                            myLayui.message("上传成功", 1)
                            $(nid).val(obj.imgName)
                        }else {
                            myLayui.message("上传失败", 2)
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error('上传失败:', status, error);
                    }
                });
            }
        });
    },

    // 查询下拉列表数据
    selDownList(url, sid){
        $.ajax({
          url: url,
          dataType: 'json',
          type: 'post',
          success: function (obj){
            console.log(obj)
            $(obj).each(function (){
                if (this.name == '管理员' || this.name == '图书馆'){
                    return
                }
              var option = $('<option>', {val: this.id, text: this.name})
              $(sid).append(option)
            })
          }
        })
    },

    // 刷新验证码图片
    BrushverifyCode(imgId){
        // '/verifyCode?' + `new Date().getTime()`
        // 时间戳的作用是防止浏览器缓存图片。每次点击时，时间戳确保 URL 唯一，从而迫使浏览器重新加载最新的图片资源，而不是使用缓存中的旧图片。
        $(imgId).attr('src', '/verifyCode?' + new Date().getTime())
    },

    // 是否是管理员账号
    isAdminBorrowCardNum(cid){
        var card = $(cid).val()
        $.ajax({
            url: '/BorrowCard?method=selAdminCardNum',
            type: 'post',
            data: {'cardNum': card},
            dataType: 'json',
            success: function (obj){
                console.log(obj)
                if (obj == true){
                    $('#password').css('display', 'block')
                }else {
                    $('#password').css('display', 'none')
                }
            }
        })
    },

    // 好书推荐
    goodBook(){
        $.ajax({
            url: '/Book?method=selTop',
            type: 'get',
            dataType: 'json',
            success: function (obj) {
                for (var i = 0; i < obj.length; i++) {
                    var imgPath = '/lic/' + obj[i].image;
                    $("#img" + (i + 1)).attr('href', '/page/particularBook?isbn='+obj[i].isbn+'&type=0');
                    $("#img" + (i + 1)).find('img').attr('src', imgPath);
                }
            }
        })
    },

    // 热门书籍
    hotBook(){
        $.ajax({
            url: '/Book?method=selClick',
            type: 'get',
            dataType: 'json',
            success: function (obj){
                for (let i = 0; i < obj.length; i++) {
                    $('#hot-book .hotBook-frame:eq('+i+') img').attr('src', '/lic/'+obj[i].image)
                    $('#hot-book .hotBook-frame:eq('+i+') a').attr('href', '/page/particularBook?isbn='+obj[i].isbn+'&type=0')
                    $('#hot-book .hotBook-frame:eq('+i+') .hot-book-text').text(obj[i].name)
                }
            }
        })
    },
}
