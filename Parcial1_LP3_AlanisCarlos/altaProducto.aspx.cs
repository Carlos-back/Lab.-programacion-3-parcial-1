using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Parcial1_LP3_AlanisCarlos
{
    public partial class altaProducto : System.Web.UI.Page
    {
        protected void btnConfirmar_Click(object sender, EventArgs e)
        {
            // 1) Validar los datos ingresados
            string nombre = txtNombre.Text.Trim();
            if (nombre == "")
            {
                lblMensaje.Text = "Ingresá el nombre del producto.";
                return;
            }

            decimal precio;
            if (!decimal.TryParse(txtPrecio.Text, NumberStyles.Number,
                    CultureInfo.CurrentCulture, out precio) || precio <= 0)
            {
                lblMensaje.Text = "Ingresá un precio válido, mayor que cero (por ejemplo 1500,50).";
                return;
            }

            // 2) Cargar los parámetros del INSERT
            sdsProductos.InsertParameters["nombre"].DefaultValue = nombre;
            sdsProductos.InsertParameters["precio"].DefaultValue = precio.ToString(CultureInfo.CurrentCulture);
            sdsProductos.InsertParameters["idCategoria"].DefaultValue = ddlCategoria.SelectedValue;

            // 3) Ejecutar el INSERT (devuelve la cantidad de filas afectadas)
            try
            {
                int filas = sdsProductos.Insert();
                if (filas == 1)
                {
                    lblMensaje.Text = "Producto cargado correctamente.";
                    txtNombre.Text = "";
                    txtPrecio.Text = "";
                }
                else
                {
                    lblMensaje.Text = "No se pudo cargar el producto.";
                }
            }
            catch (Exception)
            {
                lblMensaje.Text = "Ocurrió un error al guardar el producto. Revisá los datos e intentá de nuevo.";
            }
        }
    }
}
