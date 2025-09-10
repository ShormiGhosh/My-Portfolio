<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="shormiportfolio.Admin.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Login - Portfolio</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #0a0a0a;
            background-image: radial-gradient(circle at center, rgba(0, 174, 172, 0.1) 0%, transparent 50%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            color: #ffffff;
        }

        .login-container {
            background: rgba(26, 26, 26, 0.95);
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.5);
            width: 100%;
            max-width: 400px;
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .login-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .login-header h2 {
            color: #ffffff;
            margin-bottom: 10px;
            font-size: 28px;
            font-weight: 600;
        }

        .login-header p {
            color: #a0a0a0;
            font-size: 14px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #00aeac;
            font-weight: 500;
            font-size: 14px;
        }

        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid rgba(255, 255, 255, 0.1);
            border-radius: 8px;
            font-size: 16px;
            transition: all 0.3s ease;
            background-color: #1a1a1a;
            color: #ffffff;
        }

        .form-control:focus {
            outline: none;
            border-color: #00aeac;
            box-shadow: 0 0 0 3px rgba(0, 174, 172, 0.2);
            background-color: #262626;
        }

        .form-control::placeholder {
            color: #666666;
        }

        .remember-me-container {
            margin: 20px 0;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .remember-me-checkbox {
            position: relative;
            display: inline-flex;
            align-items: center;
            cursor: pointer;
            user-select: none;
        }

        .remember-me-checkbox input[type="checkbox"] {
            opacity: 0;
            position: absolute;
            cursor: pointer;
            width: 0;
            height: 0;
        }

        .checkmark {
            position: relative;
            height: 20px;
            width: 20px;
            background-color: #1a1a1a;
            border: 2px solid rgba(255, 255, 255, 0.1);
            border-radius: 4px;
            transition: all 0.3s ease;
        }

        .remember-me-checkbox:hover .checkmark {
            border-color: #00aeac;
            background-color: rgba(0, 174, 172, 0.1);
        }

        .remember-me-checkbox input:checked ~ .checkmark {
            background-color: #00aeac;
            border-color: #00aeac;
        }

        .checkmark:after {
            content: "";
            position: absolute;
            display: none;
            left: 6px;
            top: 2px;
            width: 6px;
            height: 12px;
            border: solid white;
            border-width: 0 2px 2px 0;
            transform: rotate(45deg);
        }

        .remember-me-checkbox input:checked ~ .checkmark:after {
            display: block;
        }

        .remember-me-label {
            color: #a0a0a0;
            font-size: 14px;
            margin-left: 8px;
            cursor: pointer;
            transition: color 0.3s ease;
        }

        .remember-me-checkbox:hover .remember-me-label {
            color: #00aeac;
        }

        .btn-login {
            width: 100%;
            padding: 12px;
            background: linear-gradient(135deg, #667dff 0%, #00aeac 100%);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .btn-login::before {
            content: "";
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(
                90deg,
                transparent,
                rgba(255, 255, 255, 0.2),
                transparent
            );
            transition: left 0.5s;
        }

        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0, 174, 172, 0.4);
        }

        .btn-login:hover::before {
            left: 100%;
        }

        .btn-login:active {
            transform: translateY(0);
        }

        .error-message {
            background-color: rgba(255, 107, 107, 0.1);
            color: #ff6b6b;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            border: 1px solid rgba(255, 107, 107, 0.3);
            font-size: 14px;
        }

        .back-to-site {
            text-align: center;
            margin-top: 25px;
        }

        .back-to-site a {
            color: #00aeac;
            text-decoration: none;
            font-size: 14px;
            transition: color 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }

        .back-to-site a:hover {
            color: #667dff;
            text-decoration: underline;
        }

        /* Loading animation for the login container */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .login-container {
            animation: fadeInUp 0.6s ease-out;
        }

        /* Responsive design */
        @media (max-width: 480px) {
            .login-container {
                padding: 30px 20px;
                margin: 0 10px;
            }

            .login-header h2 {
                font-size: 24px;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-container">
            <div class="login-header">
                <h2>Admin Login</h2>
            </div>
            
            <asp:Panel ID="pnlError" runat="server" CssClass="error-message" Visible="false">
                <asp:Label ID="lblError" runat="server"></asp:Label>
            </asp:Panel>
            
            <div class="form-group">
                <label for="txtUsername">Username</label>
                <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Enter username"></asp:TextBox>
            </div>
            
            <div class="form-group">
                <label for="txtPassword">Password</label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Enter password"></asp:TextBox>
            </div>
            
            <div class="remember-me-container">
                <label class="remember-me-checkbox">
                    <asp:CheckBox ID="chkRememberMe" runat="server" />
                    <span class="checkmark"></span>
                    <span class="remember-me-label">Keep me logged in for 7 days</span>
                </label>
            </div>
            
            <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn-login" OnClick="btnLogin_Click" />
            
            <div class="back-to-site">
                <a href="../Default.aspx">← Back to Website</a>
            </div>
        </div>
    </form>
</body>
</html>