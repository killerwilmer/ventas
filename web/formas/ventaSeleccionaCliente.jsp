<%--
    Document   : compras
    Created on : 2/11/2010, 11:31:44 AM
    Author     : xyz
--%>
<%@page import="java.util.Vector"%>
<%@page session="true" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="control.ConectaDb"%>
<% ConectaDb control = new ConectaDb(); %>

 <%
    //CREAMOS TODAS LAS VARIABLES QUE VAMOS A UTILIZAR EN LA FACTURA
    //PORQUE ES AQUI DONDE EMPIEZA LA FACTURA

     //tomamos la sesion del gerente que ingreso
    HttpSession sesionOk = request.getSession();
    String gerente = (String)sesionOk.getAttribute("gerente");

    Vector codigo = new Vector();
    Vector canti = new Vector();
    Vector val = new Vector();
    Vector idProducto = new Vector();
    sesionOk.setAttribute("codigo", codigo);
    sesionOk.setAttribute("canti", canti);
    sesionOk.setAttribute("val", val);
    sesionOk.setAttribute("idProducto", idProducto);

    if ( gerente == null || gerente.equals("") )
    {
        out.print("<script lenguage=>'Javascript'> alert('Por favor autentificarce');window.location.href='../index.jsp';</script>");
    }
 %>
<html>
    <head>
    <link href="../css/estilos.css" rel="stylesheet" type="text/css">
        <title>Ventas a Clientes</title>
    </head>
    <body>
        <form action="ventaSeleccionaCliente.jsp" method="post">
        <table align="center">
            <thead>
                <tr>
                    <th colspan="2">Seleccionar el Cliente</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Cliente: </td>
                    <td>
                        <%
                            out.print( control.combo("clientes") );
                        %>
                    </td>
                </tr>
                <tr>
                    <td colspan="2"><input type="submit" value="Enviar" name="enviar" /><input type="submit" value="Cancelar" name="cancelar" /></td>
                </tr>
            </tbody>
        </table>
        </form>
    </body>
</html>
<%
            if (request.getParameter("enviar") != null)
            {
                String idCliente = request.getParameter("combo");
                sesionOk.setAttribute("sesionIdCliente", idCliente);

                String inicio = "Select "; String fin = " from clientes where cod_cliente="+idCliente; // resive el codigo del proveddor que selecciono en el combo
                String nomCliente = control.retornoCodigo(inicio, "nom_cliente", fin); //Retorna el nombre del proveedor

                sesionOk.setAttribute("sesionNomCliente", nomCliente);

                out.print("<script> window.location='ventaCompraCliente.jsp'</script>");
            }
%>
