﻿using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using POS.Model;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Xml;
using System.Xml.Serialization;

namespace POS.Helper
{
    public static class STATICClass
    {
        public static bool IsDemo = false;
        public static string ExpiryDateKey = "CorbisKey";
        public static DateTime DemoEndDate = Convert.ToDateTime("2022-03-01");

        public static string ConfigurationPassword="789654258";
        //*****Khaaki Api URL **********//
        //public static string BaseURL = "http://72.255.39.154:1011/";
        //******************************//

        //*********** Food Mama Api Url *************//
        // public static string BaseURL = "http://103.86.135.182:1034/";
        //***************************************//

        //public static string BaseURL = "http://192.168.18.29:1011/";

       public static string BaseURL = "http://localhost:44333/";

        public static string Connection()
        {
            return SetConnectionString();
        }
        public static string SetConnectionString()
        {
            string connectionString;
            connectionString = "server=" + Properties.Settings.Default["Server"] + ";database=" + Properties.Settings.Default["Database"] + ";User ID=" + Properties.Settings.Default["ID"] + ";Password=" + Properties.Settings.Default["Password"] + ";";

               return connectionString;
        }

        public static DataTable GetActiveShift()
        {
            var connectionString = STATICClass.Connection();
            SqlConnection cnn;
            cnn = new SqlConnection(connectionString);
            cnn.Open();
            DataTable dt = new DataTable();
            try
            {
                string SqlString = " Select ShiftID,ShiftName from PosData_ShiftRecords where  ISNULL(ISCuurentlyRunning,0)=1";
                SqlDataAdapter sda = new SqlDataAdapter(SqlString, cnn);
                sda.Fill(dt);
            }
            catch (Exception e)
            {

            }
            finally
            {
                cnn.Close();
            }
            return dt;

        }
        public static DataTable GetActiveSessionID()
        {
            var connectionString = STATICClass.Connection();
            SqlConnection cnn;
            cnn = new SqlConnection(connectionString);
            cnn.Open();
            DataTable dt = new DataTable();
            try
            {
                string SqlString = " Select Top 1* from posData_Sessionhandling  where counterID="+CompanyInfo.CounterID+" and SessionClosingTime is not null order by SessionClosingTime desc";
                SqlDataAdapter sda = new SqlDataAdapter(SqlString, cnn);

                sda.Fill(dt);
            }
            catch (Exception e)
            {

            }
            finally
            {

                cnn.Close();

            }
            return dt;

        }


        public static decimal GetStockQuantityItem(Int32 ItemID, Int32 WHID, DateTime StockDate, Int32 CompanyID, string SourceName,
          string EditWC, bool IsTaxable = false)
        {
            DataTable dt = new DataTable(); decimal StockQty = 0; string ItemName = "";
            SqlConnection con = new SqlConnection(STATICClass.Connection());
            SqlTransaction tran;
            con.Open();
            tran = con.BeginTransaction();
            try
            {
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
            
                cmd.Transaction = tran;
                cmd.CommandTimeout = 0;
                da.Fill(dt);
                tran.Commit();
                if (!string.IsNullOrEmpty(Convert.ToString(p.Value)))
                {
                    StockQty = Convert.ToDecimal(Convert.ToString(p.Value));
                    ItemName = Convert.ToString(Name.Value);
                }
                else
                {
                    StockQty = 0;
                    ItemName = Convert.ToString(Name.Value);
                }
            }
            catch (Exception ex)
            {
                tran.Rollback();
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
            return StockQty;

        }
        public static DataTable GetStockQuantityItemBatch(string ItemIDs, Int32 WHID, DateTime StockDate, Int32 CompanyID, string SourceName,
          string EditWC, bool IsTaxable = false)
        {
            DataTable dt = new DataTable();
            SqlConnection con = new SqlConnection(STATICClass.Connection());
            SqlTransaction tran;
            con.Open();
            tran = con.BeginTransaction();
            try
            {
                SqlCommand cmd = new SqlCommand("GetStockQuantityItemBatchWise", con);
                cmd.CommandType = CommandType.StoredProcedure; SqlDataAdapter da = new SqlDataAdapter();
                
                cmd.Parameters.Add(new SqlParameter("@ItemIDs", ItemIDs));
                cmd.Parameters.Add(new SqlParameter("@WHID", WHID));
                cmd.Parameters.Add(new SqlParameter("@StockDate", StockDate));
                cmd.Parameters.Add(new SqlParameter("@CompanyID", CompanyID));
                cmd.Parameters.Add(new SqlParameter("@SourceName", SourceName));
                cmd.Parameters.Add(new SqlParameter("@EditWC", EditWC));
                cmd.Parameters.Add(new SqlParameter("@IsTaxable", IsTaxable));
                da.SelectCommand = cmd;

                cmd.Transaction = tran;
                cmd.CommandTimeout = 0;
                da.Fill(dt);
                tran.Commit();
            }
            catch (Exception ex)
            {
                tran.Rollback();
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
            return dt;

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
            SqlConnection con = new SqlConnection(STATICClass.Connection()); SqlTransaction tran;
            con.Open();
            tran = con.BeginTransaction();
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
                    throw;
                    
                }
                
                return myDataSet;
            }




        }



