<%@ Page Title="Registration" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="HospitalInterface.Registeration" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    
    <link href="Stylesheet1.css" rel="stylesheet" type="text/css" />
    
    <h2><%: Title %>.</h2>
    <h3>Register a new system user.</h3>
    <p>Please Select an Option from Below:</p>
    <p>
        <asp:DropDownList ID="DropDownList1" runat="server" Height="35px" Width="218px">
            <asp:ListItem>Select..</asp:ListItem>
            <asp:ListItem>New Doctor/Nurse</asp:ListItem>
            <asp:ListItem>New Patient</asp:ListItem>
            <asp:ListItem>New WardBoy</asp:ListItem>
        </asp:DropDownList>
        &nbsp;&nbsp;&nbsp;
        <asp:Button ID="Button2" runat="server" Text="Choose" Height="35px" OnClick="Button2_Click"/>
    </p>
    <p>&nbsp;</p>
    <p>&nbsp;</p>
    <div runat="server" ID="DoctorNurse" visible ="false" class="fixUI" >

        Name:&nbsp;&nbsp;
        <asp:TextBox ID="TextBox1" runat="server" Height="35px" Width="218px" placeholder="Insert a valid Name"></asp:TextBox>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        Department:&nbsp;&nbsp;
        <asp:DropDownList ID="DropDownList2" runat="server" Height="35px" Width="218px">
        </asp:DropDownList>

        <br />
        <br />

        <asp:RadioButtonList ID="RadioButtonList1" runat="server" Height="16px" Width="217px">
            <asp:ListItem>Doctor</asp:ListItem>
            <asp:ListItem>Nurse</asp:ListItem>
        </asp:RadioButtonList>

        <br />

        <asp:Button ID="Button1" runat="server"  Text="Submit" OnClick="Button1_Click" />

        <br />
        <br />

    </div>
    <div runat="server" ID="Patient" visible ="false" class="fixUI">
        Name:&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:TextBox ID="TextBox2" runat="server" Height="30px" Width="223px" placeholder="Insert a valid Name"></asp:TextBox>
        &nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br />
        Number:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:TextBox ID="TextBox3" runat="server" Height="30px" Width="223px" TextMode="Number" placeholder="Insert a phone number"></asp:TextBox>
        <br />
        <br />
        Disease:&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; <asp:TextBox ID="TextBox4"  runat="server" Height="30px" Width="223px" placeholder="Describe the disease"></asp:TextBox>
        &nbsp;<br />
        <br />
        <asp:Button ID="Button3" runat="server" Text="Submit" OnClick="Button3_Click" />
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="Button5" runat="server" OnClick="Button5_Click" Text="Admit Patient" />
    </div>
    <div runat="server" ID="Ward" visible ="false" class="fixUI">

        <br />Name:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:TextBox ID="TextBox5" runat="server" Height="30px" Width="223px" placeholder="Insert a valid Name"></asp:TextBox>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        Room:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:DropDownList ID="DropDownList4" runat="server" Height="18px" Width="174px">
        </asp:DropDownList>
        <br />
        <br />
        <asp:Button ID="Button4" runat="server" Text="Submit" OnClick="Button4_Click" />

    </div>

    <p id="logText" runat="server" style="color:red"></p>
</asp:Content>
