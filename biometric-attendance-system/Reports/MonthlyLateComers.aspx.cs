﻿using iTextSharp.text;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Reports_MonthlyLateComers : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            BindDropDowns();
    }
    protected void Calendar1_SelectionChanged(object sender, EventArgs e)
    {
        txt_startDate.Text = Calendar1.SelectedDate.Date.ToString("d");
    }
    protected void Calendar2_SelectionChanged(object sender, EventArgs e)
    {
        txt_endDate.Text = Calendar2.SelectedDate.Date.ToString("d");
    }

    protected void btn_report_Click(object sender, EventArgs e)
    {
        btnExport.Visible = true;
        BindGrid();
    }

    protected void BindGrid()
    {
        TimeSpan relaxationTime = new TimeSpan();
        relaxationTime = TimeSpan.Parse(ddlRelaxation.SelectedValue.ToString());
        ManageReports objManageReports = new ManageReports();
        var data = objManageReports.GetDataForMonthlyLateReport(Convert.ToInt32(ddlDepartments.SelectedValue.ToString()), Calendar1.SelectedDate.Date, Calendar2.SelectedDate.Date, relaxationTime);
        grid_lateComers.DataSource = data;
        grid_lateComers.DataBind();
    }
    protected void BindDropDowns()
    {
        MasterEntries objMasterEntries = new MasterEntries();
        ddlDepartments.DataSource = objMasterEntries.GetAllDepartments();
        ddlDepartments.DataTextField = "Name";
        ddlDepartments.DataValueField = "Id";
        ddlDepartments.DataBind();
    }

    protected void btnExport_Click(object sender, EventArgs e)
    {
        using (StringWriter sw = new StringWriter())
        {
            using (HtmlTextWriter hw = new HtmlTextWriter(sw))
            {
                //To Export all pages
                grid_lateComers.AllowPaging = false;
               this.BindGrid();

                grid_lateComers.RenderBeginTag(hw);
                grid_lateComers.HeaderRow.RenderControl(hw);
                foreach (GridViewRow row in grid_lateComers.Rows)
                {
                    row.RenderControl(hw);
                }
                grid_lateComers.FooterRow.RenderControl(hw);
                grid_lateComers.RenderEndTag(hw);
                StringReader sr = new StringReader(sw.ToString());
                Document pdfDoc = new Document(PageSize.A2, 10f, 10f, 10f, 0f);
                HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
                PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
                pdfDoc.Open();
                htmlparser.Parse(sr);
                pdfDoc.Close();

                Response.ContentType = "application/pdf";
                Response.AddHeader("content-disposition", "attachment;filename=Report.pdf");
                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                Response.Write(pdfDoc);
                Response.End();
            }
        }
    }
}