        public static async Task<DataSet> GetALLBillOfMaterials()
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
                        response = await client.GetAsync("apipos/GetAllBillOfMaterials?CompanyID=" + CompanyInfo.CompanyID + "&BranchID=" + CompanyInfo.BranchID + "&WHID=" + CompanyInfo.WareHouseID + "");
                        if (response.IsSuccessStatusCode)
                        {

                            //var abc = response.Content.ReadAsStringAsync().Result;
                            var Result = await response.Content.ReadAsAsync<string>();

                            //using (Stream stream = response.Content.ReadAsStreamAsync().Result)
                            //{
                            //string json = new StreamReader(stream).ReadToEnd();

                            myDataSet = JsonConvert.DeserializeObject<DataSet>(Result);
                            if (myDataSet.Tables[0].Rows.Count > 0)
                            {
                                scp.insertAllbillOfMaterials(myDataSet, 0);
                            }
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

        public static async Task<string> InsertAllMakeOrderData(string JsonDataStr, string OrderID = "0")
        {


            var bodyContent = "JsonDataStr=" + JsonDataStr + "&WHID=" + CompanyInfo.WareHouseID + "&OrderID=" + OrderID + "";
            MyModel.Key = "'" + JsonDataStr + "'";
            
            using (var client = new HttpClient())
            {
                var response = await client.PostAsync(BaseURL + "/apipos/InsertMakeOrderServer?OrderWHID=" + CompanyInfo.WareHouseID + "&OrderID=" + OrderID + "", new StringContent(MyModel.Key, Encoding.UTF8, "application/json"));

                return response.Content.ReadAsStringAsync().Result;
            }

        }
        public static async Task<string> InsertAllCashInOut(string JsonDataStr, string DateFrom ,string Dateto)
        {


            
            MyModel.Key = "'" + JsonDataStr + "'";

            using (var client = new HttpClient())
            {
                var response = await client.PostAsync(BaseURL + "/apipos/InsertCashInCashOut?SourceWHID=" + CompanyInfo.WareHouseID + "&CashDateFrom=" + DateFrom + "&CashDateTo=" + Dateto + "", new StringContent(MyModel.Key, Encoding.UTF8, "application/json"));

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
                    throw;
                }
                
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
                    throw;
                }
                
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

            //var Base64String = Base64Encode(JsonInvoiceStr);

            MyModel.Key = "'" + JsonInvoiceStr + "'";

            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(BaseURL);
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                
                //HttpResponseMessage response;
                try
                {
                    var id = 0;
                    //id == 0 means select all records    
                    if (id == 0)
                    {
                        //dynamic data = JObject.Parse(JsonInvoiceStr);
                        var response = await client.PostAsync("apipos/SetSalesAndReturnInsertion?DateFrom="+ DateFrom + "&DateTo=" + DateTo + "&WHID=" + WHID + "&CompanyID=" + CompanyID + "&SalePosID=" + SalePosID + "", new StringContent(MyModel.Key, Encoding.UTF8, "application/json"));
                        
                        //var Lengt = JsonInvoiceStr.Length;
                        //if (response.IsSuccessStatusCode)
                        //{

                            var abc = response.Content.ToString();
                            using (Stream stream = response.Content.ReadAsStreamAsync().Result)
                            {
                                string json = new StreamReader(stream).ReadToEnd();


                                return json;

                            }

                        //}
                    }

                }
                catch (Exception e)
                {
                    throw;
                }
                
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
                    throw;
                }
                
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
                    throw;
                }
                
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

