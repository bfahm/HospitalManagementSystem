using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

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



        protected void Btn_Login(object sender, EventArgs e)
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
                Button4.Visible = true;
            }
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            Server.Transfer("Search.aspx");
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            ViewTable();
        }

        protected void Button4_Click(object sender, EventArgs e)
        {
            divData.Visible = false;
            GridView1.Visible = false;
            divCred.Visible = true;
            Button4.Visible = false;
            TextBox1.Text = "";
        }

        protected void Button5_Click(object sender, EventArgs e)
        {
            
            SqlCommand cmd = new SqlCommand("DBCC OPENTRAN WITH TABLERESULTS", conn);

            conn.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                transactionsLog.InnerText = "Running transaction at " + reader[1].ToString();
                Button6.Enabled = true;
                //ssid = Int32.Parse(reader[1].ToString());
            }
            else
            {
                transactionsLog.InnerText = "No transactions found at the moment";
            }

            conn.Close();
        }

        protected void Button6_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand("DBCC OPENTRAN WITH TABLERESULTS", conn);

            conn.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            
            if (reader.Read())
            {
                transactionsLog.InnerText = "Running transaction at " + reader[1].ToString();
                Button6.Enabled = true;
                int ssid = Int32.Parse(reader[1].ToString());

                reader.Close();
                cmd = new SqlCommand("KILL " + ssid, conn);

                
                cmd.ExecuteNonQuery();
                transactionsLog.InnerText = "Killed Transaction at: " + ssid;
            }

            Button6.Enabled = false;

            conn.Close();

            
        }
    }
}