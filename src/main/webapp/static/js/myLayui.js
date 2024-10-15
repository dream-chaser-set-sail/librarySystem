var myLayui = {
    // 询问框
    inquiry(title, text, ajax){
        layer.confirm(text, {
            title: title,
            btn: ['确定' , '取消']
        }, function (){
            ajax();
        })
    },

    //页面层
    pageIframe(title, url, width, height){
        layer.open({
            type: 2,
            title: title,
            shadeClose: true,
            shade: 0.8,
            area: [width, height],
            content: url// iframe 的 url
        });
    },

    //消息框
    message(text, num){
        switch (num){
            case 0:
                layer.msg(text, {icon: 0}, 500);
                break
            case 1:
                layer.msg(text, {icon: 1}, 500);
                break
            case 2:
                layer.msg(text, {icon: 2}, 500);
                break
        }
    },



    //页面层
    pageFloor(width, height, title, HtmlText){
        layer.open({
            type: 1,
            title: title,
            skin: 'layui-layer-rim', //加上边框
            area: [width, height], //宽高
            content: HtmlText
        });
    }
}
