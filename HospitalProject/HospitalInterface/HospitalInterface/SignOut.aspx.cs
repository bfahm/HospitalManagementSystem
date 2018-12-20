using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace HospitalInterface
{
    public partial class SignOut : Page
    {   
        SqlConnection conn = new SqlConnection("data source=DESKTOP-41PN3EM\\TESTINSTANCE; " +
            "database=HospitalMS; integrated security=SSPI");

        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        private int RetrievePatientData(int patientId)
        {
            SqlCommand cmd = new SqlCommand("Select * From Ent_Patient Where Pid = " + patientId, conn);
            conn.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            GridView1.DataSource = rdr;
            GridView1.DataBind();
            conn.Close();
            
            cmd = new SqlCommand("Select COUNT(*) From Ent_Patient Where Pid = " + patientId, conn);
            conn.Open();
            int returnCount = Int32.Parse(cmd.ExecuteScalar().ToString());
            conn.Close();

            return returnCount;
        }

        private int RetrieveRelatedDoctorData(int patientId)
        {
            SqlCommand cmd = new SqlCommand("SELECT e.DocId, e.DocName, r.Treatment From Rel_Treats r " +
                                            "LEFT JOIN Ent_Doctor e " +
                                            "ON r.DocId = e.DocId " +
                                            "WHERE r.Pid = " + patientId, conn);

            conn.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            if (rdr.Read())
            {
                divDocData.Visible = true;
                tvDocId.InnerText = rdr[0].ToString();
                tvDocName.InnerText += rdr[1].ToString();
                tvTreatment.InnerText = rdr[2].ToString();
                conn.Close();
                return 1;
            }
            else
            {
                conn.Close();
                return -1;
            } 
        }

        private int RetrieveRelatedNurseData(int patientId)
        {
            SqlCommand cmd = new SqlCommand("SELECT e.NurId, e.NurName From Rel_Serves r " +
                                            "LEFT JOIN Ent_Nurse e " +
                                            "ON r.NurId = e.NurId " +
                                            "WHERE r.Pid = " + patientId, conn);

            conn.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            GridView2.Visible = true;
            tvNurseHeader.Visible = true;
            GridView2.DataSource = rdr;
            GridView2.DataBind();
            conn.Close();

            cmd = new SqlCommand("SELECT COUNT(*) FROM (" +
                                 "SELECT e.NurId, e.NurName From Rel_Serves r " +
                                 "LEFT JOIN Ent_Nurse e " +
                                 "ON r.NurId = e.NurId " +
                                 "WHERE r.Pid = " + patientId + 
                                 ") x ", conn);
            conn.Open();
            int returnCount = Int32.Parse(cmd.ExecuteScalar().ToString());
            conn.Close();

            return returnCount;

        }

        private int RetrieveoomData(int patientId)
        {
            SqlCommand cmd = new SqlCommand("SELECT r.RmId, h.RmType From Rel_AdmittedIn r " +
                                            "LEFT JOIN Hos_Room h " +
                                            "ON r.RmId = h.RmId " +
                                            "WHERE r.Pid = " + patientId, conn);

            conn.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            if (rdr.Read())
            {
                divRoomData.Visible = true;
                tvRoomId.InnerText = rdr[0].ToString();
                int rmType = Int32.Parse(rdr[1].ToString());
                tvRoomType.InnerText = "Of Type: ";
                switch (rmType)
                {
                    case 1:
                        tvRoomType.InnerText += "Ward";
                        break;
                    case 2:
                        tvRoomType.InnerText += "ICU";
                        break;
                    case 3:
                        tvRoomType.InnerText += "Operation Theatre";
                        break;
                }
                
                conn.Close();
                return 1;
            }
            else
            {
                conn.Close();
                return -1;
            }
        }

        private void RetrieveBillData(int patientId)
        {
            SqlCommand cmd = new SqlCommand("sp_calculate_days_till_date", conn);

            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@PatientID", patientId);

            conn.Open();
            int returnValue = Int32.Parse(cmd.ExecuteScalar().ToString());
            conn.Close();

            tvDays.InnerText = "" + returnValue;
            tvBill.InnerText = "" + returnValue * 500;
        }

        private int DisAdmitAPatient(int patientId)
        {
            SqlCommand cmd = new SqlCommand("sp_disadmit_patient", conn);

            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            
            SqlParameter outputParameter = new SqlParameter();
            outputParameter.ParameterName = "@output";
            outputParameter.SqlDbType = System.Data.SqlDbType.Int;
            outputParameter.Direction = System.Data.ParameterDirection.Output;

            cmd.Parameters.AddWithValue("@PatientID", patientId);
            cmd.Parameters.Add(outputParameter);

            conn.Open();
            cmd.ExecuteNonQuery();
            int returnStatus = Int32.Parse(outputParameter.Value.ToString());
            conn.Close();

            return returnStatus;
        }

        private void ResetData(int whatToReset)
        {
            switch (whatToReset)
            {
                case 0:
                    tvDocId.InnerText = "";
                    tvDocName.InnerText = "Doctor ";
                    tvTreatment.InnerText = "";
                    divDocData.Visible = false;
                    break;
                case 1:
                    tvNurseHeader.Visible = false;
                    GridView2.Visible = false;
                    break;
                case 2:
                    divRoomData.Visible = false;
                    tvRoomId.InnerText = "";
                    tvRoomType.InnerText = "Of type: ";
                    break;
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            try {
                int patID = Int32.Parse(patientIdBox.Text);
                int returnCount = RetrievePatientData(patID);
                if (returnCount > 0)
                {
                    returnData.Visible = true;
                    int returnDocData = RetrieveRelatedDoctorData(patID);
                    int returnNurData = RetrieveRelatedNurseData(patID);
                    int returnRmData  = RetrieveoomData(patID);
                    RetrieveBillData(patID);

                    logText.InnerText = "Found Patient!";

                    if (returnDocData != 1)
                    {
                        ResetData(0);
                        logText.InnerText += "\n";
                        logText.InnerText += "Patient is not assigned to a Doctor";
                    }
                    if(returnNurData < 1)
                    {
                        ResetData(1);
                        logText.InnerText += "\n";
                        logText.InnerText += "Patient is not assigned to a Nurse";
                    }
                    if (returnRmData != 1)
                    {
                        ResetData(2);
                        logText.InnerText += "\n";
                        logText.InnerText += "Patient is not admitted in a Room";
                    }
                }
                else
                {
                    returnData.Visible = false;
                    logText.InnerText = "No data found for that ID ";
                }
            }
            catch {
                returnData.Visible = false;
                logText.InnerText = "ERROR: Attempt not succeful, make sure to enter id first";
            }
            
            
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            try
            {
                int patID = Int32.Parse(patientIdBox.Text);
                patientIdBox.Text = " ";
                DisAdmitAPatient(patID);
                RetrievePatientData(patID);
                RetrieveRelatedDoctorData(patID);
                RetrieveRelatedNurseData(patID);
                RetrieveoomData(patID);
                ResetData(0);
                ResetData(1);
                ResetData(2);
                logText.InnerText = "Patient Succefully Discharged From the Hospital Database";
            }
            catch
            {
                logText.InnerText = "Something went wrong while discharging this patient, refer to Admin Panel to fix this issue.";
            }
        }
    }
}