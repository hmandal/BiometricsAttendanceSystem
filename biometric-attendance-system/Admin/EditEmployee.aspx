﻿<%@ Page Title="EditEmployee" Language="C#" MasterPageFile="~/MasterPages/Admin.master" AutoEventWireup="true" CodeFile="EditEmployee.aspx.cs" Inherits="Admin_EditEmployee" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row">
        <div class="col s12">
            <div class="col s12 breadcrumb">
                <br />
                <a href="~/Admin/ManageMasterEntries.aspx" class="grey-text">Home &nbsp;&nbsp;></a>
                <a href="#!" class="teal-text">&nbsp;&nbsp;Edit Employees &nbsp;&nbsp;</a>
            </div>
        </div>
        <br />
        <div class="col s8 m6 l4 offset-s2 offset-m4 offset-l4">
            <asp:TextBox runat="server" ID="txtName" placeholder="Name" ToolTip="Name"></asp:TextBox>
            <asp:RequiredFieldValidator SetFocusOnError="true" ErrorMessage="&nbsp;Required" ControlToValidate="txtName" CssClass="input-field btn grey lighten-4 teal-text " runat="server" />
        </div>
        <div class="row">
            <div class="col s8 m3 l2 offset-s2 offset-m4 offset-l4">
                <asp:TextBox runat="server" CssClass="" ID="txtDateOfBirth" placeholder="Date of Birth"></asp:TextBox>
            </div>
            <div class="col s8 m3 l2 offset-s2">
                <asp:TextBox runat="server" ID="txtDateOfJoining" placeholder="Date of Joining"></asp:TextBox>
            </div>
            <asp:RequiredFieldValidator SetFocusOnError="true" ErrorMessage="Required" ControlToValidate="txtDateOfBirth" CssClass="input-field btn grey lighten-4 teal-text" runat="server" />
            <asp:RegularExpressionValidator SetFocusOnError="true" runat="server" ControlToValidate="txtDateOfBirth" ErrorMessage="nbsp;DD/MM/YYYY Format" CssClass="input-field btn grey lighten-4 teal-text " ValidationExpression="^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[1,3-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$"></asp:RegularExpressionValidator>
            <asp:RequiredFieldValidator SetFocusOnError="true" ErrorMessage="Required" ControlToValidate="txtDateOfJoining" CssClass="input-field btn grey lighten-4 teal-text" runat="server" />
            <asp:RegularExpressionValidator SetFocusOnError="true" runat="server" ControlToValidate="txtDateOfJoining" ErrorMessage=" DD/MM/YYYY Format" CssClass="input-field btn grey lighten-4 teal-text" ValidationExpression="^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[1,3-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$"></asp:RegularExpressionValidator>
        </div>
        <div class="row">
            <div class="col s8 m3 l2 offset-s2 offset-m4 offset-l4">
                <asp:DropDownList ID="ddlDepartments" runat="server" Visible="true" CssClass="input-field btn grey lighten-4 teal-text">
                </asp:DropDownList>
            </div>
            <div class="col s8 m3 l2 offset-s2">
                <asp:DropDownList ID="ddlRoles" runat="server" Visible="true" CssClass="input-field btn grey lighten-4 teal-text">
                </asp:DropDownList>
            </div>
        </div>
        <br />
        <br />
        <div class="col s8 m6 l4 offset-s2 offset-m4 offset-l4">
            <asp:RadioButton ID="rdrbtnFemale" GroupName="Gender" Text="Female" CssClass="with-gap" Checked="true" runat="server" />
            <asp:RadioButton ID="rdrbtnMale" GroupName="Gender" Text="Male" CssClass="with-gap" runat="server" />
        </div>
        <div class="col s8 m6 l4 offset-s2 offset-m4 offset-l4">
            <asp:TextBox runat="server" ID="txtContactNumber" placeholder="Contact Number">
            </asp:TextBox>
            <asp:RequiredFieldValidator SetFocusOnError="true" ErrorMessage=" Required" ControlToValidate="txtContactNumber" CssClass="input-field btn grey lighten-4 teal-text" runat="server" />
            <asp:RegularExpressionValidator SetFocusOnError="true" runat="server" ControlToValidate="txtContactNumber" ErrorMessage=" Invalid Mobile Number" CssClass="input-field btn grey lighten-4 teal-text" ValidationExpression="^([0-9]*){10}$"></asp:RegularExpressionValidator>
        </div>
        <br />
        <br />
        <div class="col s8 m6 l4 offset-s2 offset-m4 offset-l4">
            <asp:TextBox runat="server" ID="txtPassword" placeholder="Password" TextMode="Password">
            </asp:TextBox>
            <asp:RequiredFieldValidator SetFocusOnError="true" ErrorMessage=" Required" ControlToValidate="txtPassword" CssClass="input-field btn grey lighten-4 teal-text" runat="server" />
        </div>
        <div class="col s8 m6 l4 offset-s2 offset-m4 offset-l4">
            <asp:LinkButton ID="lnkUpdateEmployee" runat="server" CssClass="btn waves-teal" OnClick="lnkUpdateEmployee_Click">
            Update Employee
            </asp:LinkButton>
        </div>
    </div>
</asp:Content>

