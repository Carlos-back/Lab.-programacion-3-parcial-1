<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="consultaProducto.aspx.cs" Inherits="Parcial1_LP3_AlanisCarlos.consultaProducto" Culture="es-AR" UICulture="es-AR" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Consulta de productos</title>
    <link href="~/estilos.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="formulario">
            <h1>Consulta de productos</h1>

            <asp:GridView ID="gvProductos" runat="server"
                DataSourceID="sdsConsulta"
                AutoGenerateColumns="False"
                AllowPaging="True" PageSize="5"
                AllowSorting="True"
                EmptyDataText="No hay productos cargados.">
                <Columns>
                    <asp:BoundField DataField="idProducto" HeaderText="Código" SortExpression="idProducto" />
                    <asp:BoundField DataField="nombre" HeaderText="Producto" SortExpression="nombre" />
                    <asp:BoundField DataField="precio" HeaderText="Precio" SortExpression="precio"
                        DataFormatString="{0:C}" HtmlEncode="False" />
                    <asp:BoundField DataField="categoria" HeaderText="Categoría" SortExpression="categoria" />
                </Columns>
            </asp:GridView>

            <div class="navegacion">
                <asp:HyperLink ID="hlVolver" runat="server"
                    Text="Volver a la página principal" NavigateUrl="~/Default.aspx" />
            </div>
        </div>

        <!-- Consulta con JOIN entre productos y categorias -->
        <asp:SqlDataSource ID="sdsConsulta" runat="server"
            ConnectionString="<%$ ConnectionStrings:tienda %>"
            SelectCommand="SELECT p.idProducto, p.nombre, p.precio, c.descripcion AS categoria
                           FROM productos AS p
                           JOIN categorias AS c ON c.idCategoria = p.idCategoria
                           ORDER BY p.idProducto" />
    </form>
</body>
</html>