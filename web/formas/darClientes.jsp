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
        <title>Listado de Clientes</title>
    </head>
    <body>
      <Table align="center">
        <tr>
            <th colspan="6"><h2 align="center" style="color: darkblue">Listado de Clientes</h2></th>
        </tr>
        <tr bgcolor="#ACFA58"><td>#</td><td>Nombre</td><td>apellido</td><td>Telefono</td><td>Direccion</td><td>Fecha</td>
        <%
            ResultSet datos = control.consultas("select * from clientes;");
            int i = 0;
            while ( datos.next() )
            {
                out.print(control.linea(i) + "<td>" + ( i + 1 ) + "</td><td>" + datos.getString("nom_cliente") + "</td><td>" + datos.getString("ape_cliente") + "</td><td>" + datos.getString("tel_cliente") + "</td><td>" + datos.getString("dir_cliente") + "</td><td>" + datos.getString("fec_cliente") + "</td></tr>");
                i++;
            }                
        %>
      </Table>
    </body>
</html>
