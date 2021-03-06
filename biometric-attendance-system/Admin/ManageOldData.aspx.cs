﻿using DALHelper;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_ManageOldData : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        BindData();
    }
    protected void BindData()
    {
        ManageLeaves objManageLeaves = new ManageLeaves();
        grd_Employees.DataSource = objManageLeaves.getDataForOldLeaves(new DateTime(), new DateTime());
        grd_Employees.DataBind();
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        DBDataHelper.ConnectionString = ConfigurationManager.ConnectionStrings["CSBiometricAttendance"].ConnectionString;
        List<SqlParameter> lstData = new List<SqlParameter>();
        lstData.Add(new SqlParameter("@employeeId", Convert.ToInt32(Session["id"])));
        lstData.Add(new SqlParameter("@sickleave", Convert.ToInt32(txtEditSL.Text)));
        lstData.Add(new SqlParameter("@emergencyLeave", Convert.ToInt32(txtEditEL.Text)));
        if (ddlDate.SelectedValue == "0")
        {
            lstData.Add(new SqlParameter("@sessionstart", new DateTime(2015, 08, 01)));
            lstData.Add(new SqlParameter("@sessionend", new DateTime(2016, 07, 31)));
        }
        else
        {
            lstData.Add(new SqlParameter("@sessionstart", new DateTime(2016, 08, 01)));
            lstData.Add(new SqlParameter("@sessionend", new DateTime(2017, 07, 31)));
        }
        string query = "Insert into tblLeavesOldStock values(@employeeId,@sickleave,@emergencyLeave,@sessionstart,@sessionend)";
        using (DBDataHelper objDDBDataHelper = new DBDataHelper())
        {
            objDDBDataHelper.ExecSQL(query, SQLTextType.Query, lstData);
        }
        BindData();
    }
    protected void lkbEditData_Click(object sender, EventArgs e)
    {
        popupEditData.Show();
        LinkButton b = (LinkButton)sender;
        lblName.Text = b.CommandArgument.Split(';')[1];
        Session["id"] = Convert.ToInt32(b.CommandArgument.Split(';')[0]);
    }
}