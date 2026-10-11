using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Parcial1_LP3_AlanisCarlos
{
    public partial class modificacionProducto : System.Web.UI.Page
    {
        // ---------- BUSCAR ----------
        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            lblMensaje.Text = "";

            int codigo;
            if (!int.TryParse(txtCodigo.Text, out codigo))
            {
                OcultarEdicion();
                lblMensaje.Text = "Ingresá un código numérico válido.";
                return;
            }

            sdsBuscar.SelectParameters["idProducto"].DefaultValue = codigo.ToString();
            SqlDataReader registro = (SqlDataReader)sdsBuscar.Select(DataSourceSelectArguments.Empty);

            try
            {
                if (registro.Read())
                {
                    string nombre = registro["nombre"].ToString();
                    decimal precio = Convert.ToDecimal(registro["precio"]);
                    string idCategoria = registro["idCategoria"].ToString();

                    // Cargar los campos editables con los valores actuales
                    txtNombre.Text = nombre;
                    txtPrecio.Text = precio.ToString("0.00");

                    // El DropDownList está en un panel oculto: se enlaza a mano antes de seleccionar
                    ddlCategoria.DataBind();
                    ddlCategoria.SelectedValue = idCategoria;

                    // Guardar los valores originales para detectar luego si algo cambió
                    ViewState["idProducto"] = codigo;
                    ViewState["origNombre"] = nombre;
                    ViewState["origPrecio"] = precio;
                    ViewState["origCategoria"] = idCategoria;

                    pnlEdicion.Visible = true;
                }
                else
                {
                    OcultarEdicion();
                    lblMensaje.Text = "No existe un producto con ese código.";
                }
            }
            finally
            {
                registro.Close();
            }
        }

        // ---------- MODIFICAR ----------
        protected void btnModificar_Click(object sender, EventArgs e)
        {
            if (ViewState["idProducto"] == null)
            {
                lblMensaje.Text = "Primero buscá un producto por su código.";
                return;
            }

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

            string categoria = ddlCategoria.SelectedValue;

            // 2) Verificar que al menos un campo haya cambiado
            bool cambioNombre = nombre != (string)ViewState["origNombre"];
            bool cambioPrecio = precio != (decimal)ViewState["origPrecio"];
            bool cambioCategoria = categoria != (string)ViewState["origCategoria"];

            if (!cambioNombre && !cambioPrecio && !cambioCategoria)
            {
                lblMensaje.Text = "No modificaste ningún campo. Cambiá al menos uno antes de guardar.";
                return;
            }

            // 3) Cargar los parámetros del UPDATE
            sdsModificar.UpdateParameters["nombre"].DefaultValue = nombre;
            sdsModificar.UpdateParameters["precio"].DefaultValue = precio.ToString(CultureInfo.CurrentCulture);
            sdsModificar.UpdateParameters["idCategoria"].DefaultValue = categoria;
            sdsModificar.UpdateParameters["idProducto"].DefaultValue = ViewState["idProducto"].ToString();

            // 4) Ejecutar el UPDATE (devuelve la cantidad de filas afectadas)
            try
            {
                int filas = sdsModificar.Update();
                if (filas == 1)
                {
                    // Los valores guardados pasan a ser los nuevos "originales"
                    ViewState["origNombre"] = nombre;
                    ViewState["origPrecio"] = precio;
                    ViewState["origCategoria"] = categoria;
                    lblMensaje.Text = "Producto modificado correctamente.";
                }
                else
                {
                    lblMensaje.Text = "No se pudo modificar el producto.";
                }
            }
            catch (Exception)
            {
                lblMensaje.Text = "Ocurrió un error al guardar los cambios. Intentá de nuevo.";
            }
        }

        private void OcultarEdicion()
        {
            pnlEdicion.Visible = false;
            ViewState["idProducto"] = null;
        }
    }
}
