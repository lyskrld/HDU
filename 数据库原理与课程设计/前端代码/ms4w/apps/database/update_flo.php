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

// 初始化修改结果变量
$update_success = null;

// 获取鲜花编号
$flonum = $_GET['flonum'];

// 判断是否提交了修改表单
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $floname = $_POST['floname'];
    $color = $_POST['color'];
    $unit = $_POST['unit'];
    $price = $_POST['price'];
    $warenum = $_POST['warenum'];
    $number = $_POST['number'];

    // 更新鲜花信息
    $result = $opengauss->query("UPDATE flower SET floname='$floname', color='$color', unit='$unit', price='$price', warenum='$warenum', number='$number' WHERE flonum='$flonum'");

    // 检查更新结果
    if ($result) {
        $update_success = true;
    } else {
        $update_success = false;
    }
} else {
    // 获取当前鲜花信息
    $res = $opengauss->query("SELECT * FROM flower WHERE flonum='$flonum'");
    $flower = pg_fetch_assoc($res);
}
?>

<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>修改鲜花信息</title>
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
            width: 100%;
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
        /* 返回首页按钮 */
        .home-button {
            position: fixed;
            top: 10px;
            right: 10px;
        }
    </style>
    <script>
        // 页面加载完成后检查修改结果并弹出提示
        window.onload = function() {
            var updateSuccess = <?php echo json_encode($update_success); ?>;
            if (updateSuccess !== null) {
                if (updateSuccess) {
                    alert("修改成功！");
                } else {
                    alert("修改失败！");
                }
                // 重定向到首页
                window.location.href = 'flowershop.php';
            }
        }
    </script>
</head>
<body>
<!-- 返回首页按钮 -->
<div class="home-button">
    <input type="button" value="返回首页" onClick="location.href='flowershop.php'" />
</div>
<h1 align="center">修改鲜花信息</h1>
<form action="" method="post">
    <table align="center">
        <tr>
            <th>字段</th><th>内容</th>
        </tr>
        <tr>
            <td>鲜花编号</td><td><input type="text" name="flonum" value="<?php echo $flower['flonum']; ?>" readonly /></td>
        </tr>
        <tr>
            <td>鲜花名称</td><td><input type="text" name="floname" value="<?php echo $flower['floname']; ?>" /></td>
        </tr>
        <tr>
            <td>鲜花颜色</td><td><input type="text" name="color" value="<?php echo $flower['color']; ?>" /></td>
        </tr>
        <tr>
            <td>鲜花单位</td><td><input type="text" name="unit" value="<?php echo $flower['unit']; ?>" /></td>
        </tr>
        <tr>
            <td>鲜花单价</td><td><input type="text" name="price" value="<?php echo $flower['price']; ?>" /></td>
        </tr>
        <tr>
            <td>仓库编号</td><td><input type="text" name="warenum" value="<?php echo $flower['warenum']; ?>" /></td>
        </tr>
        <tr>
            <td>鲜花数量</td><td><input type="text" name="number" value="<?php echo $flower['number']; ?>" /></td>
        </tr>
    </table>
    <p align="center"><input type="submit" value="保存修改" /></p>
</form>
</body>
</html>
