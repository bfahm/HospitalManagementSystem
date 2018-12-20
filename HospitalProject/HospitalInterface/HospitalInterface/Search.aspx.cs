using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace HospitalInterface
{
    public partial class Search : Page
    {
        SqlConnection conn = new SqlConnection("data source=DESKTOP-41PN3EM\\TESTINSTANCE; " +
            "database=HospitalMS; integrated security=SSPI");

        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        private void SearchPatient(int id, string name, string number)
        {
            SqlCommand cmd = new SqlCommand("sp_search_patients", conn);

            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            if (id != -1)
            {
                cmd.Parameters.AddWithValue("@Id", id);
            }
            if (!String.IsNullOrEmpty(name))
            {
                cmd.Parameters.AddWithValue("@Name", name);
            }
            if (!String.IsNullOrEmpty(number))
            {
                cmd.Parameters.AddWithValue("@Number", number);
            }

            

            SqlParameter outputParameter = new SqlParameter();
            outputParameter.ParameterName = "@Count";
            outputParameter.SqlDbType = System.Data.SqlDbType.Int;
            outputParameter.Direction = System.Data.ParameterDirection.Output;
            cmd.Parameters.Add(outputParameter);

            conn.Open();
            SqlDataReader rdr =  cmd.ExecuteReader();
            GridView1.DataSource = rdr;
            GridView1.DataBind();
            conn.Close();

            int log = Int32.Parse(outputParameter.Value.ToString());
            if (log == 0)
            {
                logText.Visible = true;
                logText.InnerText = "No patients found with these criteria..";
            }
            else
            {
                logText.Visible = false;
                logText.InnerText = "";
            }

            

            

            

            //return returnCount;
            
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            int intId;
            string strName;
            string strNumber;
            if(TextBox1.Text != String.Empty)
            {
                intId = Int32.Parse(TextBox1.Text.ToString());
                
            }
            else
            {
                intId = -1;
            }  
            if (TextBox2.Text != String.Empty)
            {
                strName = TextBox2.Text.ToString();
                
            }
            else
            {
                strName = "";
            }
            if(TextBox3.Text != String.Empty)
            {
                strNumber = TextBox3.Text.ToString();
            }
            else
            {
                strNumber = "";
            }

            SearchPatient(intId, strName, strNumber);
        }
    }
}