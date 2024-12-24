<%@ Page Title="Manage Links and Videos" Language="C#" MasterPageFile="~/Site1.master" AutoEventWireup="true" CodeBehind="Link.aspx.cs" Inherits="InternWebApplication.Links" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="w3-container">
        <h2 class="w3-text-blue">Manage Links and Videos</h2>

        <!-- Form to insert a link -->
        <div class="w3-card-4 w3-padding w3-margin">
            <asp:Label ID="lblInsertLink" runat="server" Text="Enter a link:" CssClass="w3-label"></asp:Label><br />
            <asp:TextBox ID="txtLink" runat="server" CssClass="w3-input w3-border" Placeholder="Insert your link here"></asp:TextBox><br />
            <asp:Button ID="btnSubmit" runat="server" Text="Submit Link" CssClass="w3-button w3-green" OnClick="btnSubmit_Click" />
        </div>

        <!-- Form to upload a video -->
        <div class="w3-card-4 w3-padding w3-margin">
            <asp:Label ID="lblUploadVideo" runat="server" Text="Upload a video file:" CssClass="w3-label"></asp:Label><br />
            <asp:FileUpload ID="fileUploadVideo" runat="server" CssClass="w3-input w3-border" /><br />
            <asp:Label ID="lblMessage" runat="server" CssClass="w3-text-red"></asp:Label>
            <asp:Button ID="btnUploadVideo" runat="server" Text="Upload Video" CssClass="w3-button w3-green" OnClick="btnUploadVideo_Click" />
        </div>

        <!-- List of uploaded links and videos -->
        <div class="w3-card-4 w3-padding w3-margin">
            <h3 class="w3-text-blue">Uploaded Files</h3>
            <asp:GridView ID="GridViewFiles" runat="server" CssClass="w3-table-all" AutoGenerateColumns="False" OnRowCommand="GridViewFiles_RowCommand">
                <Columns>
                    <asp:BoundField DataField="id" HeaderText="ID" />
                    <asp:BoundField DataField="content" HeaderText="Content" />
                    <asp:BoundField DataField="type" HeaderText="Type" />
                  <asp:TemplateField HeaderText="Size">
                            <ItemTemplate>
                                <%# Convert.ToDouble(Eval("size")) / 1024 %> MB
                            </ItemTemplate>
                        </asp:TemplateField>                    
                    <asp:BoundField DataField="created_at" HeaderText="Created At" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="w3-button w3-red" CommandName="DeleteRow" CommandArgument='<%# Eval("id") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>
