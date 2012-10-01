<%-- 
    Document   : AddProveedores
    Created on : 11/10/2010, 10:21:09 AM
    Author     : xyz
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <%@page import="control.ConectaDb" %>
    <% ConectaDb control = new ConectaDb(); %>
    <head>
        <link href="../css/estilos.css" rel="stylesheet" type="text/css">
        <title>JSP Page</title>
    </head>
    <body>
        <form action="AddProveedores.jsp" method="post">
        <table align="center">
                <tr>
                    <th colspan="2"><h3 align="center" >Registro de Proveedores</h3></th>
                </tr>
                <tr>
                    <td>Codigo</td>
                    <td><input type="text" name="codigo" value="" /> *</td>
                </tr>
                <tr>
                    <td>Nombre</td>
                    <td><input type="text" name="nombre" value="" /> *</td>
                </tr>
                <tr>
                    <td>Dirección</td>
                    <td><input type="text" name="direccion" value="" /></td>
                </tr>
                <tr>
                    <td>Telefono</td>
                    <td><input type="text" name="telefono" value="" /></td>
                </tr>
                <tr>
                    <td>Correo</td>
                    <td><input type="text" name="correo" value="" /> *</td>
                </tr>
                <tr>
                    <td>
                        <center><input name="enviar" type="submit" value="Enviar" /></center>
                    </td>
                    <td>
                        <center><input name="cancelar" type="reset" value="Cancelar" /></center>
                    </td>
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
                String cod = request.getParameter("codigo");
                String nombre = request.getParameter("nombre");
                String correo = request.getParameter("correo");
                String telefono = request.getParameter("telefono");
                String direccion = request.getParameter("direccion");

                if ( cod.length() == 0 || nombre.length() == 0 || correo.length() == 0 )
                {
                    out.print("<script lenguage=>'Javascript'> alert('falta dato requerido')</script>");
                }
                else
                {
                    String SqlIden = "Select * from proveedores where cod_proveedor = '"+cod+"'";
                    if ( control.iden(SqlIden))
                    {
                        out.print("Codigo ya registrado");
                    }
                    else
                    {
                        String SqlInsert = "insert into proveedores values('"+cod+"','"+nombre+"','"+telefono+"','"+direccion+"','"+correo+"');";
                        if ( control.transaccion(SqlInsert))
                            {
                                out.print("Datos insertados");
                            }
                            else
                            {
                                out.print("Erro al insertar los datos");
                            }
                    }

                }
            }
    %>

</html>
