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
        <title>Facturas de Ventas</title>
    </head>
    <body>
      <Table align="center">
        <tr>
            <th colspan="6"><h2 align="center" style="color: darkblue">Facturas de Ventas</h2></th>
        </tr>
        <tr bgcolor="#ACFA58"><td>#</td><td>Cod Venta</td><td>Cliente</td><td>Producto</td><td>Cantidad</td><td>Fecha</td>
        <%
            ResultSet datos = control.consultas("select v.cod_venta,c.nom_cliente,p.des_producto,f.can_compra,v.fec_venta from ventas as v,factura_venta as f,clientes as c,productos as p where v.cod_venta=f.cod_venta and c.cod_cliente=v.cod_cliente and p.cod_producto=f.cod_producto;");
            int i = 0;
            while ( datos.next() )
            {
                out.print(control.linea(i) + "<td>" + ( i + 1 ) + "</td><td>" + datos.getString("cod_venta") + "</td><td>" + datos.getString("nom_cliente") + "</td><td>" + datos.getString("des_producto") + "</td><td>" + datos.getString("can_compra") + "</td><td>" + datos.getString("fec_venta") + "</td></tr>");
                i++;
            }
        %>
      </Table>
    </body>
</html>
