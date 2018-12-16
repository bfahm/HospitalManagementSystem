<%@ Page Title="Admin View" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminView.aspx.cs" Inherits="HospitalInterface.AdminView" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <link href="Stylesheet1.css" rel="stylesheet" type="text/css" />
    <div class="jumbotron">
        <h1>Admin View</h1>
        <h4>Access Sensitive Data</h4>
        <div class="center" id="divCred" runat="server">

            <span class ="loginText" >
                Username:&nbsp;&nbsp;
            </span>

            <asp:TextBox ID="TextBox1" runat="server" Width="290px" placeholder="Patient ID"></asp:TextBox>
            <br />
            <br />
            <span class ="loginText" >
                Password:&nbsp;&nbsp;
            </span>
            
            <asp:TextBox ID="TextBox2" runat="server" Width="290px" placeholder="Patient Name" TextMode="Password"></asp:TextBox>
            &nbsp;<br />
            <br />
            <br />
            <br />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:Button ID="Button1" runat="server" OnClick="Btn_Login" Text="Login" Height="37px" Width="67px"  />
            
                

            <br />
            <br />
            
                
            <p id="logDataForLogin" runat="server" style="color:red;font-size:10px"></p>
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
            <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="View Table" Width="166px" />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="Button3" runat="server" OnClick="Button3_Click" Text="Search Patients Table" Width="166px" />
            <br />
            <br />
            <br />
        
            <div>
                <b>Find if a transaction is halting the system:</b>
                <br />
                <asp:Button ID="Button5" runat="server" Text="Check for transactions" OnClick="Button5_Click" />

                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="Button6" runat="server" Enabled="False" OnClick="Button6_Click" Text="Kill Transaction" />
                <br />
                <br />
                <p id="transactionsLog" runat="server" style="color:red; font-size:small"></p>

            </div>
        
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
            <asp:Button ID="Button4" runat="server" OnClick="Button4_Click" Text="Signout" Visible="False" />

        <br />

        </div>
        <br />

    <p id="logText" runat="server" style="color:brown; font-weight:bold;">

    </p>

    

    </div>

        

</asp:Content>
