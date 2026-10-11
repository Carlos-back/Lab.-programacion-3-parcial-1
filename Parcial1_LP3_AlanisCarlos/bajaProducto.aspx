<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="bajaProducto.aspx.cs" Inherits="Parcial1_LP3_AlanisCarlos.bajaProducto" Culture="es-AR" UICulture="es-AR" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Baja de producto</title>
    <link href="~/estilos.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="formulario">
            <h1>Baja de producto</h1>
            <p>Seleccioná el producto que querés eliminar y presioná "Eliminar".</p>

            <asp:GridView ID="gvProductos" runat="server"
                DataSourceID="sdsListado"
                DataKeyNames="idProducto"
                AutoGenerateColumns="False"
                AllowPaging="True" PageSize="5"
                EmptyDataText="No hay productos cargados."
                OnSelectedIndexChanged="gvProductos_SelectedIndexChanged"
                OnPageIndexChanged="gvProductos_PageIndexChanged">
                <Columns>
                    <asp:CommandField ShowSelectButton="True" SelectText="Seleccionar" />
                    <asp:BoundField DataField="idProducto" HeaderText="Código" />
                    <asp:BoundField DataField="nombre" HeaderText="Producto" />
                    <asp:BoundField DataField="precio" HeaderText="Precio"
                        DataFormatString="{0:C}" HtmlEncode="False" />
                    <asp:BoundField DataField="categoria" HeaderText="Categoría" />
                </Columns>
                <SelectedRowStyle BackColor="#FFF3C4" Font-Bold="True" />
            </asp:GridView>

            <div class="campo">
                <asp:Label ID="lblSeleccion" runat="server" Text="Ningún producto seleccionado." />
            </div>

            <div class="campo">
                <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" OnClick="btnEliminar_Click" />
            </div>

            <asp:Label ID="lblMensaje" runat="server" />

            <div class="navegacion">
                <asp:HyperLink ID="hlVolver" runat="server"
                    Text="Volver a la página principal" NavigateUrl="~/Default.aspx" />
            </div>
        </div>

        <!-- Listado con JOIN: muestra la categoría de cada producto -->
        <asp:SqlDataSource ID="sdsListado" runat="server"
            ConnectionString="<%$ ConnectionStrings:tienda %>"
            SelectCommand="SELECT p.idProducto, p.nombre, p.precio, c.descripcion AS categoria
                           FROM productos AS p
                           JOIN categorias AS c ON c.idCategoria = p.idCategoria
                           ORDER BY p.idProducto" />

        <!-- Baja: elimina SOLO de la tabla productos (categorias no se toca) -->
        <asp:SqlDataSource ID="sdsEliminar" runat="server"
            ConnectionString="<%$ ConnectionStrings:tienda %>"
            DeleteCommand="DELETE FROM productos WHERE idProducto = @idProducto">
            <DeleteParameters>
                <asp:Parameter Name="idProducto" Type="Int32" />
            </DeleteParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>
