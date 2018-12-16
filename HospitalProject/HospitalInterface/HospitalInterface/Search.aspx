<%@ Page Title="Search a Patient" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Search.aspx.cs" Inherits="HospitalInterface.Search" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h1>Search a Patient</h1>
        <h4>Type your criteria and search</h4>
        <div>

            <asp:TextBox ID="TextBox1" runat="server" Width="290px" placeholder="Patient ID" TextMode="Number"></asp:TextBox>
&nbsp;&nbsp;
            <asp:TextBox ID="TextBox2" runat="server" Width="290px" placeholder="Patient Name"></asp:TextBox>
&nbsp;&nbsp;
            <asp:TextBox ID="TextBox3" runat="server" Width="290px" placeholder="Patient Number" TextMode="Number"></asp:TextBox>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Search" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;
            
                

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

        </div>
        <br />

    <p id="logText" runat="server" style="color:brown; font-weight:bold;">

    </p>

    

    </div>

        

</asp:Content>
