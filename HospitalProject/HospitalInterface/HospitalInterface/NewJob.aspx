<%@ Page Title="NewJob" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="NewJob.aspx.cs" Inherits="HospitalInterface.NewJob" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <link href="Stylesheet1.css" rel="stylesheet" type="text/css" />
    <h2><%: Title %></h2>
    <h3>Request customized data from the Database Server</h3>
    <p>&nbsp;</p>
    <p>&nbsp;</p>
    <span>
        Login:&nbsp;&nbsp;
        <asp:TextBox ID="TextBox1" runat="server" TextMode="Number" placeholder="Type your ID Here"></asp:TextBox>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

    
        <asp:Button ID="Button2" runat="server" Text="Login" OnClick="Button2_Click" />
    
    <br />
    &nbsp;

    
        </span>
    

    

    <div id="DoctorNurse" runat="server" visible="false" class ="fixUI">
        <p id="autoShowData" runat="server" style="font-weight:bold; white-space: pre-line;"></p>

            <p runat="server">
                List of Patients you are currently assigned to: (Relation: Treats &amp; Serves)
            </p>
            <asp:GridView ID="GridView1" runat="server" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Horizontal" Height="256px" Width="100%">
                <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
                <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
                <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F7F7F7" />
                <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
                <SortedDescendingCellStyle BackColor="#E5E5E5" />
                <SortedDescendingHeaderStyle BackColor="#242121" />
            </asp:GridView>
            <p runat="server">
                &nbsp;
            </p>
            <p runat="server">
                List of waiting patients in the same department:
            </p>
            <asp:GridView ID="GridView2" runat="server" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Horizontal" Height="256px" Width="100%">
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
            Choose a patient ID to treat:<br />
            <br />
            <asp:TextBox ID="TextBox2" runat="server" Width="141px" placeholder="Type Patient ID Here"></asp:TextBox>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:TextBox ID="TextBox3" runat="server" Width="221px" placeholder="Type Short Treatment Notes Here"></asp:TextBox>
            &nbsp;&nbsp;
        <asp:Button ID="Button1" runat="server" Text="Help New Patient" OnClick="Button1_Click" />
            <br />

        

    </div>
    
    <p id="logText" runat="server" style="color:red">

        </p>

</asp:Content>
