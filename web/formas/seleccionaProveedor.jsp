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
        <title>Compras a Proveedores</title>
    </head>
    <body>
        <form action="seleccionaProveedor.jsp" method="post">
        <table align="center">
            <thead>
                <tr>
                    <th colspan="2">Seleccionar el Proveedor</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Proveedor: </td>
                    <td>
                        <%                            
                            out.print( control.combo("proveedores") );
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
                String idProveedor = request.getParameter("combo");
                sesionOk.setAttribute("sesionIdProveedor", idProveedor);

                String inicio = "Select "; String fin = " from proveedores where cod_proveedor="+idProveedor; // resive el codigo del proveddor que selecciono en el combo
                String nomProveedor = control.retornoCodigo(inicio, "nom_proveedor", fin); //Retorna el nombre del proveedor

                sesionOk.setAttribute("sesionNomProveedor", nomProveedor);
                
                out.print("<script> window.location='compraProveedor.jsp'</script>");
            }
%>
