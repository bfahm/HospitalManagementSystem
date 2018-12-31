<%@ Page Title="Admin View" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminView.aspx.cs" Inherits="HospitalInterface.AdminView" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <link href="Stylesheet1.css" rel="stylesheet" type="text/css" />
    <div class="jumbotron">
        <h1>Admin View</h1>
        <h4>Access Sensitive Data</h4>
        <div class="center" id="divCred" runat="server">

            <span class="loginText">Username:&nbsp;&nbsp;
            </span>

            <asp:TextBox ID="TextBox1" runat="server" Width="290px" placeholder="Admin Username"></asp:TextBox>
            <br />
            <br />
            <span class="loginText">Password:&nbsp;&nbsp;
            </span>

            <asp:TextBox ID="TextBox2" runat="server" Width="290px" placeholder="Admin Password" TextMode="Password"></asp:TextBox>
            &nbsp;<br />
            <br />
            <br />
            <br />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="ButtonLogin" runat="server" OnClick="Button_Login" Text="Login" Height="37px" Width="67px" />



            <br />
            <br />


            <p id="logDataForLogin" runat="server" style="color: red; font-size: 10px"></p>
        </div>
        <br />
        <br />
        <div id="divData" runat="server" class="fixUI">
            Choose a table to view all its data:
            <br />
            <asp:DropDownList ID="DropDownList1" runat="server" Height="16px" Width="137px">
                <asp:ListItem>Doctors</asp:ListItem>
                <asp:ListItem>Nurses</asp:ListItem>
                <asp:ListItem>Patients</asp:ListItem>
                <asp:ListItem>Wardboys</asp:ListItem>
                <asp:ListItem>Departments</asp:ListItem>
                <asp:ListItem>Rooms</asp:ListItem>
                <asp:ListItem>Room Types</asp:ListItem>
                <asp:ListItem>Admitted In</asp:ListItem>
                <asp:ListItem>Serves</asp:ListItem>
                <asp:ListItem>Treats</asp:ListItem>
            </asp:DropDownList>
            &nbsp;&nbsp;
            <asp:Button ID="ButtonViewTable" runat="server" OnClick="Button_ViewTable" Text="View Table" Width="166px" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="ButtonGoToSearch" runat="server" OnClick="Button_GotoSearch" Text="Search Patients Table" Width="166px" />
            <br />
            <br />
            <br />

            <div>
                <b>Find if a transaction is halting the system:</b>
                <br />
                <asp:Button ID="ButtonCheckTrans" runat="server" Text="Check for transactions" OnClick="Button_CheckTrans" />

                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="ButtonKillTrans" runat="server" Enabled="False" OnClick="Button_KillTrans" Text="Kill Transaction" />
                <br />
                <br />
                <p id="transactionsLog" runat="server" style="color: red; font-size: small"></p>

            </div>

            

        </div>
        <div class="fixUI" id="divCustomQueries" runat="server" visible="false">
                <h3>Custom Update Queries</h3>

                UPDATE&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:DropDownList ID="DropDownSelectTableUpdate" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownSelectTableUpdate_SelectedIndexChanged">
            </asp:DropDownList>
                &nbsp;&nbsp;&nbsp; SET&nbsp;&nbsp;
            <asp:DropDownList ID="DropDownSelectSetColumn" runat="server">
            </asp:DropDownList>
                &nbsp;&nbsp;&nbsp; =&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="TextBoxUpdateSet" runat="server"></asp:TextBox>
                &nbsp;&nbsp;&nbsp; WHERE&nbsp;&nbsp;&nbsp;
            <asp:DropDownList ID="DropDownListSelectWhereColumnUpdate" runat="server">
            </asp:DropDownList>
                &nbsp;&nbsp;&nbsp; =&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="TextBoxUpdateWhere" runat="server"></asp:TextBox>
                &nbsp;&nbsp;&nbsp;
            <asp:Button ID="ButtonExecUpdate" runat="server" Text="Execute Query" OnClick="ButtonExecUpdate_Click" />
                <br />
                <br />
                <p id="LogUpdate" runat="server"></p>
                <br />
                <h3>Custom Delete Queries</h3>

                DELETE&nbsp;&nbsp;&nbsp; FROM&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:DropDownList ID="DropDownSelectTableDelete" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownSelectTableDelete_SelectedIndexChanged">
            </asp:DropDownList>
                &nbsp;&nbsp;&nbsp; WHERE&nbsp;&nbsp;&nbsp;
            <asp:DropDownList ID="DropDownListSelectWhereColumnDelete" runat="server">
            </asp:DropDownList>
                &nbsp;&nbsp;&nbsp; =&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="TextBoxDeleteWhere" runat="server"></asp:TextBox>
                &nbsp;&nbsp;&nbsp;
            <asp:Button ID="ButtonExecDelete" runat="server" Text="Execute Query" OnClick="ButtonExecDelete_Click" />
                <br />

                <br />
                <p id="LogDelete" runat="server"></p>
                <br />
            </div>
        <div>

            <br />

            <asp:GridView ID="GridView1" runat="server" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Horizontal" Height="227px" Width="100%">
                <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
                <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
                <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F7F7F7" />
                <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
                <SortedDescendingCellStyle BackColor="#E5E5E5" />
                <SortedDescendingHeaderStyle BackColor="#242121" />
            </asp:GridView>

            <br />
            <br />

            <br />
            <br />
            <asp:Button ID="ButtonSignout" runat="server" OnClick="Button_SignOut" Text="Signout" Visible="False" />

            <br />

        </div>
        <br />

        <p id="logText" runat="server" style="color: brown; font-weight: bold;">
            &nbsp;
        </p>



    </div>



</asp:Content>
