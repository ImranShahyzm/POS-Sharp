using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading.Tasks;
using System.Web;
using System.Xml;
using System.Xml.Serialization;

namespace POS.Helper
{
    public static class STATICClass
    {
        public static string BaseURL= "http://103.86.135.182:1034/";
        public static string Connection()
        {
            return ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
        }

        public static List<T> ConvertToList<T>(DataTable dt)
            {
                var columnNames = dt.Columns.Cast<DataColumn>().Select(c => c.ColumnName.ToLower()).ToList();
                var properties = typeof(T).GetProperties();
                return dt.AsEnumerable().Select(row => {
                    var objT = Activator.CreateInstance<T>();
                    foreach (var pro in properties)
                    {
                        if (columnNames.Contains(pro.Name.ToLower()))
                        {
                            try
                            {
                                pro.SetValue(objT, row[pro.Name]);
                            }
                            catch (Exception ex) { }
                        }
                    }
                    return objT;
                }).ToList();
            }
        public static DataSet SelectAll(string StoredProcedureName, List<SqlParameter> list)
        {
            DataSet ds = new DataSet(); SqlConnection con = new SqlConnection(STATICClass.Connection());
            SqlCommand cmd = new SqlCommand(StoredProcedureName, con);
            try
            {
                cmd.CommandType = CommandType.StoredProcedure;
                SqlDataAdapter da = new SqlDataAdapter();
                foreach (var item in list)
                {
                    cmd.Parameters.Add(item);
                }
                da.SelectCommand = cmd;

                da.Fill(ds);
                return ds;
            }
            catch (Exception ex)
            {
                throw;
            }
            finally
            {
                con.Close();
                cmd.Parameters.Clear();
            }
        }
        public static DataTable ExecuteDelete(string StoredProcedureName, List<SqlParameter> list)
        {
            DataTable dt = new DataTable(); string MESSAGE = "Deleted";
            SqlConnection con = new SqlConnection(STATICClass.Connection()); SqlTransaction tran; con.Open(); tran = con.BeginTransaction();
            SqlCommand cmd = new SqlCommand(StoredProcedureName, con);
            cmd.CommandType = CommandType.StoredProcedure; SqlDataAdapter da = new SqlDataAdapter();
            foreach (var item in list)
            {
                cmd.Parameters.Add(item);
            }
            da.SelectCommand = cmd;
            DataTable Ret = new DataTable();
            Ret.Columns.Add("MESSAGE");
            DataRow dr = Ret.NewRow();
            try
            {
                cmd.Transaction = tran; da.Fill(dt); tran.Commit();
            }
            catch (Exception ex)
            {
                tran.Rollback(); MESSAGE = ex.Message;
            }
            finally
            {
                con.Close();

            }
            dr["MESSAGE"] = MESSAGE;
            Ret.Rows.Add(dr);
            return Ret; ;
        }

        public static DataTable ExecuteInsert(string StoredProcedureName, List<SqlParameter> list)
        {
            DataTable dt = new DataTable();
            SqlConnection con = new SqlConnection(STATICClass.Connection()); SqlTransaction tran; con.Open(); tran = con.BeginTransaction();
            SqlCommand cmd = new SqlCommand(StoredProcedureName, con);
            cmd.CommandType = CommandType.StoredProcedure; SqlDataAdapter da = new SqlDataAdapter();
            foreach (var item in list)
            {
                cmd.Parameters.Add(item);
            }
            da.SelectCommand = cmd;
            DataTable Ret = new DataTable();
            Ret.Columns.Add("ErrorMsg");
            Ret.Columns.Add("NoError");
            DataRow dr = Ret.NewRow();
            try
            {
                cmd.Transaction = tran;
                cmd.CommandTimeout = 180;
                da.Fill(dt); tran.Commit();
                foreach (var item in list)
                {
                    if (item.Direction == ParameterDirection.InputOutput)
                    {
                        Ret.Columns.Add(item.ParameterName);
                        dr[item.ParameterName] = item.Value.ToString();
                    }
                }
                dr["NoError"] = true;
            }
            catch (Exception ex)
            {
                tran.Rollback();
                dr["ErrorMsg"] = ex.Message; dr["NoError"] = false;
            }
            finally
            {
                con.Close();
            }
            Ret.Rows.Add(dr);
            return Ret;

        }
        public static DataTable ConvertjarraytoDT(this DataTable dt, string DetailDataTable)
        {
            try
            {
                string Str = JsonConvert.DeserializeObject(DetailDataTable).ToString();
                DataRow dr;
                JArray jarr = JArray.Parse(Str);

                foreach (JObject content in jarr.Children<JObject>())
                {
                    foreach (JProperty prop in content.Properties())
                    {
                        dt.Columns.Add(prop.Name);
                    }
                    break;
                }

                foreach (JObject content in jarr.Children<JObject>())
                {
                    dr = dt.NewRow();
                    foreach (JProperty prop in content.Properties())
                    {
                        if (dr.Table.Columns.Contains(prop.Name) == true && prop.Value != null && prop.Value.ToString() != "")
                        {
                            dr[prop.Name] = prop.Value;
                        }
                    }
                    dt.Rows.Add(dr);
                }
                return dt;
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        public static async Task GetStokcIssue()
        {



            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(BaseURL);
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

                HttpResponseMessage response;
                try
                {
                    var id = 0;
                    //id == 0 means select all records    
                    if (id == 0)
                    {
                        response = await client.GetAsync("apipos/GetStockIssuance?CompanyID="+CompanyInfo.CompanyID+"&BranchID="+CompanyInfo.BranchID+"&WHID="+CompanyInfo.WareHouseID+"");
                        if (response.IsSuccessStatusCode)
                        {
                            data_StockTransferInfoModel scp = new data_StockTransferInfoModel();
                            XmlSerializer serializer = new XmlSerializer(typeof(data_StockTransferInfoModel));
                            var abc=response.Content.ToString();
                            using (Stream stream = response.Content.ReadAsStreamAsync().Result)
                            {
                                string json = new StreamReader(stream).ReadToEnd();

                                DataTable dt = new DataTable();
                                dt.ConvertjarraytoDT(json);
                               scp.InsertRawFromAPI(dt);
                            }
                           // data_StockTransferInfoModel[] reports = await response.Content.ReadAsAsync<data_StockTransferInfoModel[]>();

                        }
                    }
                    else
                    {

                    }
                }catch(Exception e)
                {
                    var Temp = e.Message; 
                }
                var i = 0;
            }




        }

        public static  async Task<DataTable>GETStockDetail(int StockID)
        {

            DataTable dt = new DataTable();

            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(BaseURL);
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

                HttpResponseMessage response;
                try
                {
                    var id = 0;
                    //id == 0 means select all records    
                    if (id == 0)
                    {
                        response = await client.GetAsync("apipos/GetStockIssuanceDetail?StockTransferID="+ StockID + "");
                        if (response.IsSuccessStatusCode)
                        {
                            data_StockTransferInfoModel scp = new data_StockTransferInfoModel();
                            XmlSerializer serializer = new XmlSerializer(typeof(data_StockTransferInfoModel));
                            var abc = response.Content.ToString();
                            using (Stream stream = response.Content.ReadAsStreamAsync().Result)
                            {
                                string json = new StreamReader(stream).ReadToEnd();

                                dt.ConvertjarraytoDT(json);

                                scp.InsertRawDetailFromAPI(dt, StockID);
                                return dt;
                               // scp.InsertRawFromAPI(dt);
                            }
                            // data_StockTransferInfoModel[] reports = await response.Content.ReadAsAsync<data_StockTransferInfoModel[]>();

                        }
                    }
                    else
                    {
                        return dt;
                    }
                }
                catch (Exception e)
                {
                    var Temp = e.Message;
                }
                var i = 0;
            }
            return dt;




        }



