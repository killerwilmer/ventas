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
        <title>Stoc</title>
    </head>
    <body>
      <Table align="center">
        <tr>
            <th colspan="5"><h2 align="center" style="color: darkblue">Existencias de Productos</h2></th>
        </tr>
        <tr bgcolor="#ACFA58"><td>#</td><td>Codigo</td><td>Producto</td><td>Cantidad</td><td>Valor</td>
        <%
            ResultSet datos = control.consultas("select s.cod_producto, p.des_producto, s.can_producto, s.val_venta from stoc as s , productos as p where s.cod_producto=p.cod_producto;");
            int i = 0;
            while ( datos.next() )
            {
                out.print(control.linea(i) + "<td>" + ( i + 1 ) + "</td><td>" + datos.getString("cod_producto") + "</td><td>" + datos.getString("des_producto") + "</td><td>" + datos.getString("can_producto") + "</td><td>" + datos.getString("val_venta") + "</tr>");
                i++;
            }
        %>
      </Table>
    </body>
</html>
