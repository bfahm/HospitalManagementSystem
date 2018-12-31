using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

namespace HospitalInterface
{
    public partial class AdminView : Page
    {
        SqlConnection conn = new SqlConnection("data source=DESKTOP-41PN3EM\\TESTINSTANCE; " +
            "database=HospitalMS; integrated security=SSPI");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) { 
                divData.Visible = false;
                GridView1.Visible = false;
                
            }
            
        }

        private void ViewTable()
        {
            SqlCommand cmd = null;
            int selectedIndex = DropDownList1.SelectedIndex;
            switch (selectedIndex)
            {
                case 0:
                    cmd = new SqlCommand("SELECT * FROM Ent_Doctor", conn);
                    break;
                case 1:
                    cmd = new SqlCommand("SELECT * FROM Ent_Nurse", conn);
                    break;
                case 2:
                    cmd = new SqlCommand("SELECT * FROM Ent_Patient", conn);
                    break;
                case 3:
                    cmd = new SqlCommand("SELECT * FROM Ent_Wardboy", conn);
                    break;
                case 4:
                    cmd = new SqlCommand("SELECT * FROM Hos_Departments", conn);
                    break;
                case 5:
                    cmd = new SqlCommand("SELECT * FROM Hos_Room", conn);
                    break;
                case 6:
                    cmd = new SqlCommand("SELECT * FROM Hos_Room_Types", conn);
                    break;
                case 7:
                    cmd = new SqlCommand("SELECT * FROM Rel_AdmittedIn", conn);
                    break;
                case 8:
                    cmd = new SqlCommand("SELECT * FROM Rel_Treats", conn);
                    break;
                case 9:
                    cmd = new SqlCommand("SELECT * FROM Rel_Serves", conn);
                    break;
            }
            conn.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            GridView1.Visible = true;
            GridView1.DataSource = rdr;
            GridView1.DataBind();
            conn.Close();
        }

        protected void Button_Login(object sender, EventArgs e)
        {
            string username = TextBox1.Text.ToString();
            string password = TextBox2.Text.ToString();

            if (!(username == "admin" && password == "admin"))
            {
                logDataForLogin.InnerText = "Wrong Username or Password";
            }
            else
            {
                logDataForLogin.InnerText = "";
                divCred.Visible = false;
                divData.Visible = true;
                ButtonSignout.Visible = true;
                InflateTableDropDowns();
                divCustomQueries.Visible = true;
            }
        }

        protected void InflateTableDropDowns()
        {
            SqlCommand cmd = new SqlCommand("SELECT TABLE_NAME " +
                                            "FROM HospitalMS.INFORMATION_SCHEMA.TABLES " +
                                            "WHERE TABLE_TYPE = 'Base Table'", conn);
            conn.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            DataTable table = new DataTable();
            table.Load(reader);

            DropDownSelectTableUpdate.DataSource = table;
            DropDownSelectTableUpdate.DataTextField = "TABLE_NAME";
            DropDownSelectTableUpdate.DataValueField = "TABLE_NAME";
            DropDownSelectTableUpdate.DataBind();

            DropDownSelectTableDelete.DataSource = table;
            DropDownSelectTableDelete.DataTextField = "TABLE_NAME";
            DropDownSelectTableDelete.DataValueField = "TABLE_NAME";
            DropDownSelectTableDelete.DataBind();
            conn.Close();

            string str = DropDownSelectTableUpdate.SelectedValue.ToString();
            InflateColumnDropDowns(str, 0); //Initial Value for Update Queries - Table initial Inflate
            InflateColumnDropDowns(str, 1); //Initial Value for Delete Queries - Table initial Inflate
        }

        protected void InflateColumnDropDowns(string tblName, int updateOrDelete)
        {
            SqlCommand cmd = new SqlCommand("SELECT COLUMN_NAME  " +
                                            "FROM HospitalMS.INFORMATION_SCHEMA.COLUMNS " +
                                            "WHERE TABLE_NAME = '"+tblName+"'", conn);
            conn.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            
            if (updateOrDelete == 0)
            {
                DataTable table = new DataTable();
                table.Load(reader);

                DropDownListSelectWhereColumnUpdate.DataSource = table;
                DropDownListSelectWhereColumnUpdate.DataTextField = "COLUMN_NAME";
                DropDownListSelectWhereColumnUpdate.DataValueField = "COLUMN_NAME";
                DropDownListSelectWhereColumnUpdate.DataBind();

                DropDownSelectSetColumn.DataSource = table;
                DropDownSelectSetColumn.DataTextField = "COLUMN_NAME";
                DropDownSelectSetColumn.DataValueField = "COLUMN_NAME";
                DropDownSelectSetColumn.DataBind();

                conn.Close();
            }
            else if(updateOrDelete == 1)
            {
                DropDownListSelectWhereColumnDelete.DataSource = reader;
                DropDownListSelectWhereColumnDelete.DataTextField = "COLUMN_NAME";
                DropDownListSelectWhereColumnDelete.DataValueField = "COLUMN_NAME";
                DropDownListSelectWhereColumnDelete.DataBind();
                conn.Close();
            }
            
        }

        protected void Button_GotoSearch(object sender, EventArgs e)
        {
            Server.Transfer("Search.aspx");
        }

        protected void Button_ViewTable(object sender, EventArgs e)
        {
            ViewTable();
        }

        protected void Button_SignOut(object sender, EventArgs e)
        {
            divData.Visible = false;
            GridView1.Visible = false;
            divCred.Visible = true;
            ButtonSignout.Visible = false;
            TextBox1.Text = "";
            divCustomQueries.Visible = false;
        }

        protected void Button_CheckTrans(object sender, EventArgs e)
        {
            
            SqlCommand cmd = new SqlCommand("DBCC OPENTRAN WITH TABLERESULTS", conn);

            conn.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                transactionsLog.InnerText = "Running transaction at " + reader[1].ToString();
                ButtonKillTrans.Enabled = true;
                //ssid = Int32.Parse(reader[1].ToString());
            }
            else
            {
                transactionsLog.InnerText = "No transactions found at the moment";
            }

            conn.Close();
        }

        protected void Button_KillTrans(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand("DBCC OPENTRAN WITH TABLERESULTS", conn);

            conn.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            
            if (reader.Read())
            {
                transactionsLog.InnerText = "Running transaction at " + reader[1].ToString();
                ButtonKillTrans.Enabled = true;
                int ssid = Int32.Parse(reader[1].ToString());

                reader.Close();
                cmd = new SqlCommand("KILL " + ssid, conn);

                
                cmd.ExecuteNonQuery();
                transactionsLog.InnerText = "Killed Transaction at: " + ssid;
            }

            ButtonKillTrans.Enabled = false;

            conn.Close();

            
        }

        protected void DropDownSelectTableUpdate_SelectedIndexChanged(object sender, EventArgs e)
        {
            string str = DropDownSelectTableUpdate.SelectedValue.ToString();
            InflateColumnDropDowns(str, 0);
        }

        protected void DropDownSelectTableDelete_SelectedIndexChanged(object sender, EventArgs e)
        {
            string str = DropDownSelectTableDelete.SelectedValue.ToString();
            InflateColumnDropDowns(str, 1);
        }

        protected void ButtonExecUpdate_Click(object sender, EventArgs e)
        {
            string chosenTable = DropDownSelectTableUpdate.SelectedValue.ToString();
            string chosenSetColumn = DropDownSelectSetColumn.SelectedValue.ToString();
            string chosenWhereColumn = DropDownListSelectWhereColumnUpdate.SelectedValue.ToString();

            if (TextBoxUpdateSet.Text != String.Empty && TextBoxUpdateWhere.Text != String.Empty)
            {
                string inputSet = TextBoxUpdateSet.Text.ToString();
                string inputWhere = TextBoxUpdateWhere.Text.ToString();

                SqlCommand cmd = new SqlCommand("Update " + chosenTable + 
                                                " Set " + chosenSetColumn + " = "+ inputSet +
                                                " Where "+ chosenWhereColumn + " = " + inputWhere, conn);
                try
                {
                    conn.Open();
                    int result = cmd.ExecuteNonQuery();
                    conn.Close();
                    if (result == -1 || result == 0)
                    {
                        LogUpdate.InnerText = "No rows where updated.";
                    }
                    else
                    {
                        LogUpdate.InnerText = "Succeful Attempt, Check The table you update to make sure changes occured.";
                        ViewTable();        //refresh table after changes
                    }
                }
                catch
                {
                    LogUpdate.InnerText = "An SQL Error Occured, be sure to surround strings with 'singleQuotes' ";
                }
            }
            else
            {
                LogUpdate.InnerText = "All Fields are required.";
            }
        }

        protected void ButtonExecDelete_Click(object sender, EventArgs e)
        {
            string chosenTable = DropDownSelectTableDelete.SelectedValue.ToString();
            string chosenWhereColumn = DropDownListSelectWhereColumnDelete.SelectedValue.ToString();

            if (TextBoxDeleteWhere.Text != String.Empty)
            {
                string inputWhere = TextBoxDeleteWhere.Text.ToString();

                SqlCommand cmd = new SqlCommand("Delete From " + chosenTable +
                                                " Where " + chosenWhereColumn + " = " + inputWhere, conn);
                try
                {
                    conn.Open();
                    int result = cmd.ExecuteNonQuery();
                    conn.Close();
                    if (result == -1 || result == 0)
                    {
                        LogDelete.InnerText = "No rows where deleted.";
                    }
                    else
                    {
                        LogDelete.InnerText = "Succeful Attempt, Check The table you update to make sure changes occured.";
                        ViewTable();        //refresh table after changes
                    }
                }
                catch
                {
                    LogDelete.InnerText = "Could not delete this row because it is currently is use in another relation.";
                }
            }
            else
            {
                LogDelete.InnerText = "All Fields are required.";
            }
        }
    }
}