using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace HospitalInterface
{
    public partial class Registeration : Page
    {
        SqlConnection conn = new SqlConnection("data source=DESKTOP-41PN3EM\\TESTINSTANCE; database=HospitalMS; integrated security=SSPI");

        protected void Page_Load(object sender, EventArgs e)
        {
            int chosenForm = 0;
            chosenForm = DropDownList1.SelectedIndex;
            switch (chosenForm)
            {
                case 0:
                    DoctorNurse.Visible = false;
                    Patient.Visible = false;
                    Ward.Visible = false;
                    break;
                case 1:
                    onDoctorNurseSelection();
                    break;
                case 2:
                    onPatientSelection();
                    break;
                case 3:
                    onWardSelection();
                    break;
                case 4:
                    break;
            }

        }
        ////////////////////////////////////Doctor Selection////////////////////////////////

        protected void onDoctorNurseSelection()
        {
            DoctorNurse.Visible = true;
            Patient.Visible = false;
            Ward.Visible = false;

            // first inflate the latest department ids to choose from

            
            SqlCommand cmd = new SqlCommand("SELECT DepName FROM Hos_Departments", conn);
            conn.Open();
            SqlDataReader reader = cmd.ExecuteReader();

            if (reader.HasRows)
            {
                int index = 0;
                while (reader.Read())
                {
                    ListItem toBeAdded = new ListItem(reader.GetString(0), index.ToString());
                    DropDownList2.Items.Add(toBeAdded);
                    index++;
                }
            }
            reader.Close();
            conn.Close();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            //button that submits a new doctor

            string username = TextBox1.Text.ToString();
            int departmentId = DropDownList2.SelectedIndex + 6000000;
            int selectedOption = RadioButtonList1.SelectedIndex;

            if (username.Length == 0)
            {
                selectedOption = -1;
            }

            
            SqlCommand cmd;
            int result = 0;
            Int32 returnId;

            conn.Open();

            if (selectedOption == 0)
            {
                cmd = new SqlCommand("INSERT INTO Ent_Doctor Values(" +
                    "'" + username + "', " +
                    departmentId + ")"
                    , conn);

                result = cmd.ExecuteNonQuery();

                cmd = new SqlCommand("SELECT TOP 1 DocId FROM Ent_Doctor ORDER BY DocId DESC", conn);
                cmd.ExecuteScalar();
                returnId = Convert.ToInt32(cmd.ExecuteScalar());
                logText.InnerText = "Succeful Attempt: ID of process: " + returnId.ToString();
            }
            else if (selectedOption == 1)
            {
                cmd = new SqlCommand("INSERT INTO Ent_Nurse Values(" +
                    "'" + username + "', " +
                    departmentId + ")"
                    , conn);

                result = cmd.ExecuteNonQuery();

                cmd = new SqlCommand("SELECT TOP 1 NurId FROM Ent_Nurse ORDER BY NurId DESC", conn);
                returnId = Convert.ToInt32(cmd.ExecuteScalar());
                logText.InnerText = "Succeful Attempt: ID of process: " + returnId.ToString();
            }
            else
            {
                logText.InnerText = "Error: You must choose a profession first, and enter a valid Name";
                result = -2; // to get out of the next if block, 
                             //since an error occured, not need to print that no value was added.
            }

            conn.Close();

            if (result == -1 || result == 0)
            {
                logText.InnerText = "Error: Value was not added to database";
            }

            TextBox1.Text = "";
            DropDownList2.SelectedIndex = 0;


        }


        /////////////////////////patinet_selection////////////////////////////////////////////

        protected void onPatientSelection()
        {
            Patient.Visible = true;
            DoctorNurse.Visible = false;
            Ward.Visible = false;


            // first inflate the latest department ids to choose from


            //SqlCommand cmd = new SqlCommand("SELECT DepName FROM Hos_Departments", conn);
            //conn.Open();
            //SqlDataReader reader = cmd.ExecuteReader();

            
            //reader.Close();
            //conn.Close();
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            //button that submits a new patinet

            string username = TextBox2.Text.ToString();
            string number = TextBox3.Text.ToString();
            string Disease = TextBox4.Text.ToString();
            
            if (string.IsNullOrWhiteSpace(username)|| string.IsNullOrWhiteSpace(number) || 
                string.IsNullOrWhiteSpace(Disease))
            {
                logText.InnerText = "All fields are required, Please fill them first.";
            }
            else
            {
                SqlCommand cmd;
                int result = 0;
                Int32 returnId;

                conn.Open();


                cmd = new SqlCommand("INSERT INTO Ent_Patient (Pname, Pnumber, Pdisease) Values(" +
                        "'" + username + "', '" +
                        number + "', '" + Disease + "')", conn);


                result = cmd.ExecuteNonQuery();

                cmd = new SqlCommand("SELECT TOP 1 Pid FROM Ent_Patient ORDER BY Pid DESC", conn);
                cmd.ExecuteScalar();
                returnId = Convert.ToInt32(cmd.ExecuteScalar());



                conn.Close();

                if (result == -1 || result == 0)
                {
                    logText.InnerText = "Error: Value was not added to database";
                }
                else
                {
                    logText.InnerText = "Succeful Attempt: ID of process: " + returnId.ToString();
                }

                TextBox2.Text = "";
                TextBox3.Text = "";
                TextBox4.Text = "";
                
            }
        }

        //////////////////////////////////WardBoy Selection///////////////////////////////////

        protected void onWardSelection()
        {
            Ward.Visible = true;
            DoctorNurse.Visible = false;
            Patient.Visible = false;


            // first inflate the latest Rooms ids to choose from

            
            SqlCommand cmd = new SqlCommand("SELECT RmId FROM Hos_Room", conn);
            conn.Open();
            SqlDataReader reader = cmd.ExecuteReader();

            if (reader.HasRows)
            {
                int index = 0;
                while (reader.Read())
                {
                    ListItem toBeAdded = new ListItem(reader.GetInt32(0).ToString(), index.ToString());
                    DropDownList4.Items.Add(toBeAdded);
                    index++;
                }
            }
            reader.Close();
            conn.Close();
        }

        protected void Button4_Click(object sender, EventArgs e)
        {
            //button that submits a new patinet

            string username = TextBox5.Text.ToString();
            int roomId = DropDownList4.SelectedIndex + 5000000;

            if (string.IsNullOrWhiteSpace(username))
            {
                logText.InnerText = "Please enter a name first!";
            }
            else
            {
                SqlCommand cmd;
                int result = 0;
                Int32 returnId;

                conn.Open();


                cmd = new SqlCommand("INSERT INTO Ent_Wardboy Values(" +
                        "'" + username + "', '" + roomId + "')"
                        , conn);


                result = cmd.ExecuteNonQuery();

                cmd = new SqlCommand("SELECT TOP 1 WarId FROM Ent_Wardboy ORDER BY WarId DESC", conn);
                cmd.ExecuteScalar();
                returnId = Convert.ToInt32(cmd.ExecuteScalar());



                conn.Close();

                if (result == -1 || result == 0)
                {
                    logText.InnerText = "Error: Value was not added to database";
                }
                else
                {
                    logText.InnerText = "Succeful Attempt: ID of process: " + returnId.ToString();
                }

                TextBox5.Text = "";
                DropDownList4.SelectedIndex = 0;
            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            logText.InnerText = "";
        }

        protected void Button5_Click(object sender, EventArgs e)
        {
            Server.Transfer("Admission.aspx");
            //Response.Redirect("Admission.aspx");
        }
    }
}