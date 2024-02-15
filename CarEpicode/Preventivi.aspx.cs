using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Linq.Expressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

namespace CarEpicode
{
    public partial class Preventivi : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            showPreventivo.Visible = false;

            if (!IsPostBack)
            {
                string connString = ConfigurationManager.ConnectionStrings["connectionToDatabase"].ToString();
                SqlConnection conn = new SqlConnection(connString);

                try
                {
                    conn.Open();
                    SqlCommand getAllCars = new SqlCommand("SELECT * FROM ListaMacchine", conn);
                    SqlDataReader cars = getAllCars.ExecuteReader();

                    if (cars.HasRows)
                    {
                        while (cars.Read())
                        {
                            CarList.Items.Add(new ListItem(cars["Brand"] + " " + cars["Modello"], cars["Id"].ToString()));
                        }
                    }
                    else
                    {
                        Response.Write("Errore nella connessione");
                    }
                }
                catch (Exception ex)
                {
                    Response.Write($"{ex}");
                }
                finally
                {
                    conn.Close();
                }
            }
        }

        protected void CarList_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedCarId = CarList.SelectedValue;

            string connString = ConfigurationManager.ConnectionStrings["connectionToDatabase"].ToString();
            SqlConnection conn = new SqlConnection(connString);

            try
            {
                conn.Open();
                SqlCommand getCarImage = new SqlCommand($"SELECT Image FROM ListaMacchine WHERE Id = {selectedCarId}", conn);
                SqlDataReader carImg = getCarImage.ExecuteReader();

                if (carImg.HasRows)
                {
                    if (carImg.Read())
                    {
                        string imageURL = carImg["Image"].ToString();
                        carImage.Attributes["src"] = imageURL;
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write($"{ex}");
            }
            finally
            {
                conn.Close();
            }
        }

        protected void sendPreventivo_Click(object sender, EventArgs e)
        {
            string connString = ConfigurationManager.ConnectionStrings["connectionToDatabase"].ToString();
            SqlConnection conn = new SqlConnection(connString);
            int selectedAssurance = Convert.ToInt32(carAssurance.SelectedValue);
            int garanzia = selectedAssurance * 120;
            bool isOptionalChecked = false;

            try
            {
                conn.Open();

                SqlCommand insertPreventivo = new SqlCommand($"INSERT INTO ListaPreventivi (IdMacchina, Cliente, Garanzia) VALUES ({CarList.SelectedValue}, '{txtName.Text}', {garanzia})", conn);
                int affectedRow = insertPreventivo.ExecuteNonQuery();
                if (affectedRow == 0)
                {
                    Response.Write("C'è stato un errore nella registrazione");
                }

                SqlCommand getIdPreventivo = new SqlCommand($"SELECT IdPreventivo FROM ListaPreventivi WHERE Cliente = '{txtName.Text}'", conn);
                SqlDataReader idPreventivo = getIdPreventivo.ExecuteReader();

                string idDelPreventivo = "";
                int totPrice = 0;

                if (idPreventivo.HasRows)
                {
                    if (idPreventivo.Read())
                    {
                        idDelPreventivo = idPreventivo["IdPreventivo"].ToString();
                    }
                }

                idPreventivo.Close();

                foreach (ListItem item in CarOptionals.Items)
                {
                    if (item.Selected)
                    {
                        isOptionalChecked = true;
                        SqlCommand insertOptional = new SqlCommand($"INSERT INTO ListaOptionals (IdPreventivo, Optional) VALUES ({idDelPreventivo}, {item.Value})", conn);
                        int insrtAffectedRow = insertOptional.ExecuteNonQuery();
                        if (insrtAffectedRow == 0)
                        {
                            Response.Write("Non ci sono optional selezionati");
                        }
                    }
                }

                if (!isOptionalChecked)
                {
                    SqlCommand insertOptional = new SqlCommand($"INSERT INTO ListaOptionals (IdPreventivo, Optional) VALUES ({idDelPreventivo}, 0)", conn);
                    int insrtAffectedRow = insertOptional.ExecuteNonQuery();
                    if (insrtAffectedRow == 0)
                    {
                        Response.Write("Errore nella registrazione SENZA optional");
                    }
                }

                SqlCommand getTotPrezzoOpt = new SqlCommand($"SELECT IdPreventivo, sum(Prezzo) as totPrezzoPreventivi  FROM ListaOptionals lstOpt LEFT JOIN Optionals opt ON lstOpt.Optional = opt.IdOptional GROUP BY IdPreventivo HAVING IdPreventivo = {idDelPreventivo}", conn);
                SqlDataReader prezziPreventivo = getTotPrezzoOpt.ExecuteReader();

                if (prezziPreventivo.HasRows)
                {
                    if (prezziPreventivo.Read())
                    {
                        int pricePreventivi = Convert.ToInt32(prezziPreventivo["totPrezzoPreventivi"]);
                        totPrice += pricePreventivi;
                        totOptionals.Text = $"Totale optionals: {pricePreventivi}€";
                    }
                }
                prezziPreventivo.Close();

                SqlCommand getOtherPrezziPrev = new SqlCommand($"SELECT IdPreventivo, Brand, Modello, Prezzo, Garanzia FROM ListaPreventivi prev LEFT JOIN ListaMacchine car ON prev.IdMacchina = car.Id WHERE IdPreventivo = {idDelPreventivo}", conn);
                SqlDataReader otherPrezziPrev = getOtherPrezziPrev.ExecuteReader();

                if (otherPrezziPrev.HasRows)
                {
                    if (otherPrezziPrev.Read())
                    {
                        int baseModel = Convert.ToInt32(otherPrezziPrev["Prezzo"]);
                        basePriceAndModel.Text = $"{otherPrezziPrev["Brand"]} {otherPrezziPrev["Modello"]} Prezzo base: {baseModel}€";
                        int priceAssurance = Convert.ToInt32(otherPrezziPrev["Garanzia"]);
                        totAssurance.Text = $"Totale garanzia: {priceAssurance}€";
                        totPrice = totPrice + baseModel + priceAssurance;
                        totalPrice.Text = $"Totale preventivo: {totPrice.ToString()}€";
                    }
                }
                otherPrezziPrev.Close();
                showPreventivo.Visible = true;
            }
            catch (Exception ex)
            {
                Response.Write($"{ex}");
            }
            finally
            {
                conn.Close();
            }
        }
    }
}