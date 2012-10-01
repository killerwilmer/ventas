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
HttpSession sesionOk = request.getSession();
String gerente = (String)sesionOk.getAttribute("gerente");
%>

<html>
    <head>
        <title>Cambiar Clave</title>
        <link href="../css/estilos.css" rel="stylesheet" type="text/css">
    </head>
    <body>
    <form name="form1" action="cambiarClave.jsp" method="post">
    <table align="center">
        <tr>
            <th colspan="2"><h2 align="center" style="color: darkblue">Cambio de contraseña</h2></th>
        </tr>
        <tr>
            <td>Clave anterior: </td>
            <td><input type="password" name="anterior" value="" size="20" /> *</td>
        </tr>
        <tr>
            <td>Nueva clave: </td>
            <td><input type="password" name="nueva" value="" size="20" /> *</td>
        </tr>
        <tr>
            <td>Repetir clave: </td>
            <td><input type="password" name="repetir" value="" size="20" /> *</td>
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
            String anterior = request.getParameter("anterior").trim();
            String nueva = request.getParameter("nueva").trim();
            String repetir = request.getParameter("repetir").trim();
            if ( anterior.length() == 0 || nueva.length() == 0 || repetir.length() == 0 )
            {
                out.print("<script languaje = javascript> alert('Todos los Campos son requeridos'); history.back(); </script>");
            }
            else
            {
                String SQLIden = "Select password from usuarios where password ='" + anterior + "'";
                if (control.iden(SQLIden))
                {
                    if ( nueva.equals(repetir) )
                    {
                        String SQL = "Update usuarios set password='" + nueva + "' where nombres='" + gerente + "'";
                        if (control.transaccion(SQL))
                        {
                            out.print("<script languaje = javascript> alert('La contraseña ha sido modificada');</script>");
                        }
                        else
                        {
                            out.print("<script languaje = javascript> alert('No se pudo modificar la contraseña');</script>");
                        }
                    }
                    else
                    {
                        out.print("<script languaje = javascript> alert('La contraseña nueva no coincide'); history.back(); </script>");
                    }
                }
                else
                {
                    out.print("<script languaje = javascript> alert('Contraseña incorrecta'); history.back(); </script>");
                }
            }
         }
    %>

</html>
