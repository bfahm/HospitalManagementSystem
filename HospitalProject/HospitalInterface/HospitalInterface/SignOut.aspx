<%@ Page Title="SignOut" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SignOut.aspx.cs" Inherits="HospitalInterface.SignOut" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <link href="Stylesheet1.css" rel="stylesheet" type="text/css" />

    <h2><%: Title %></h2>
    <h3>We hope you get well soon!</h3>
    <p>&nbsp;</p>
    <p>Enter Disadmitted Patient ID</p>
    <p>
        <asp:TextBox ID="patientIdBox" runat="server" TextMode="Number" Width="165px" placeholder="Type the 7 digits"></asp:TextBox>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="Button1" runat="server" Text="Enter" OnClick="Button1_Click" />
    </p>
    <p>&nbsp;</p>






    <div id="returnData" runat="server" visible="false" class="fixUI">

        <p style="font-size:20px">Patient Data:</p>
        <p>
            <asp:GridView ID="GridView1" runat="server" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Horizontal" Height="112px" Width="100%">
                <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
                <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
                <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F7F7F7" />
                <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
                <SortedDescendingCellStyle BackColor="#E5E5E5" />
                <SortedDescendingHeaderStyle BackColor="#242121" />
            </asp:GridView>
        </p>
        <p>&nbsp;</p>

        <div id="divDocData" runat="server">
            Associated Doctor Data: 
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <p id="tvDocId" runat="server" style="display: inline"  class="highlightData">
                    0000000
                </p>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                Doc:
            <p id="tvDocName" runat="server" style="display: inline" class="highlightData">
                &nbsp;
            </p>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            Undergoing Treatment: 
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <p id="tvTreatment" runat="server" style="display: inline" class="highlightData">
            </p>

        </div>
        <br />
        <br />
        <div id="divRoomData" runat="server">
            Associated Room Data: 
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <p id="tvRoomId" runat="server" style="display: inline" class="highlightData">
                0000000
            </p>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <p id="tvRoomType" runat="server" style="display: inline" class="highlightData">
            </p>
            <br />

        </div>
        <br />
        <br />
        <p id="tvNurseHeader" runat="server">
            Nurses who has helped:
        </p>
        <asp:GridView ID="GridView2" runat="server" ShowHeader="False" BorderStyle="None" CellSpacing="10" Width="176px" BorderColor="White">
        </asp:GridView>

        <br />
        Days since patient has first entered:
        <p id="tvDays" runat="server" style="display: inline; font-weight: bold">
            test
        </p>
        <p style="display: inline; font-weight: bold;">
            days
        </p>
        <br />
        Bill till now:
        <p id="tvBill" runat="server" style="display: inline; font-weight: bold;">
            test
        </p>
        <p style="display: inline; font-weight: bold;">
            $
        </p>
        <br />
        <br />
        <asp:Button ID="Button2" runat="server" Text="Discharge Patient" OnClick="Button2_Click"
            OnClientClick="return confirm('Are you sure you want to remove patient from serving tables?')" />
        <br />

    </div>
    <br />
    <br />
    <p id="logText" runat="server" style="color: brown; white-space: pre-line; font-style:oblique">
        &nbsp;
    </p>



</asp:Content>
