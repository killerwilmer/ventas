<%--
    Document   : darClientes
    Created on : 27/11/2010, 02:20:58 AM
    Author     : xyz
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true" %>
<%@page import="control.ConectaDb"%>
<%
ConectaDb control = new ConectaDb();
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../css/estilos.css" rel="stylesheet" type="text/css">
        <title>Facturas de Compras</title>
    </head>
    <body>
      <Table align="center">
        <tr>
            <th colspan="7"><h2 align="center" style="color: darkblue">Facturas de Compras</h2></th>
        </tr>
        <tr bgcolor="#ACFA58"><td>#</td><td>Cod Venta</td><td>Proveedor</td><td>Producto</td><td>Valor</td><td>Cantidad</td><td>Fecha</td>
        <%
            ResultSet datos = control.consultas("select c.cod_compra,pr.nom_proveedor,p.des_producto,f.val_compra,f.can_compra,c.fec_compra from compras as c,factura_compra as f,proveedores as pr,productos as p where c.cod_compra=f.cod_compra and pr.cod_proveedor=c.cod_proveedor and p.cod_producto=f.cod_producto;");
            int i = 0;
            while ( datos.next() )
            {
                out.print(control.linea(i) + "<td>" + ( i + 1 ) + "</td><td>" + datos.getString("cod_compra") + "</td><td>" + datos.getString("nom_proveedor") + "</td><td>" + datos.getString("des_producto") + "</td><td>" + datos.getString("val_compra") + "</td><td>" + datos.getString("can_compra") + "</td><td>" + datos.getString("fec_compra") + "</td></tr>");
                i++;
            }
        %>
      </Table>
    </body>
</html>
