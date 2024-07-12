<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>新增鲜花记录</title>
    <style>
        body {
            background-color: #ffe6f2;
            font-family: Arial, sans-serif;
            color: #333;
            position: relative;
        }
        h1 {
            color: #ff1493;
        }
        form {
            background-color: #fff0f5;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin: auto;
            width: 50%;
        }
        input[type="text"], input[type="number"], textarea {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            box-sizing: border-box;
            border: 2px solid #ff1493;
            border-radius: 5px;
        }
        input[type="submit"] {
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
        .back-button {
            position: absolute;
            top: 20px;
            right: 20px;
            background-color: #ff69b4;
            border: none;
            color: white;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            cursor: pointer;
            border-radius: 5px;
        }
    </style>
    <script>
        function showMessage(message) {
            alert(message);
        }
    </script>
</head>

<body>
<h1 align="center">新增鲜花记录</h1>
<a href="flowershop.php" class="back-button">返回</a>
<form action="insert_flo.php" method="post" name="insertf">
    <label for="flonum">鲜花编号</label>
    <input type="text" id="flonum" name="flonum" required />

    <label for="floname">鲜花名称</label>
    <input type="text" id="floname" name="floname" required />

    <label for="color">鲜花颜色</label>
    <input type="text" id="color" name="color" required />

    <label for="unit">鲜花单位</label>
    <input type="text" id="unit" name="unit" required />

    <label for="price">鲜花单价</label>
    <input type="number" step="0.01" id="price" name="price" required />

    <label for="warenum">仓库编号</label>
    <input type="text" id="warenum" name="warenum" required />

    <label for="number">鲜花数量</label>
    <input type="number" id="number" name="number" required />

    <p align="center">
        <input type="submit" value="提交" />
    </p>
</form>

<?php
// 引入数据库连接类
require_once ('gauss_class.php');

// 数据库连接信息
$host        = "120.46.144.222";
$user        = "liuhongkun";
$port        = "26000";
$dbname      = "flowershop";
$password    = "liuhongkun+123";

// 创建数据库连接
$opengauss = new gauss($host, $user, $password, $dbname, $port);
if (!$opengauss) {
    exit('数据库连接失败！');
}

// 检查是否有表单提交
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $flonum = $_POST["flonum"];
    $floname = $_POST["floname"];
    $color = $_POST["color"];
    $number = $_POST["number"];
    $price = $_POST["price"];
    $warenum = $_POST["warenum"];
    $unit = $_POST["unit"];

    // 插入数据到数据库
    $data = array(
        'flonum' => $flonum,
        'floname' => $floname,
        'color' => $color,
        'number' => $number,
        'price' => $price,
        'warenum' => $warenum,
        'unit' => $unit
    );

    $result = $opengauss->insert('flower', $data);

    if ($result) {
        echo "<script>alert('鲜花记录新增成功！');</script>";
    } else {
        echo "<script>alert('鲜花记录新增失败，请重试。');</script>";
    }
}
?>
</body>
</html>