        public static async Task<DataSet> GetAllDispatchedOrdersFromServer(string DateFrom,string DateTo)
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
                  
                    if (id == 0)
                    {
                        data_StockTransferInfoModel scp = new data_StockTransferInfoModel();
                        response = await client.GetAsync("apipos/GetAllDispatchedOrders?CompanyID=" + CompanyInfo.CompanyID + "&BranchID=" + CompanyInfo.BranchID + "&WHID=" + CompanyInfo.WareHouseID + "&DateFrom="+DateFrom+ "&Dateto="+DateTo+"");
                        if (response.IsSuccessStatusCode)
                        {

                          
                            var Result = await response.Content.ReadAsAsync<string>();

                          

                            myDataSet = JsonConvert.DeserializeObject<DataSet>(Result);
                            if (myDataSet.Tables[0].Rows.Count > 0)
                            {
                                scp.InsertAllDispatechOrdersFromHo(myDataSet, 0, Convert.ToDateTime(DateFrom), Convert.ToDateTime(DateTo));
                            }
                                return myDataSet;
                            
                        }
                    }
                    else
                    {

                        return myDataSet;
                    }
                }
                catch (Exception e)
                {
                    throw;
                }
                
                return myDataSet;
            }




        }
        public static async Task<DataSet> GetAllStockDispatcherFromServer(string DateFrom, string DateTo)
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

                    if (id == 0)
                    {
                        data_StockTransferInfoModel scp = new data_StockTransferInfoModel();
                        response = await client.GetAsync("apipos/GetAllDispatchedTransfer?CompanyID=" + CompanyInfo.CompanyID + "&BranchID=" + CompanyInfo.BranchID + "&WHID=" + CompanyInfo.WareHouseID + "&DateFrom=" + DateFrom + "&Dateto=" + DateTo + "");
                        if (response.IsSuccessStatusCode)
                        {


                            var Result = await response.Content.ReadAsAsync<string>();



                            myDataSet = JsonConvert.DeserializeObject<DataSet>(Result);
                            if (myDataSet.Tables[0].Rows.Count > 0)
                            {
                                scp.InsertAllStockDispatchesTransfer(myDataSet, 0, Convert.ToDateTime(DateFrom), Convert.ToDateTime(DateTo));
                            }
                            return myDataSet;

                        }
                    }
                    else
                    {

                        return myDataSet;
                    }
                }
                catch (Exception e)
                {
                    throw;
                }
                
                return myDataSet;
            }




        }
        public static string PosdataToFbr(Fbr_InvoiceMaster objinvoice)
        {
           
            HttpClient client = new HttpClient();

            client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", "1298b5eb-b252-3d97-8622-a4a69d5bf818");

            StringContent content = new StringContent(JsonConvert.SerializeObject(objinvoice), Encoding.UTF8, "application/json");

            System.Net.ServicePointManager.ServerCertificateValidationCallback = delegate { return true; };

            HttpResponseMessage response = client.PostAsync("https://esp.fbr.gov.pk:8244/FBR/v1/api/Live/PostData", content).Result;

if (response.IsSuccessStatusCode)

            {
                
                return response.Content.ReadAsStringAsync().Result;

            }
else
            {
                return response.RequestMessage.ToString();
            }

        }

        public static string SyncFbrInvoice(Fbr_InvoiceMaster objinvoice)
        {
            var content = new StringContent(JsonConvert.SerializeObject(objinvoice), Encoding.UTF8, "application/json");
            using (var client = new HttpClient())
            {
                HttpResponseMessage response = client.PostAsync("http://localhost:8524/api/IMSFiscal/GetInvoiceNumberByModel", content).Result;

                if (response.IsSuccessStatusCode)

                {




                    
                    return response.Content.ReadAsStringAsync().Result;

                }
                else
                {
                    return response.RequestMessage.ToString();
                }
            }
        }
        public static string ExceptionMessage(this Exception ex)
        {
            if (ex == null)
                return string.Empty;
            string ExMsg = "";
            if (ExMsg == "")
                ExMsg = ex.Message;
            if (ex.InnerException != null)
                ExMsg += "\r\nInnerException: " + ExceptionMessage(ex.InnerException);
            return ExMsg;
        }
        public static DataTable IMEISearch_SelectAll(Int32 WHID, Int32 CompanyID, string Where = "")
        {
            DataTable dt = new DataTable();
            SqlConnection con = new SqlConnection(STATICClass.Connection());
            SqlTransaction tran;
            con.Open();
            tran = con.BeginTransaction();
            try
            {
                SqlCommand cmd = new SqlCommand("GetBatchStockQuantity_IMEISearch", con);
                cmd.CommandType = CommandType.StoredProcedure; SqlDataAdapter da = new SqlDataAdapter();

                cmd.Parameters.Add(new SqlParameter("@WHID", WHID));
                cmd.Parameters.Add(new SqlParameter("@WhereClause", Where));
                cmd.Parameters.Add(new SqlParameter("@CompanyID", CompanyID));
                da.SelectCommand = cmd;

                cmd.Transaction = tran;
                cmd.CommandTimeout = 0;
                da.Fill(dt);
                tran.Commit();
            }
            catch (Exception ex)
            {
                tran.Rollback();
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
            return dt;

        }

        public static string Encrypt(string source, string key)
        {
            using (TripleDESCryptoServiceProvider tripleDESCryptoService = new TripleDESCryptoServiceProvider())
            {
                using (MD5CryptoServiceProvider hashMD5Provider = new MD5CryptoServiceProvider())
                {
                    byte[] byteHash = hashMD5Provider.ComputeHash(Encoding.UTF8.GetBytes(key));
                    tripleDESCryptoService.Key = byteHash;
                    tripleDESCryptoService.Mode = CipherMode.ECB;
                    byte[] data = Encoding.Unicode.GetBytes(source);
                    return Convert.ToBase64String(tripleDESCryptoService.CreateEncryptor().TransformFinalBlock(data, 0, data.Length));
                }
            }
        }
        public static string Decrypt(string encrypt, string key)
        {
            using (TripleDESCryptoServiceProvider tripleDESCryptoService = new TripleDESCryptoServiceProvider())
            {
                using (MD5CryptoServiceProvider hashMD5Provider = new MD5CryptoServiceProvider())
                {
                    byte[] byteHash = hashMD5Provider.ComputeHash(Encoding.UTF8.GetBytes(key));
                    tripleDESCryptoService.Key = byteHash;
                    tripleDESCryptoService.Mode = CipherMode.ECB;//CBC, CFB
                    byte[] byteBuff = Convert.FromBase64String(encrypt);
                    return Encoding.Unicode.GetString(tripleDESCryptoService.CreateDecryptor().TransformFinalBlock(byteBuff, 0, byteBuff.Length));
                }
            }
        }

    }
}