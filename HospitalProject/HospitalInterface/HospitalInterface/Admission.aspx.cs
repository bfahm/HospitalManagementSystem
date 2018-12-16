using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace HospitalInterface
{
    public partial class Admission : Page
    {

        SqlConnection conn = new SqlConnection("data source=DESKTOP-41PN3EM\\TESTINSTANCE; database=HospitalMS; integrated security=SSPI");

        protected void Page_Load(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand("SELECT DepName FROM Hos_Departments", conn);
            conn.Open();
            SqlDataReader reader = cmd.ExecuteReader();

            if (reader.HasRows)
            {
                int index = 0;
                while (reader.Read())
                {
                    ListItem toBeAdded = new ListItem(reader.GetString(0), index.ToString());
                    DropDownList1.Items.Add(toBeAdded);
                    index++;
                }
            }
            reader.Close();
            conn.Close();

            if (!IsPostBack)
            {
                if (Request.UrlReferrer != null)
                {
                    getDefaultPatient();
                }
                else
                {
                    TextBox2.Text = "";
                }
            }

        }

        protected void Button1_click(object sender, EventArgs e)
        {
            ShowData.Visible = true;


            int chosenRoomType = DropDownList2.SelectedIndex;
            switch (chosenRoomType)
            {
                case 0:
                    wardChosen();
                    break;
                case 1:
                    icuChosen();

                    break;
                case 2:
                    optChosen();
                    break;
            }

            refreshTable();

        }

        private void refreshTable()
        {
            SqlCommand cmd = new SqlCommand("SELECT e.Pid, e.Pname, e.PdayIn, e.Pdep, r.RmId FROM Ent_Patient e " +
                                            "LEFT JOIN Rel_AdmittedIn r " +
                                            "On e.Pid = r.Pid ", conn);
            conn.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            GridView1.DataSource = reader;
            GridView1.DataBind();
            conn.Close();
        }

        private void getDefaultPatient()
        {
            SqlCommand cmd = new SqlCommand("SELECT MAX(Pid) from Ent_Patient", conn);
            conn.Open();
            string reader = cmd.ExecuteScalar().ToString();
            TextBox2.Text = reader;
            conn.Close();
        }

        protected void wardChosen()
        {
            int departmentId = DropDownList1.SelectedIndex + 6000000;
            SqlCommand cmd = new SqlCommand("SELECT RmId from Hos_Room where RmType = 1 and RmDep = "
                                            + departmentId
                                            , conn);

            conn.Open();
            SqlDataReader reader = cmd.ExecuteReader();

            DropDownList3.DataSource = reader;
            DropDownList3.DataTextField = "RmId";
            DropDownList3.DataValueField = "RmId";
            DropDownList3.DataBind();
            conn.Close();


        }

        protected void optChosen()
        {
            int departmentId = DropDownList1.SelectedIndex + 6000000;
            SqlCommand cmd = new SqlCommand("SELECT RmId from Hos_Room where RmType = 3 and RmDep = "
                                            + departmentId
                                            , conn);

            conn.Open();
            SqlDataReader reader = cmd.ExecuteReader();

            DropDownList3.DataSource = reader;
            DropDownList3.DataTextField = "RmId";
            DropDownList3.DataValueField = "RmId";
            DropDownList3.DataBind();
            conn.Close();

        }

        protected void icuChosen()
        {
            int departmentId = DropDownList1.SelectedIndex + 6000000;
            SqlCommand cmd = new SqlCommand("SELECT RmId from Hos_Room where RmType = 2 and RmDep = "
                                            + departmentId
                                            , conn);

            conn.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            DropDownList3.DataSource = reader;
            DropDownList3.DataTextField = "RmId";
            DropDownList3.DataValueField = "RmId";
            DropDownList3.DataBind();
            conn.Close();

        }

        protected void Button2_click(object sender, EventArgs e)
        {
            int Pid;
            int RmId;
            if (string.IsNullOrWhiteSpace(TextBox2.Text))
            {
                logText.InnerText = "Error: Please enter a patient ID first";
            }
            else
            {
                Pid = Int32.Parse(TextBox2.Text);
                RmId = Int32.Parse(DropDownList3.SelectedValue);
                int departmentId = DropDownList1.SelectedIndex + 6000000;

                SqlCommand cmd;
                conn.Open();
                SqlTransaction transaction = null;
                try
                {
                    transaction = conn.BeginTransaction();

                    try
                    {
                        cmd = new SqlCommand("INSERT INTO Rel_AdmittedIn VALUES (" + RmId + "," + Pid + ")", conn, transaction);
                        cmd.ExecuteNonQuery();

                        logText.InnerText = "Patient Admitted Succefully in Room Id: " + RmId;
                    }
                    catch
                    {
                        cmd = new SqlCommand("Update Rel_AdmittedIn Set RmId = " + RmId + "WHERE Pid = " + Pid, conn, transaction);
                        cmd.ExecuteNonQuery();

                        logText.InnerText = "Patient was found in another room and was transfered to Room Id: " + RmId;
                    }

                    cmd = new SqlCommand("Update Ent_Patient Set Pdep =" + departmentId + " where Pid =" + Pid, conn, transaction);
                    cmd.ExecuteNonQuery();
                    transaction.Commit();
                    conn.Close();

                    logText.InnerText += " \nPatient Table Updated Succefully";


                }
                catch
                {
                    transaction.Rollback();
                    conn.Close();
                    logText.InnerText = "Some SQL Error Happened, Function: Button2_Click";

                }


                refreshTable();
            }
        }
    }
}