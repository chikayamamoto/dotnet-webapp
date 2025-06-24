<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="スマホ.WebForm1" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>サイト１</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <style>
        body, form {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', 'Meiryo', sans-serif;
            background: #f4f8fb;
        }
        .head {
            height: 3.5em;
            background-color: #41ACD0;
            color: #fff;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.3em;
            font-weight: bold;
            letter-spacing: 0.1em;
            box-shadow: 0 2px 6px rgba(0,0,0,0.05);
        }
        .elements {
            background-color: #E7F8FF;
            border-radius: 1.2em;
            width: 90%;
            max-width: 400px;
            margin: 2em auto 0 auto;
            box-shadow: 0 4px 16px rgba(65,172,208,0.10);
            padding: 2em 1.5em 1.5em 1.5em;
            text-align: center;
        }
        .sensor-label {
            text-align: left;
            padding-left: 0.5em;
            font-size: 1.1em;
            color: #1976D2;
            margin-bottom: 0.5em;
            font-weight: 500;
        }
        .temp-row {
            display: flex;
            align-items: flex-end;
            justify-content: center;
            margin-top: 0.5em;
        }
        .temp {
            font-size: 4em;
            font-weight: bold;
            color: #1976D2;
            line-height: 1;
        }
        .units {
            font-size: 1.5em;
            color: #1976D2;
            margin-left: 0.2em;
            margin-bottom: 0.3em;
        }
        .foot {
            height: 3.5em;
            background-color: #41ACD0;
            color: #fff;
            position: fixed;
            bottom: 0;
            left: 0;
            width: 100%;
            z-index: 100;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1em;
            letter-spacing: 0.05em;
            box-shadow: 0 -2px 6px rgba(0,0,0,0.05);
        }
        @media (max-width: 480px) {
            .elements {
                width: 98%;
                padding: 1.2em 0.5em 1em 0.5em;
            }
            .temp {
                font-size: 2.5em;
            }
            .units {
                font-size: 1.1em;
            }
        }
    </style>
</head>
<body>
<form id="form1" runat="server">
    <div class="head">
        <asp:Label ID="siteName" runat="server" Text="サイト１"></asp:Label>
        <asp:PlaceHolder ID="phPager" runat="server" />
    </div>
    <asp:Repeater ID="sensorRepeater" runat="server">
        <ItemTemplate>
            <div class="elements">
                <div class="sensor-label">
                    <%# Eval("SensorName") %>
                </div>
                <div class="temp-row">
                    <span class="temp"><%# Eval("Value") %></span>
                    <span class="units"><%# Eval("Unit") %></span>
                </div>
            </div>
        </ItemTemplate>
    </asp:Repeater>
    <footer class="foot">
    </footer>
</form>
</body>
</html>