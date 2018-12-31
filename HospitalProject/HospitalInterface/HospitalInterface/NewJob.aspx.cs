using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace HospitalInterface
{
    public partial class NewJob : Page
    {
        SqlConnection conn = new SqlConnection("data source=DESKTOP-41PN3EM\\TESTINSTANCE; database=HospitalMS; integrated security=SSPI");

        int docOrNurse;
        int masterID;
        int patID;
        string treatmentNotes = "";


        protected void Page_Load(object sender, EventArgs e)
        {
           
        }

        protected void processDoctorsandNurses(int docOrNurse)
        {
            DoctorNurse.Visible = true;
            //hide another divs

            int userId = Int32.Parse(TextBox1.Text);

            
            if (docOrNurse == 0) {
                TextBox3.Visible = true;
                conn.Open();
                Tuple<string, int> feedBack = loginAndRecieveData("DocName, WorksIn", "Ent_Doctor", "DocId", userId.ToString());
                conn.Close();
                string username = feedBack.Item1;
                int depId = feedBack.Item2;
                string depName = figureOutDepName(depId);

                autoShowData.InnerText = "Username: " + username;
                autoShowData.InnerText += "\n";
                autoShowData.InnerText += "Assigned Department: " + depName;
                autoShowData.InnerText += "\n";
                autoShowData.InnerText += "Main Job: " + "Doctor";

                SqlCommand cmd = new SqlCommand("SELECT Pname, Pnumber, Pdisease, PdayIn, Treatment" +
                                            " FROM Ent_Patient " +
                                            " INNER JOIN Rel_Treats " +
                                            " ON Rel_Treats.Pid = Ent_Patient.Pid " +
                                            " WHERE DocId = " + userId + " AND PisAssigned = 1", conn);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                GridView1.DataSource = reader;
                GridView1.DataBind();
                conn.Close();

                cmd = new SqlCommand("SELECT Pid, Pname, Pnumber, Pdisease, PdayIn" +
                                            " FROM Ent_Patient " +
                                            " WHERE Pdep = " + depId + " AND PisAssigned = 0", conn);
                conn.Open();
                reader= cmd.ExecuteReader();
                GridView2.DataSource = reader;
                GridView2.DataBind();
                conn.Close();

                masterID = userId;
                docOrNurse = 0;


            }
            else if (docOrNurse == 1)
            {
                TextBox3.Visible = false;
                conn.Open();
                Tuple<string, int> feedBack = loginAndRecieveData("NurName, WorksIn", "Ent_Nurse", "NurId", userId.ToString());
                conn.Close();

                string username = feedBack.Item1;
                int depId = feedBack.Item2;
                string depName = figureOutDepName(depId);

                autoShowData.InnerText = "Username: " + username;
                autoShowData.InnerText += "\n";
                autoShowData.InnerText += "Assigned Department: " + depName;
                autoShowData.InnerText += "\n";
                autoShowData.InnerText += "Main Job: " + "Nurse";

                SqlCommand cmd = new SqlCommand("SELECT Pname, Pnumber, Pdisease, PdayIn" +
                                            " FROM Ent_Patient " +
                                            " INNER JOIN Rel_Serves " +
                                            " ON Rel_Serves.Pid = Ent_Patient.Pid " +
                                            " WHERE NurId = " + userId, conn);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                GridView1.DataSource = reader;
                GridView1.DataBind();
                conn.Close();

                cmd = new SqlCommand("SELECT p.* FROM  Ent_Patient p "+
                                      " left outer join Rel_Serves r "+
                                      " on p.Pid = r.Pid " + 
                                      " where r.Pid is null and p.Pdep = "+depId, conn);
                conn.Open();
                reader = cmd.ExecuteReader();
                GridView2.DataSource = reader;
                GridView2.DataBind();
                conn.Close();

                masterID = userId;
                docOrNurse = 1;

            }
        }

        private string figureOutDepName(int depId)
        {
            SqlCommand cmd = new SqlCommand("SELECT DepName " + " FROM Hos_Departments WHERE DepId = " + depId, conn);
            conn.Open();
            string returnValue;
            if (cmd.ExecuteScalar() != null) { 
                returnValue = cmd.ExecuteScalar().ToString();
            }
            else
            {
                returnValue = "ID NOT FOUND";
            }
            conn.Close();
            return returnValue;
        }

        private Tuple<string, int> loginAndRecieveData(string selection, string source, string id, string key)
        {
            
            SqlCommand cmd = new SqlCommand("SELECT " + selection + " FROM " + source + " WHERE " + id + " = " + key, conn);
            SqlDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
            {
                string username = reader.GetString(0);
                int depName = reader.GetInt32(1);

                logText.InnerText = "";
                autoShowData.Visible = true;
                DoctorNurse.Visible = true;
                return Tuple.Create(username, depName);

            }
            DoctorNurse.Visible = false;
            autoShowData.Visible = false;
            return Tuple.Create(" ", -1); ;
        }

        protected void processPatients()
        {
            //show the div
            DoctorNurse.Visible = false;
            //hide another divs
        }

        protected void processAdmins()
        {
            //show the div
            DoctorNurse.Visible = false;
            //hide another divs
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            
            int returnResults = 0;
            string inputId = TextBox1.Text.ToString();
            int identifier = Int32.Parse(inputId.Substring(0, 1));
            if (identifier == 2)
            {
                docOrNurse = 0;
                masterID = Int32.Parse(TextBox1.Text.ToString());
            }
            else
            {
                docOrNurse = 1;
                masterID = Int32.Parse(TextBox1.Text.ToString());
            }
            System.Diagnostics.Debug.WriteLine(docOrNurse);
            System.Diagnostics.Debug.WriteLine(masterID);
            if (docOrNurse == 0)
            {
                System.Diagnostics.Debug.Write("EnteredDocSubmit");
                conn.Open();
                SqlTransaction transaction = conn.BeginTransaction();
                try
                {
                    patID = Int32.Parse(TextBox2.Text);
                    treatmentNotes = TextBox3.Text.ToString();

                    SqlCommand cmd = new SqlCommand("Update Ent_Patient Set PisAssigned = 1 Where Pid = " + patID, conn, transaction);
                    cmd.ExecuteNonQuery();
                    cmd = new SqlCommand("Insert Into Rel_Treats Values(" + masterID + " , " + patID + " , " +"'"+ treatmentNotes + "'" + ")", conn, transaction);
                    cmd.ExecuteNonQuery();
                    transaction.Commit();
                    returnResults = 1;

                    
                }
                catch
                {
                    logText.Visible = true;
                    logText.InnerText = "SQL Error, Check if textbox is empty";
                    transaction.Rollback();
                    returnResults = -1;
                }
                
                conn.Close();
                processDoctorsandNurses(docOrNurse);
            }
            else if (docOrNurse == 1)
            {
                patID = Int32.Parse(TextBox2.Text.ToString());
                
                conn.Open();

                SqlCommand cmd = new SqlCommand("Insert Into Rel_Serves Values(" + masterID + " , " + patID + ")", conn);
                returnResults = cmd.ExecuteNonQuery();

                conn.Close();
                processDoctorsandNurses(docOrNurse);
            }

            //return returnResults;
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            if (TextBox1.Text != String.Empty)
            {
                string inputId = TextBox1.Text.ToString();
                int identifier = Int32.Parse(inputId.Substring(0, 1));

                switch (identifier)
                {
                    case 2:
                        System.Diagnostics.Debug.WriteLine("doctor selected");
                        docOrNurse = 0;
                        logText.InnerText = "Wrong ID";
                        processDoctorsandNurses(0);
                        break;
                    case 3:
                        System.Diagnostics.Debug.WriteLine("nurse selected");
                        docOrNurse = 1;
                        logText.InnerText = "Wrong ID";
                        processDoctorsandNurses(1);
                        break;
                    default:
                        logText.InnerText = "Wrong ID";
                        break;
                }
            }
            else
            {
                logText.InnerText = "Please Input an ID First";
            }
        }
    }
}