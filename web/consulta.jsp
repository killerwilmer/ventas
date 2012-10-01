<%-- 
    Document   : index
    Created on : 14/09/2010, 11:27:19 AM
    Author     : xyz
--%>
<%@page import="control.ConectaDb"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="javax.naming.spi.DirStateFactory.Result"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>

    <body>
        <h1>Coneccion a la base de datos</h1>
    <%
        ConectaDb control = new ConectaDb();
        ResultSet datos = control.consultas("select des_producto from productos;");
        int i = 1;
        while ( datos.next() )
        {
            out.print("Producto " + i +" -> "+ datos.getString("des_producto") + "<Br>");
            i++;
        }
    %>

    </body>
</html>
