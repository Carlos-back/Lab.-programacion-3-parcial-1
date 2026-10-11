using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Parcial1_LP3_AlanisCarlos
{
    public partial class bajaProducto : System.Web.UI.Page
    {
        // Al seleccionar una fila: mostrar cuál es y preparar el mensaje de confirmación
        protected void gvProductos_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblMensaje.Text = "";

            string codigo = gvProductos.SelectedDataKey.Value.ToString();
            string nombre = HttpUtility.HtmlDecode(gvProductos.SelectedRow.Cells[2].Text);

            lblSeleccion.Text = "Producto seleccionado: " + codigo + " - " + nombre;

            // Mensaje de confirmación en el navegador (JavaScript confirm)
            btnEliminar.OnClientClick = "return confirm('¿Seguro que querés eliminar el producto "
                + HttpUtility.JavaScriptStringEncode(nombre) + "?');";
        }

        // Al cambiar de página de la grilla: se pierde la selección
        protected void gvProductos_PageIndexChanged(object sender, EventArgs e)
        {
            LimpiarSeleccion();
            lblMensaje.Text = "";
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            if (gvProductos.SelectedIndex < 0)
            {
                lblMensaje.Text = "Primero seleccioná un producto de la lista.";
                return;
            }

            // Eliminar solo el producto seleccionado (tabla productos)
            sdsEliminar.DeleteParameters["idProducto"].DefaultValue =
                gvProductos.SelectedDataKey.Value.ToString();

            try
            {
                int filas = sdsEliminar.Delete();
                if (filas == 1)
                {
                    lblMensaje.Text = "Producto eliminado correctamente.";
                }
                else
                {
                    lblMensaje.Text = "No se pudo eliminar el producto.";
                }
            }
            catch (Exception)
            {
                lblMensaje.Text = "Ocurrió un error al eliminar el producto. Intentá de nuevo.";
            }

            // Volver a cargar la grilla con los datos actualizados
            LimpiarSeleccion();
            gvProductos.PageIndex = 0;
            gvProductos.DataBind();
        }

        private void LimpiarSeleccion()
        {
            gvProductos.SelectedIndex = -1;
            lblSeleccion.Text = "Ningún producto seleccionado.";
            btnEliminar.OnClientClick = "";
        }
    }
}
