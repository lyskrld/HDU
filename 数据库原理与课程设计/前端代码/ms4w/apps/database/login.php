<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>登录</title>
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
            color: #2e4d22;
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
        input[type="button"], input[type="submit"], .register-button {
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
    </style>
</head>

<body>
<!-- 页面标题 -->
<h1 align="center">网上鲜花销售系统</h1>
<h2 align="center">登录</h2>
<!-- 表单开始 -->
<form action="flowershop.php" method="post">
    <label for="username">用户名:</label>
    <input type="text" id="username" name="username" required>
    <label for="password">密码:</label>
    <input type="password" id="password" name="password" required>
    <p align="center">
        <input type="submit" value="登录">
        <input type="button" value="注册" onclick="location.href='register.php';">
    </p>
    <?php
    if (!empty($error)) {
        echo '<div class="error">'.$error.'</div>';
    }
    ?>
</form>
</body>
</html>
