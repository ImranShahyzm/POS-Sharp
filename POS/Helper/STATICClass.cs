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
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Xml;
using System.Xml.Serialization;

namespace POS.Helper
{
    public static class STATICClass
    {
        //*****Khaki Api URL **********//
      //public static string BaseURL = "http://103.86.135.182:1038/";
        //******************************//

            //*********** Food Mama Api Url *************//
       //public static string BaseURL = "http://103.86.135.182:1034/";
        //***************************************//
        //public static string BaseURL = "http://192.168.18.29:1011/";

        static string BaseURL = "http://localhost:44333/";
        public static string Connection()
        {
            return ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
        }
        public static decimal GetStockQuantityItem(Int32 ItemID, Int32 WHID, DateTime StockDate, Int32 CompanyID, string SourceName,
          string EditWC, bool IsTaxable = false)
        {
            DataTable dt = new DataTable(); decimal StockQty = 0; string ItemName;
            SqlConnection con = new SqlConnection(STATICClass.Connection());
            SqlTransaction tran;
            con.Open();
            tran = con.BeginTransaction();
            SqlCommand cmd = new SqlCommand("GetStockQuantity", con);
            cmd.CommandType = CommandType.StoredProcedure; SqlDataAdapter da = new SqlDataAdapter();
            SqlParameter p = new SqlParameter("@StockQty", StockQty); p.Precision = 14; p.Scale = 2;
            p.Direction = ParameterDirection.InputOutput; cmd.Parameters.Add(p);

            SqlParameter Name = new SqlParameter("@ItemName", SqlDbType.VarChar, 200); /*Name.Size = 200;*/
            Name.Direction = ParameterDirection.InputOutput; cmd.Parameters.Add(Name);

            cmd.Parameters.Add(new SqlParameter("@ItemID", ItemID));
            cmd.Parameters.Add(new SqlParameter("@WHID", WHID));
            cmd.Parameters.Add(new SqlParameter("@StockDate", StockDate));
            cmd.Parameters.Add(new SqlParameter("@CompanyID", CompanyID));
            cmd.Parameters.Add(new SqlParameter("@SourceName", SourceName));
            cmd.Parameters.Add(new SqlParameter("@EditWC", EditWC));
            cmd.Parameters.Add(new SqlParameter("@IsTaxable", IsTaxable));
            da.SelectCommand = cmd;
            try
            {
                cmd.Transaction = tran; da.Fill(dt); tran.Commit();
                StockQty = Convert.ToDecimal(p.Value.ToString());
                ItemName = Name.Value.ToString();
            }
            catch (Exception ex)
            {
                tran.Rollback();
                return StockQty;
            }
            finally
            {
                con.Close();
            }
            return StockQty;

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
        public static DataSet SelectAllFromQuery(string Query)
        {
            DataSet ds = new DataSet(); SqlConnection con = new SqlConnection(STATICClass.Connection());
            SqlCommand cmd = new SqlCommand(Query, con);
            try
            {
                cmd.CommandType = CommandType.Text;
                SqlDataAdapter da = new SqlDataAdapter(cmd);//da.SelectCommand = cmd;
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
            }
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

        public static async Task<DataSet> GetAllInventory()
        {

            DataSet myDataSet = new DataSet();

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
                        data_StockTransferInfoModel scp = new data_StockTransferInfoModel();
                        response = await client.GetAsync("apipos/GetAllInventory?CompanyID=" + CompanyInfo.CompanyID + "&BranchID=" + CompanyInfo.BranchID + "&WHID=" + CompanyInfo.WareHouseID + "");
                        if (response.IsSuccessStatusCode)
                        {
                            
                            //var abc = response.Content.ReadAsStringAsync().Result;
                            var Result=await response.Content.ReadAsAsync<string>();

                            //using (Stream stream = response.Content.ReadAsStreamAsync().Result)
                            //{
                            //string json = new StreamReader(stream).ReadToEnd();

                            myDataSet = JsonConvert.DeserializeObject<DataSet>(Result);
                            scp.insertAllInventory(myDataSet, 0);
                                return myDataSet;
                            //}
                            // data_StockTransferInfoModel[] reports = await response.Content.ReadAsAsync<data_StockTransferInfoModel[]>();

                        }
                    }
                    else
                    {
                        
                        return myDataSet;
                    }
                }
                catch (Exception e)
                {
                    var Temp = e.Message;
                }
                var i = 0;

                return myDataSet;
            }




        }