        public static async Task<string> InsertAllStockArrivaltoServer(string JsonDataStr)
        {

          
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(BaseURL);
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

                HttpResponseMessage response;
                try
                {
                    var id = 0;
                    //id == 0 means select all records    
                    if (id == 0)
                    {
                        response = await client.GetAsync("apipos/SetStockArrivalInsertion?JsonDataStr=" + JsonDataStr + "");
                        if (response.IsSuccessStatusCode)
                        {
                           
                            var abc = response.Content.ToString();
                            using (Stream stream = response.Content.ReadAsStreamAsync().Result)
                            {
                                string json = new StreamReader(stream).ReadToEnd();


                                return json;
                              
                            }
                          
                        }
                    }
                    
                }
                catch (Exception e)
                {
                    var Temp = e.Message;
                    return Temp;
                }
                var i = 0;
            }
            return "NoRecordsTransferrred";
          




        }



        public static async Task<string> InsertAllSalesAndReturntoServer(string JsonInvoiceStr,string DateFrom,string DateTo,string WHID,string CompanyID)
        {


            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(BaseURL);
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

                HttpResponseMessage response;
                try
                {
                    var id = 0;
                    //id == 0 means select all records    
                    if (id == 0)
                    {
                        response = await client.GetAsync("apipos/SetSalesAndReturnInsertion?JsonInvoiceStr=" + JsonInvoiceStr + "&DateFrom="+ DateFrom + "&DateTo=" + DateTo + "&WHID=" + WHID + "&CompanyID=" + CompanyID + "");
                        if (response.IsSuccessStatusCode)
                        {

                            var abc = response.Content.ToString();
                            using (Stream stream = response.Content.ReadAsStreamAsync().Result)
                            {
                                string json = new StreamReader(stream).ReadToEnd();


                                return json;

                            }

                        }
                    }

                }
                catch (Exception e)
                {
                    var Temp = e.Message;
                    return Temp;
                }
                var i = 0;
            }
            return "NoRecordsTransferrred";





        }


        public static async Task<string> InsertAllSalesReturntoServer(string JsonInvoiceStr, string DateFrom, string DateTo, string WHID, string CompanyID)
        {


            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(BaseURL);
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

                HttpResponseMessage response;
                try
                {
                    var id = 0;
                    //id == 0 means select all records    
                    if (id == 0)
                    {
                        response = await client.GetAsync("apipos/InsertAllSalesReturntoServer?RJsonInvoiceStr=" + JsonInvoiceStr + "&RDateFrom=" + DateFrom + "&RDateTo=" + DateTo + "&RWHID=" + WHID + "&RCompanyID=" + CompanyID + "");
                        if (response.IsSuccessStatusCode)
                        {

                            var abc = response.Content.ToString();
                            using (Stream stream = response.Content.ReadAsStreamAsync().Result)
                            {
                                string json = new StreamReader(stream).ReadToEnd();


                                return json;

                            }

                        }
                    }

                }
                catch (Exception e)
                {
                    var Temp = e.Message;
                    return Temp;
                }
                var i = 0;
            }
            return "NoRecordsTransferrred";





        }




    }
}