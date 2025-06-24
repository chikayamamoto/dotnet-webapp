using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace スマホ
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        private const int PageSize = 4;

        protected int CurrentPage
        {
            get
            {
                object obj = ViewState["CurrentPage"];
                if (obj != null && int.TryParse(obj.ToString(), out int page) && page > 0)
                    return page;
                return 1;
            }
            set
            {
                ViewState["CurrentPage"] = value;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

                BindSensors();
            
        }

        private void BindSensors()
        {
            DataTable dt = GetSensorData();
            int total = dt.Rows.Count;
            int pageCount = (int)Math.Ceiling((double)total / PageSize);

            // ページ範囲の補正
            if (pageCount == 0) CurrentPage = 1;
            if (CurrentPage > pageCount) CurrentPage = pageCount;
            if (CurrentPage < 1) CurrentPage = 1;

            // ページング
            DataTable pageTable = dt.Clone();
            int start = (CurrentPage - 1) * PageSize;
            for (int i = start; i < start + PageSize && i < total; i++)
            {
                pageTable.ImportRow(dt.Rows[i]);
            }
            sensorRepeater.DataSource = pageTable;
            sensorRepeater.DataBind();

            // ページャー生成（5個以上のときのみ）
            phPager.Controls.Clear();
            if (total > 4 && pageCount > 1)
            {
                for (int i = 1; i <= pageCount; i++)
                {
                    var btn = new LinkButton
                    {
                        Text = i.ToString(),
                        CommandArgument = i.ToString(),
                        CssClass = (i == CurrentPage) ? "active-page" : ""
                    };
                    btn.Click += Pager_Click;
                    phPager.Controls.Add(btn);

                    if (i < pageCount)
                        phPager.Controls.Add(new Literal { Text = " " });
                }
            }
        }

        protected void Pager_Click(object sender, EventArgs e)
        {
            var btn = (LinkButton)sender;
            if (int.TryParse(btn.CommandArgument, out int page))
            {
                CurrentPage = page;
                BindSensors();
            }
        }

        private DataTable GetSensorData()
        {
            string connStr = ConfigurationManager.ConnectionStrings["Connection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string sql = "SELECT SensorName, Value, Unit FROM Sensors";
                SqlDataAdapter da = new SqlDataAdapter(sql, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                return dt;
            }
        }
    }
}