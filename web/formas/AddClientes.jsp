<%-- 
    Document   : AddClientes
    Created on : 19/10/2010, 02:59:41 PM
    Author     : xyz
--%>

<%@ page session="true" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <%@page import="control.ConectaDb" %>
    <% ConectaDb control = new ConectaDb(); %>
    <head>
        <link href="../css/estilos.css" rel="stylesheet" type="text/css">
        <link type="text/css" href="../jquery-ui-1.8.7.custom/css/trontastic/jquery-ui-1.8.7.custom.css" rel="Stylesheet" />
        <script type="text/javascript" src="../jquery-ui-1.8.7.custom/js/jquery-1.4.4.min.js"></script>
        <script type="text/javascript" src="../jquery-ui-1.8.7.custom/js/jquery-ui-1.8.7.custom.min.js"></script>
        <script type="text/javascript" src="../jquery-ui-1.8.7.custom/cal_es/jquery.ui.datepicker-es.js"></script>

        <script>
        $(document).ready(function(){
           $("#campofecha").datepicker({
              showOn: 'both',
              yearRange: "-100:+0",
              buttonImage: '../jquery-ui-1.8.7.custom/css/ui-lightness/images/calendar.png',
              buttonImageOnly: true,
              changeYear: true,
              numberOfMonths: 1,
              showAnim: 'show'
          }).val(new Date().asString());
        })
        </script>
        <title>Agregar Clientes</title>
    </head>
    <body>
        <form name="form1" action="AddClientes.jsp" method="post">
        <table align="center">
                <tr>
                    <th colspan="2"><h3 align="center" >Registro de Clientes</h3></th>
                </tr>
                <tr>
                    <td>Codigo</td>
                    <td><input type="text" name="codigo" value="" /> *</td>
                </tr>
                <tr>
                    <td>Nombres</td>
                    <td><input type="text" name="nombre" value="" /> *</td>
                </tr>
                <tr>
                <tr>
                    <td>Apellidos</td>
                    <td><input type="text" name="apellido" value="" /> *</td>
                </tr>
                <tr>
                    <td>Telefono</td>
                    <td><input type="text" name="telefono" value="" /></td>
                </tr>
                <tr>
                <tr>
                    <td>Dirección</td>
                    <td><input type="text" name="direccion" value="" /></td>
                </tr>
                    <td>Fecha Nacimiento</td>
                    <td><input type="text" readonly="true" name="fecha" id="campofecha"> *</td>
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
                String apellido = request.getParameter("apellido");
                String telefono = request.getParameter("telefono");
                String direccion = request.getParameter("direccion");
                String fecha = request.getParameter("fecha");

                if ( cod.length() == 0 || nombre.length() == 0 || apellido.length() == 0 ||  telefono.length() == 0 ||  direccion.length() == 0 || fecha.length() == 0 )
                {
                    out.print("<script lenguage=>'Javascript'> alert('falta dato requerido')</script>");
                }
                else
                {
                    String SqlIden = "Select * from clientes where cod_cliente = '"+cod+"'";
                    if ( control.iden(SqlIden))
                    {
                        out.print("Codigo ya registrado");
                    }
                    else
                    {
                        String SqlInsert = "insert into clientes values('"+cod+"','"+nombre+"','"+apellido+"','"+telefono+"','"+direccion+"','"+fecha+"');";
                        if ( control.transaccion(SqlInsert))
                            {
                                out.print("Datos insertados");
                            }
                            else
                            {
                                out.print("Error al insertar los datos");
                            }
                    }

                }
            }
    %>
    
</html>
