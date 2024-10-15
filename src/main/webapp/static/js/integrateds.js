var integratedJs = {
    thisOneData(){
        layui.use(['table', 'form', 'laydate'], function () {
            var table = layui.table;

            table.render({
                elem: '#departmentTable',
                url: '/Department?method=selPage',
                page: false,
                toolbar: "#toolbarDemo1",
                cols: [[
                    {type: 'checkbox', fixed: 'left'},
                    {field: 'id', title: 'ID'},
                    {field: 'name', title: '名称'},
                    // {fixed: 'right', title: '操作', toolbar: '#barDemo1'}
                ]]
            })

            table.on('tool(test)', function (obj) {
                var data = obj.data; //获得当前行数据
                var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
                if (layEvent === 'del') {
                    myLayui.inquiry('删除', '你确定要删除吗？', function () {
                        console.log(data.id)
                        $.ajax({
                            url: "/Department?method=del",
                            data: {'id': data.id},
                            type: 'post',
                            dataType: 'json',
                            success: function (obj) {
                                console.log(obj)
                                if (obj == true) {
                                    myLayui.message('删除成功', 1)
                                } else {
                                    myLayui.message('删除失败', 2)
                                }
                                table.reload('departmentTable')
                            }
                        })
                    })
                }

                if (layEvent == 'edit') {
                    myLayui.inquiry('编辑', '你确定要编辑吗？', function () {
                        myLayui.pageIframe('编辑', '/page//Admin/update/department?id=' + data.id, '70%', '30%')
                    })
                }
            })

            table.on('toolbar(test)', function (obj) {
                var data = obj.data;
                var layEvent = obj.event;
                var id = obj.config.id; // 获取表格的 ID
                var checkStatus = table.checkStatus(id); // 获取表格的选中状态
                // var othis = lay(this); 原本用于获取当前触发事件的 DOM 元素
                switch (layEvent) {
                    case 'Add':
                        myLayui.pageIframe('添加', '/page//Admin/add/department', '70%', '30%')
                        break;
                    case 'DelAll':
                        var data = checkStatus.data;
                        var ids = new Array()
                        $(data).each(function () {
                            ids.push(this.id)
                        })
                        myLayui.inquiry('删除', '你确定要删除吗？', function (obj) {
                            $.ajax({
                                url: '/Department?method=delAll',
                                type: 'post',
                                data: {'ids': ids},
                                dataType: 'json',
                                success: function (obj) {
                                    if (obj == true) {
                                        myLayui.message('删除成功', 1)
                                    } else {
                                        myLayui.message('删除失败', 2)
                                    }
                                    table.reload('departmentTable')
                                }
                            })
                        })
                        break;
                }
            })
        })
    },

    thisTwoData(){
        layui.use(['table', 'form', 'laydate'], function () {
            var table = layui.table;

            table.render({
                elem: '#RoleTable',
                url: '/Role?method=selPage',
                page: false,
                toolbar: "#toolbarDemo2",
                cols: [[
                    {type: 'checkbox', fixed: 'left'},
                    {field: 'id', title: 'ID'},
                    {field: 'name', title: '名称'},
                    {fixed: 'right', title: '操作', toolbar: '#barDemo2'}
                ]]
            })

            table.on('tool(test)', function (obj) {
                var data = obj.data; //获得当前行数据
                var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
                if (layEvent === 'del') {
                    myLayui.inquiry('删除', '你确定要删除吗？', function () {
                        console.log(data.id)
                        $.ajax({
                            url: "/Role?method=del",
                            data: {'id': data.id},
                            type: 'post',
                            dataType: 'json',
                            success: function (obj) {
                                console.log(obj)
                                if (obj == true) {
                                    myLayui.message('删除成功', 1)
                                } else {
                                    myLayui.message('删除失败', 2)
                                }
                                table.reload('RoleTable')
                            }
                        })
                    })
                }

                if (layEvent == 'edit') {
                    myLayui.inquiry('编辑', '你确定要编辑吗？', function () {
                        myLayui.pageIframe('编辑', '/page//Admin/update/role?id=' + data.id, '70%', '30%')
                    })
                }
            })

            table.on('toolbar(test)', function (obj) {
                var data = obj.data;
                var layEvent = obj.event;
                var id = obj.config.id; // 获取表格的 ID
                var checkStatus = table.checkStatus(id); // 获取表格的选中状态
                // var othis = lay(this); 原本用于获取当前触发事件的 DOM 元素
                switch (layEvent) {
                    case 'Add':
                        myLayui.pageIframe('添加', '/page//Admin/add/role', '70%', '30%')
                        break;
                    case 'DelAll':
                        var data = checkStatus.data;
                        var ids = new Array()
                        $(data).each(function () {
                            ids.push(this.id)
                        })
                        myLayui.inquiry('删除', '你确定要删除吗？', function (obj) {
                            $.ajax({
                                url: '/Role?method=delAll',
                                type: 'post',
                                data: {'ids': ids},
                                dataType: 'json',
                                success: function (obj) {
                                    if (obj == true) {
                                        myLayui.message('删除成功', 1)
                                    } else {
                                        myLayui.message('删除失败', 2)
                                    }
                                    table.reload('RoleTable')
                                }
                            })
                        })
                        break;
                }
            })
        })
    },

    thisThreeData(){
        layui.use(['table', 'form', 'laydate'], function () {
            var table = layui.table;

            table.render({
                elem: '#ClassifyTable',
                url: '/BookClassify?method=selPage',
                page: false,
                toolbar: "#toolbarDemo3",
                cols: [[
                    {type: 'checkbox', fixed: 'left'},
                    {field: 'id', title: 'ID'},
                    {field: 'name', title: '名称'},
                    {fixed: 'right', title: '操作', toolbar: '#barDemo3'}
                ]]
            })

            table.on('tool(test)', function (obj) {
                var data = obj.data; //获得当前行数据
                var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
                if (layEvent === 'del') {
                    myLayui.inquiry('删除', '你确定要删除吗？', function () {
                        console.log(data.id)
                        $.ajax({
                            url: "/BookClassify?method=del",
                            data: {'id': data.id},
                            type: 'post',
                            dataType: 'json',
                            success: function (obj) {
                                console.log(obj)
                                if (obj == true) {
                                    myLayui.message('删除成功', 1)
                                } else {
                                    myLayui.message('删除失败', 2)
                                }
                                table.reload('ClassifyTable')
                            }
                        })
                    })
                }

                if (layEvent == 'edit') {
                    myLayui.inquiry('编辑', '你确定要编辑吗？', function () {
                        myLayui.pageIframe('编辑', '/page//Admin/update/classify?id=' + data.id, '70%', '30%')
                    })
                }
            })

            table.on('toolbar(test)', function (obj) {
                var data = obj.data;
                var layEvent = obj.event;
                var id = obj.config.id; // 获取表格的 ID
                var checkStatus = table.checkStatus(id); // 获取表格的选中状态
                // var othis = lay(this); 原本用于获取当前触发事件的 DOM 元素
                switch (layEvent) {
                    case 'Add':
                        myLayui.pageIframe('添加', '/page//Admin/add/classify', '70%', '30%')
                        break;
                    case 'DelAll':
                        var data = checkStatus.data;
                        var ids = new Array()
                        $(data).each(function () {
                            ids.push(this.id)
                        })
                        myLayui.inquiry('删除', '你确定要删除吗？', function (obj) {
                            $.ajax({
                                url: '/BookClassify?method=delAll',
                                type: 'post',
                                data: {'ids': ids},
                                dataType: 'json',
                                success: function (obj) {
                                    if (obj == true) {
                                        myLayui.message('删除成功', 1)
                                    } else {
                                        myLayui.message('删除失败', 2)
                                    }
                                    table.reload('ClassifyTable')
                                }
                            })
                        })
                        break;
                }
            })
        })
    },

    thisFourData(){
        layui.use(['table', 'form', 'laydate'], function () {
            var table = layui.table;

            table.render({
                elem: '#StatusTable',
                url: '/Status?method=selPage',
                page: false,
                toolbar: "#toolbarDemo4",
                cols: [[
                    {type: 'checkbox', fixed: 'left'},
                    {field: 'id', title: 'ID'},
                    {field: 'name', title: '名称'},
                    {fixed: 'right', title: '操作', toolbar: '#barDemo4'}
                ]]
            })

            table.on('tool(test)', function (obj) {
                var data = obj.data; //获得当前行数据
                var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
                if (layEvent === 'del') {
                    myLayui.inquiry('删除', '你确定要删除吗？', function () {
                        console.log(data.id)
                        $.ajax({
                            url: "/Status?method=del",
                            data: {'id': data.id},
                            type: 'post',
                            dataType: 'json',
                            success: function (obj) {
                                console.log(obj)
                                if (obj == true) {
                                    myLayui.message('删除成功', 1)
                                } else {
                                    myLayui.message('删除失败', 2)
                                }
                                table.reload('StatusTable')
                            }
                        })
                    })
                }

                if (layEvent == 'edit') {
                    myLayui.inquiry('编辑', '你确定要编辑吗？', function () {
                        myLayui.pageIframe('编辑', '/page//Admin/update/status?id=' + data.id, '70%', '30%')
                    })
                }
            })

            table.on('toolbar(test)', function (obj) {
                var data = obj.data;
                var layEvent = obj.event;
                var id = obj.config.id; // 获取表格的 ID
                var checkStatus = table.checkStatus(id); // 获取表格的选中状态
                // var othis = lay(this); 原本用于获取当前触发事件的 DOM 元素
                switch (layEvent) {
                    case 'Add':
                        myLayui.pageIframe('添加', '/page//Admin/add/status', '70%', '30%')
                        break;
                    case 'DelAll':
                        var data = checkStatus.data;
                        var ids = new Array()
                        $(data).each(function () {
                            ids.push(this.id)
                        })
                        myLayui.inquiry('删除', '你确定要删除吗？', function (obj) {
                            $.ajax({
                                url: '/Status?method=delAll',
                                type: 'post',
                                data: {'ids': ids},
                                dataType: 'json',
                                success: function (obj) {
                                    if (obj == true) {
                                        myLayui.message('删除成功', 1)
                                    } else {
                                        myLayui.message('删除失败', 2)
                                    }
                                    table.reload('StatusTable')
                                }
                            })
                        })
                        break;
                }
            })
        })
    },

    thisFiveData(){
        layui.use(['table', 'form', 'laydate'], function () {
            var table = layui.table;

            table.render({
                elem: '#CreditTable',
                url: '/Credit?method=selPage',
                page: false,
                toolbar: "#toolbarDemo5",
                cols: [[
                    {type: 'checkbox', fixed: 'left'},
                    {field: 'id', title: 'ID'},
                    {field: 'borrowCardNum', title: '卡号'},
                    {fixed: 'right', title: '操作', toolbar: '#barDemo5'}
                ]]
            })

            table.on('tool(test)', function (obj) {
                var data = obj.data; //获得当前行数据
                var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
                if (layEvent === 'del') {
                    myLayui.inquiry('删除', '你确定要删除吗？', function () {
                        console.log(data.id)
                        $.ajax({
                            url: "/Credit?method=del",
                            data: {'id': data.id},
                            type: 'post',
                            dataType: 'json',
                            success: function (obj) {
                                console.log(obj)
                                if (obj == true) {
                                    myLayui.message('删除成功', 1)
                                } else {
                                    myLayui.message('删除失败', 2)
                                }
                                table.reload('CreditTable')
                            }
                        })
                    })
                }

                if (layEvent == 'edit') {
                    myLayui.inquiry('编辑', '你确定要编辑吗？', function () {
                        myLayui.pageIframe('编辑', '/page//Admin/update/credit?id=' + data.id, '70%', '30%')
                    })
                }
            })

            table.on('toolbar(test)', function (obj) {
                var data = obj.data;
                var layEvent = obj.event;
                var id = obj.config.id; // 获取表格的 ID
                var checkStatus = table.checkStatus(id); // 获取表格的选中状态
                // var othis = lay(this); 原本用于获取当前触发事件的 DOM 元素
                switch (layEvent) {
                    case 'Add':
                        myLayui.pageIframe('添加', '/page//Admin/add/credit', '70%', '30%')
                        break;
                    case 'DelAll':
                        var data = checkStatus.data;
                        var ids = new Array()
                        $(data).each(function () {
                            ids.push(this.id)
                        })
                        myLayui.inquiry('删除', '你确定要删除吗？', function (obj) {
                            $.ajax({
                                url: '/Credit?method=delAll',
                                type: 'post',
                                data: {'ids': ids},
                                dataType: 'json',
                                success: function (obj) {
                                    if (obj == true) {
                                        myLayui.message('删除成功', 1)
                                    } else {
                                        myLayui.message('删除失败', 2)
                                    }
                                    table.reload('CreditTable')
                                }
                            })
                        })
                        break;
                }
            })
        })
    },
}