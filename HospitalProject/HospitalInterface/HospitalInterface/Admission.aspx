<%@ Page Title="New Job" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Admission.aspx.cs" Inherits="HospitalInterface.Admission" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    
    <link href="Stylesheet1.css" rel="stylesheet" type="text/css" />

    <h2>ADMIT NEW PATIENTS TO ROOMS:</h2>
    <p>&nbsp;</p>
    <div>
        &nbsp;&nbsp;&nbsp;&nbsp; PLEASE SELECT THE DEPARTMENT:&nbsp;&nbsp;&nbsp;
        <asp:DropDownList ID="DropDownList1" runat="server" Height="35px" Width="170px">
        </asp:DropDownList>
        <br />
        <br />
        &nbsp;&nbsp;&nbsp;&nbsp; 
        PLEASE SELECT THE ROOM TYPE:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:DropDownList ID="DropDownList2" runat="server" Height="36px" Width="170px">
            <asp:ListItem>(1)Ward Room</asp:ListItem>
            <asp:ListItem>(3)Operation Room</asp:ListItem>
            <asp:ListItem>(2)ICU</asp:ListItem>
        </asp:DropDownList>
        <br />
        &nbsp;&nbsp;&nbsp;&nbsp;
        <br />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="Button1" runat="server" Text="Submit" Width="96px" OnClick="Button1_click" />
    </div>
    <div class="fixUI" visible="false" id="ShowData" runat="server">
    
        <b>List of Patients to be admitted or transfered:</b><br />
        <br />
&nbsp;<br />
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
        <br />Write Patient ID:<asp:TextBox ID="TextBox2" runat="server" Width="143px" placeholder="Enter Patient ID"></asp:TextBox>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Choose A room:
                <asp:DropDownList ID="DropDownList3" runat="server" Width="143px">
                </asp:DropDownList>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="Button2" runat="server" Text="Admit" Width="83px" OnClick="Button2_click" />

        <br />
        <br />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                
    

    </div>
    <br />
    <p id="logText" runat="server" style="color: red; white-space: pre-line;"></p>


</asp:Content>
