<?php
session_start();
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // 获取表单提交的数据
    $username = $_POST['username'];
    $password = $_POST['password'];
    $confirm_password = $_POST['confirm_password'];

    // 检查两次输入的密码是否一致
    if ($password != $confirm_password) {
        $error = "两次输入的密码不一致";
    } else {
        // 数据库连接信息
        require_once('gauss_class.php');
        $host = "120.46.144.222";
        $user = "liuhongkun";
        $port = "26000";
        $dbname = "flowershop"; // 数据库名称为flowershop
        $password_db = "liuhongkun+123";

        // 创建数据库连接
        $opengauss = new gauss($host, $user, $password_db, $dbname, $port);
        if (!$opengauss) {
            exit('数据库连接失败！');
        }

        // 检查用户名是否已经存在
        $check_user_query = "SELECT * FROM users WHERE username = '$username'";
        $result = $opengauss->query($check_user_query);
        if ($result && $result->num_rows > 0) {
            $error = "用户名已存在";
        } else {
            // 对密码进行哈希处理
            $hashed_password = password_hash($password, PASSWORD_BCRYPT);

            // 插入新用户数据
            $insert_query = "INSERT INTO users (username, password) VALUES ('$username', '$hashed_password')";
            $insert_result = $opengauss->query($insert_query);

            if ($insert_result) {
                $success = "注册成功！";
                header('Location: login.php');
                exit();
            } else {
                $error = "注册失败，请重试";
            }
        }
    }
}
?>

<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>注册</title>
    <style>
        /* 设置页面背景图片 */
        body {
            background-image: url('https://img.shetu66.com/2023/03/03/1677825665478967.jpg');
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed;
            font-family: Arial, sans-serif;
            color: #3b602c;
        }
        /* 设置标题颜色 */
        h1 {
            color: #ffffff;
        }
        h2 {
            color: #eeffe5;
        }
        /* 设置表单样式，包括背景色、边框、阴影等 */
        form {
            background-color: rgba(204, 255, 204, 0.9); /* 浅绿色背景 */
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin: auto;
            width: 300px;
        }
        /* 设置按钮的样式，包括背景色、边框、文字颜色等 */
        input[type="button"], input[type="submit"] {
            background-color: #4caf50;
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
        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            box-sizing: border-box;
            border: 2px solid #4caf50;
            border-radius: 5px;
        }
        /* 设置错误信息和成功信息的样式 */
        .error {
            color: red;
            margin-top: 10px;
        }
        .success {
            color: green;
            margin-top: 10px;
        }
    </style>
</head>

<body>
<!-- 页面标题 -->
<h1 align="center">网上鲜花销售系统</h1>
<h2 align="center">注册</h2>
<!-- 表单开始 -->
<form action="register.php" method="post">
    <label for="username">用户名:</label>
    <input type="text" id="username" name="username" required>
    <label for="password">密码:</label>
    <input type="password" id="password" name="password" required>
    <label for="confirm_password">确认密码:</label>
    <input type="password" id="confirm_password" name="confirm_password" required>
    <p align="center"><input type="submit" value="注册"></p>
    <?php
    if (!empty($error)) {
        echo "<script>alert('注册失败: $error');</script>";
    }
    if (!empty($success)) {
        echo "<script>alert('注册成功！');</script>";
    }
    ?>
</form>
</body>
</html>
