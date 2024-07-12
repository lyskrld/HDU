<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>鲜花信息首页</title>
    <style>
        /* 设置页面背景颜色和字体 */
        body {
            background-color: #ffe6f2;
            font-family: Arial, sans-serif;
            color: #333;
        }
        /* 设置标题颜色 */
        h1 {
            color: #ff1493;
        }
        /* 设置表单样式，包括背景色、边框、阴影等 */
        form {
            background-color: #fff0f5;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin: auto;
            width: 80%;
        }
        /* 设置按钮的样式，包括背景色、边框、文字颜色等 */
        input[type="button"], input[type="submit"] {
            background-color: #ff69b4;
            border: none;
            color: white;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 4px 2px;
            cursor: pointer;
            border-radius: 5px;
        }
        /* 设置文本框的样式，包括宽度、边框、内边距等 */
        input[type="text"] {
            width: 60%;
            padding: 10px;
            margin: 10px 0;
            box-sizing: border-box;
            border: 2px solid #ff1493;
            border-radius: 5px;
        }
        /* 设置表格样式，包括宽度、边框等 */
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        /* 设置表头和单元格的样式 */
        th, td {
            border: 1px solid #ff1493;
            padding: 10px;
            text-align: center;
        }
        /* 设置表头背景颜色和文字颜色 */
        th {
            background-color: #ffb6c1;
            color: white;
        }
        /* 设置单元格背景颜色 */
        td {
            background-color: #fff0f5;
        }
        /* 设置偶数行的背景颜色 */
        tr:nth-child(even) {
            background-color: #ffe4e1;
        }
        /* 设置操作按钮的样式，使其垂直排列 */
        .operation-buttons {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
    </style>
    <script>
        function confirmDelete(flonum) {
            if (confirm("确认要删除这条记录吗？")) {
                document.getElementById('delete_flonum').value = flonum;
                document.forms['indexf'].submit();
            }
        }
    </script>
</head>

<body>
<!-- 页面标题 -->
<h1 align="center">鲜花信息</h1>
<!-- 表单开始 -->
<form action="" method="post" name="indexf">
    <!-- 新增按钮 -->
    <p align="center">
        <input type="button" value="新增" name="inbut" onClick="location.href='insert_flo.php'" />
    </p>
    <!-- 搜索框和搜索按钮 -->
    <p align="center">
        <input type="text" name="sel" />
        <input type="submit" value="搜索" name="selsub" />
    </p>
    <!-- 数据表格 -->
    <table align="center">
        <tr>
            <th>鲜花编号</th><th>鲜花名称</th>
            <th>鲜花颜色</th><th>鲜花单位</th>
            <th>鲜花单价</th><th>仓库编号</th>
            <th>鲜花数量</th><th>操作</th>
        </tr>
        <?php
        // 引入数据库连接类
        require_once ('gauss_class.php');
        // 数据库连接信息
        $host        = "120.46.144.222";
        $user        = "liuhongkun";
        $port        = "26000";
        $dbname      = "flowershop";
        $password = "liuhongkun+123";
        // 创建数据库连接
        $opengauss = new gauss($host,$user,$password,$dbname,$port);
        if(!$opengauss){
            exit('数据库连接失败！');
        }

        // 检查是否提交了删除请求
        if (!empty($_POST["delete_flonum"])) {
            $delete_flonum = $_POST["delete_flonum"];
            $opengauss->query("DELETE FROM flower WHERE flonum='$delete_flonum'");
        }

        // 判断是否提交了搜索表单
        if (empty($_POST["selsub"]) || empty($_POST["sel"])) {
            // 如果没有提交搜索表单，展示全部数据
            $res = $opengauss->query("select * from flower order by flonum");
        }
        else{
            // 按搜索条件搜索
            $sel = $_POST["sel"];
            $res = $opengauss->query("select * from flower where flonum like '%$sel%' or floname like '%$sel%' or unit like '%$sel%' or color like '%$sel%' or price like '%$sel%' or warenum like '%$sel%'");
        }
        // 遍历查询结果，生成表格行
        while ($row = pg_fetch_row($res)){
            echo '<tr>';
            echo "<td>$row[0]</td><td>$row[1]</td><td>$row[2]</td><td>$row[3]</td>
              <td>$row[4]</td><td>$row[5]</td><td>$row[6]</td>
              <td>
              <div class='operation-buttons'>
                  <input type='button' value='修改' onClick=\"location.href='update_flo.php?flonum=$row[0]'\" />
                  <input type='button' value='删除' onClick=\"confirmDelete('$row[0]')\" />
              </div>
              </td>
              ";
            echo '</tr>';
        }
        ?>
        <!-- 隐藏字段，用于传递删除的鲜花编号 -->
        <input type="hidden" id="delete_flonum" name="delete_flonum" value="" />
    </table>
</form>
</body>
</html>