        public static async Task<string> CheckNewWayofStockArrivalInsert (string JsonDataStr, string ArrivalID = "0")
        {
           

            var bodyContent = "JsonDataStr=" + JsonDataStr + "&WHID=" + CompanyInfo.WareHouseID + "&ArrivalID=" + ArrivalID + "";
            MyModel.Key = "'"+JsonDataStr+"'" ;
            //StockArrivalFromBranches
            using (var client = new HttpClient())
            {
                var response = await client.PostAsync(BaseURL+ "/apipos/StockArrivalFromBranches?WHID=" + CompanyInfo.WareHouseID + "&ArrivalID=" + ArrivalID + "", new StringContent(MyModel.Key, Encoding.UTF8, "application/json"));

                return response.Content.ReadAsStringAsync().Result;
            }

           
        }

        public static async Task<DataSet> GetAllSalesMan()
        {

            DataSet myDataSet = new DataSet();

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
                        data_StockTransferInfoModel scp = new data_StockTransferInfoModel();
                        response = await client.GetAsync("apipos/GetAllSalesManSelectAll?CompanyID=" + CompanyInfo.CompanyID + "&BranchID=" + CompanyInfo.BranchID + "&WHID=" + CompanyInfo.WareHouseID + "");
                        if (response.IsSuccessStatusCode)
                        {

                            //var abc = response.Content.ReadAsStringAsync().Result;
                            var Result = await response.Content.ReadAsAsync<string>();

                            //using (Stream stream = response.Content.ReadAsStreamAsync().Result)
                            //{
                            //string json = new StreamReader(stream).ReadToEnd();

                            myDataSet = JsonConvert.DeserializeObject<DataSet>(Result);
                            scp.insertAllSalesMan(myDataSet, 0);
                            return myDataSet;
                            //}
                            // data_StockTransferInfoModel[] reports = await response.Content.ReadAsAsync<data_StockTransferInfoModel[]>();

                        }
                    }
                    else
                    {

                        return myDataSet;
                    }
                }
                catch (Exception e)
                {
                    var Temp = e.Message;
                }
                var i = 0;

                return myDataSet;
            }




        }

        


        public static async Task<DataSet> GetAllWareHouseGluserPromo()
        {

            DataSet myDataSet = new DataSet();

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
                        data_StockTransferInfoModel scp = new data_StockTransferInfoModel();
                        response = await client.GetAsync("apipos/GetAllWareHouseGluserPromo?CompanyID=" + CompanyInfo.CompanyID + "&BranchID=" + CompanyInfo.BranchID + "&WHID=" + CompanyInfo.WareHouseID + "");
                        if (response.IsSuccessStatusCode)
                        {

                            //var abc = response.Content.ReadAsStringAsync().Result;
                            var Result = await response.Content.ReadAsAsync<string>();

                            //using (Stream stream = response.Content.ReadAsStreamAsync().Result)
                            //{
                            //string json = new StreamReader(stream).ReadToEnd();

                            myDataSet = JsonConvert.DeserializeObject<DataSet>(Result);
                            scp.InsertAllGlUserPromoLocations(myDataSet, 0);
                            return myDataSet;
                            //}
                            // data_StockTransferInfoModel[] reports = await response.Content.ReadAsAsync<data_StockTransferInfoModel[]>();

                        }
                    }
                    else
                    {

                        return myDataSet;
                    }
                }
                catch (Exception e)
                {
                    var Temp = e.Message;
                }
                var i = 0;

                return myDataSet;
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



        public static async Task<string> InsertAllStockArrivaltoServer(string JsonDataStr,string ArrivalID="0")
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
                        response = await client.GetAsync("apipos/SetStockArrivalInsertion?JsonDataStr=" + JsonDataStr + "&WHID=" + CompanyInfo.WareHouseID + "&ArrivalID=" + ArrivalID + "");
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
        public static string Base64Encode(string plainText)
        {
            var plainTextBytes = System.Text.Encoding.UTF8.GetBytes(plainText);
            return System.Convert.ToBase64String(plainTextBytes);
        }


        public static async Task<string> InsertAllSalesAndReturntoServer(string JsonInvoiceStr,string DateFrom,string DateTo,string WHID,string CompanyID,string SalePosID="0")
        {

            var Base64String = Base64Encode(JsonInvoiceStr);


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
                        //dynamic data = JObject.Parse(JsonInvoiceStr);
                        response = await client.GetAsync("apipos/SetSalesAndReturnInsertion?JsonInvoiceStr=" + JsonInvoiceStr + "&DateFrom="+ DateFrom + "&DateTo=" + DateTo + "&WHID=" + WHID + "&CompanyID=" + CompanyID + "&SalePosID=" + SalePosID + "");
                        
                        var Lengt = JsonInvoiceStr.Length;
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


        public static async Task<string> InsertAllSalesReturntoServer(string JsonInvoiceStr, string DateFrom, string DateTo, string WHID, string CompanyID,string SalePosreturnID="0")
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
                        response = await client.GetAsync("apipos/InsertAllSalesReturntoServer?RJsonInvoiceStr=" + JsonInvoiceStr + "&RDateFrom=" + DateFrom + "&RDateTo=" + DateTo + "&RWHID=" + WHID + "&RCompanyID=" + CompanyID + "&SalePosreturnID="+ SalePosreturnID + "");
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



        public static async Task<string> PosAllSaleVouchers(string DateFrom, string DateTo, string WHID, string CompanyID)
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
                        response = await client.GetAsync("apipos/InsertPosSaleVouchers?VoucherFrom=" + DateFrom + "&VoucherTo=" + DateTo + "&VWHID=" + WHID + "&VCompanyID=" + CompanyID + "");
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


        public static async Task<string> InsertAllStockReturntoServer(string JsonInvoiceStr, string DateFrom, string DateTo, string WHID, string CompanyID)
        {


            //var bodyContent = "JsonDataStr=" + JsonInvoiceStr + "&WHID=" + CompanyInfo.WareHouseID + "&ArrivalID=" + ArrivalID + "";
            MyModel.Key = "'" + JsonInvoiceStr + "'";
            //StockArrivalFromBranches
            using (var client = new HttpClient())
            {
                var response = await client.PostAsync(BaseURL + "apipos/InsertAllStockReturntoServer?RSDateFrom=" + DateFrom + "&RSDateTo=" + DateTo + "&RSWHID=" + WHID + "&RSCompanyID=" + CompanyID + "", new StringContent(MyModel.Key, Encoding.UTF8, "application/json"));

                return response.Content.ReadAsStringAsync().Result;
            }


            //using (var client = new HttpClient())
            //{
            //    client.BaseAddress = new Uri(BaseURL);
            //    client.DefaultRequestHeaders.Accept.Clear();
            //    client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

            //    HttpResponseMessage response;
            //    try
            //    {
            //        var id = 0;
            //        //id == 0 means select all records    
            //        if (id == 0)
            //        {
            //            response = await client.GetAsync("apipos/InsertAllStockReturntoServer?RJsonStockStr=" + JsonInvoiceStr + "&RSDateFrom=" + DateFrom + "&RSDateTo=" + DateTo + "&RSWHID=" + WHID + "&RSCompanyID=" + CompanyID + "");
            //            if (response.IsSuccessStatusCode)
            //            {

            //                var abc = response.Content.ToString();
            //                using (Stream stream = response.Content.ReadAsStreamAsync().Result)
            //                {
            //                    string json = new StreamReader(stream).ReadToEnd();


            //                    return json;

            //                }

            //            }
            //        }

            //    }
            //    catch (Exception e)
            //    {
            //        var Temp = e.Message;
            //        return Temp;
            //    }
            //    var i = 0;
            //}
            //return "NoRecordsTransferrred";





        }

        


    }
}