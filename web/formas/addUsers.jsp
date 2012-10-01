<%--
    Document   : cambiarClave
    Created on : 26/11/2010, 11:25:40 PM
    Author     : xyz
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true" %>
<%@page import="control.ConectaDb"%>
<%
ConectaDb control = new ConectaDb();
%>

<html>
    <head>
        <title>Cambiar Clave</title>
        <link href="../css/estilos.css" rel="stylesheet" type="text/css">
    </head>
    <body>
    <form name="form1" action="addUsers.jsp" method="post">
    <table align="center">
        <tr>
            <th colspan="2"><h2 align="center" style="color: darkblue">Agregar Usuarios</h2></th>
        </tr>
        <tr>
            <td>Nombres: </td>
            <td><input type="text" name="nombres" value="" size="20" /> *</td>
        </tr>
        <tr>
            <td>Apellidos: </td>
            <td><input type="text" name="apellidos" value="" size="20" /> *</td>
        </tr>
        <tr>
            <td>Login: </td>
            <td><input type="text" name="login" value="" size="20" /> *</td>
        </tr>
        <tr>
        <tr>
            <td>Password: </td>
            <td><input type="password" name="password" value="" size="20" /> *</td>
        </tr>
        <tr>
            <td>Tipo: </td>
            <td><select name="nivel">
                    <option>CAJERO</option>
                    <option>GERENTE</option>
                    <option>ADMIN</option>
                </select> *</td>
        </tr>
        <tr>
            <td>
                <center><input name="enviar" type="submit" value="Enviar" /></center>
            </td>
            <td>
                <input name="cancelar" type="reset" value="Cancelar" />
            </td>
        </tr>
        <tr>
        </tr>
        <tr>
            <td colspan="2">* Datos obligatorios.</td>
        </tr>
    </table>
    </form>
    </body>

    <%
        if ( request.getParameter("enviar") != null )
        {
            String nombres = request.getParameter("nombres").trim();
            String apellidos = request.getParameter("apellidos").trim();
            String login = request.getParameter("login").trim();
            String password = request.getParameter("password").trim();
            String nivel = request.getParameter("nivel").trim();
            nivel = nivel.substring(0,2);
            if ( nombres.length() == 0 || apellidos.length() == 0 || login.length() == 0 || password.length() == 0 )
            {
                out.print("<script languaje = javascript> alert('Todos los Campos son requeridos'); history.back(); </script>");
            }
            else
            {
                String SQLIden = "Select nombres from usuarios where nombres ='" + nombres + "'";
                if (control.iden(SQLIden))
                {
                    out.print("<script languaje = javascript> alert('Este usuario ya existe'); history.back(); </script>");
                }
                else
                {
                    String SQL = "insert into usuarios (nombres,apellidos,login,password,nivel) values('"+nombres+"','"+apellidos+"','"+login+"','"+password+"','"+nivel+"');";
                    if (control.transaccion(SQL))
                    {
                        out.print("<script languaje = javascript> alert('Usuario registrado correctamente');</script>");
                    }
                    else
                    {
                        out.print("<script languaje = javascript> alert('No se pudo registrar el usuario');</script>");
                    }
                }
            }
         }
    %>

</html>
