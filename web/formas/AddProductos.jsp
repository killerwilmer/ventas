<%-- 
    Document   : AddProductos
    Created on : 19/10/2010, 11:25:37 AM
    Author     : xyz
--%>

<%@page session="true" %>
<%@page import="control.ConectaDb"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="javax.naming.spi.DirStateFactory.Result"%>

<html>
    <% ConectaDb control = new ConectaDb();
    String idPro = "";
    String desPro= "";
    if ( request.getParameter("modid") != null )
        {
            idPro = (request.getParameter("modid"));
            desPro = (request.getParameter("moddes"));
        }
    %>

    <head>
        <title>Add Productos</title>
        <link href="../css/estilos.css" rel="stylesheet" type="text/css">        
    </head>
    <body>
        <form action="AddProductos.jsp" method="post">
        <table align="center">
                <tr>
                    <th colspan="2"><h3 align="center" >Registro de Productos</h3></th>
                </tr>
                <tr>
                    <td>Decripción</td>
                    <td><input type="hidden" name="id" value="<% out.print(idPro);%>"><input type="text" name="des" value="<% out.print(desPro);%>" size="50" /> *</td>
                </tr>
                <tr>
                    <td>
                        <center><input name="enviar" type="submit" value="Enviar" /></center>
                    </td>
                    <td>
                        <input name="cancelar" type="reset" value="Cancelar" />
                        <input name="listar" type="submit" value="Listar Productos" />
                        <input name="modificar" type="submit" value="Modificar" />
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

    if ( request.getParameter("eliid") != null )
    {
        out.print("<script lenguage=>'Javascript'> alert('codigo eliminar')</script>");
    }
    // Metodo para registrar productos
        if ( request.getParameter("enviar") != null )
            {
                String des = request.getParameter("des");
                if ( des.length() == 0 )
                {
                    out.print("<script lenguage=>'Javascript'> alert('falta dato requerido')</script>");
                }
                else
                {
                    String SqlIden = "Select * from productos where des_producto = '"+des+"'";
                    if ( control.iden(SqlIden))
                    {
                        out.print("El producto con esta descripcion ya existe");
                    }
                    else
                    {
                        String SqlInsert = "insert into productos (des_producto) values('"+des+"');";
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

        // Metodo para listar productos
    if ( request.getParameter("listar") != null )
        {
            String sqlConsulta = "SELECT * FROM productos";
            ResultSet resultado = control.consultas(sqlConsulta);
            out.print( "<center><table>" + "<tr><td>Codigo</td><td>Nombre Producto</td><td>Eliminar</td><td>Modificar</td></tr>" );
            int i = 0;
            String s = "";
            while ( resultado.next() && resultado != null )
                {
                if ( i%2 == 0 )
                s = "<tr bgcolor='#e6e6fa'>";
                else
                s = "<tr bgcolor='#FFFFFF'>";
                    out.print( s + "<td>" + resultado.getString( "cod_producto") + "</td>"
                              + "<td>" + resultado.getString( "des_producto") + "</td>"
                              + "<td><a href='../formas/AddProductos.jsp?eliid=" + resultado.getString( "cod_producto") + "'<img border='0' src='../imagenes/eliminar24.jpg' width='24' height='24' alt='eliminar24'/></a></td>"
                              + "<td><a href='../formas/AddProductos.jsp?modid=" + resultado.getString( "cod_producto")+"&moddes="+ resultado.getString("des_producto") + "'<img border='0' src='../imagenes/editar24.jpg' width='24' height='24' alt='editar24'/></a></td>"
                              + "</tr>" );
                    i++;
                }
            out.println("</table></center>");
        }

        if ( request.getParameter("modificar") != null )
        {
            String des = request.getParameter("des");
            if (des.length() == 0)
            {
                out.print("<script languaje = javascript> alert('Todos los Campos son requeridos'); history.back(); </script>");
            } 
            else
            {
                String SQLIden = "Select * from productos where des_producto ='" + des + "'";
                if (control.iden(SQLIden))
                {
                    out.print("<script languaje = javascript> alert('Producto ya Insertado'); history.back(); </script>");
                } 
                else
                {
                    String SQL = "Update productos set des_producto='" + des + "' where cod_producto=" + request.getParameter("id");
                    if (control.transaccion(SQL))
                    {
                        out.print("<script languaje = javascript> alert('Datos Modificados');</script>");
                    }
                    else
                    {
                        out.print("<script languaje = javascript> alert('Datos NO Modificados');</script>");
                    }
                }
            }
         }
    %>


</html>
