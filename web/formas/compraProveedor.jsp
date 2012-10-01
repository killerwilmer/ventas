<%--
    Document   : compras
    Created on : 2/11/2010, 11:31:44 AM
    Author     : xyz
--%>

<%@page import="java.util.Vector"%>
<%@page session="true" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="control.ConectaDb"%>
<%@page language="java" import="java.util.Enumeration" pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%
 request.setCharacterEncoding("UTF-8");
 response.setContentType("text/html; charset=utf-8");
%>
<% ConectaDb control = new ConectaDb(); %>

 <%
    HttpSession sesionOk = request.getSession();
    Vector codigo = (Vector) sesionOk.getAttribute("codigo");
    Vector canti = (Vector) sesionOk.getAttribute("canti");
    Vector val = (Vector) sesionOk.getAttribute("val");
    Vector idProducto = (Vector) sesionOk.getAttribute("idProducto");

    String nomPro = (String)sesionOk.getAttribute("sesionNomProveedor");
    String idPro = (String)sesionOk.getAttribute("sesionIdProveedor");
    String gerente = (String)sesionOk.getAttribute("gerente");

    if ( gerente == null || gerente.equals("") )
    {
        out.print("<script lenguage=>'Javascript'> alert('Por favor autentificarce');window.location.href='../index.jsp';</script>");
    }
 %>
<html>
    <head>
        <link href="../css/estilos.css" rel="stylesheet" type="text/css">
        <script type="text/javascript" src="../jquery-ui-1.8.7.custom/js/jquery-1.4.4.min.js"></script>
        <script type="text/javascript">
            function lookup(inputString) {
            if(inputString.length == 0) {
            $('#suggestions').hide();
            } else {
            $.post("states.jsp", {queryString: ""+inputString+""}, function(data){
            if(data.length >0) {
            $('#suggestions').show();
            $('#autoSuggestionsList').html(data);
            }
            });
            }
            }
            function fill(thisValue) {
            $('#inputString').val(thisValue);
            setTimeout("$('#suggestions').hide();", 200);
            }
            </script>
        <title>Compras a Proveedores</title>
    </head>
    <body>
        <form name="form1" method="POST" action="compraProveedor.jsp">
            <table align="center">

                <tbody>
                    <tr>
                        <td>Usuario conectado: </td>
                        <td><% out.print(gerente);%></td>
                    </tr>
                    <tr>
                        <td>Nombre Proveedor:  </td>
                        <td><% out.print(nomPro);%></td>
                    </tr>
                    <tr>
                        <td>Id Proveedor:  </td>
                        <td><% out.print(idPro);%></td>
                    </tr>
                </tbody>
            </table>
            <br>
            <table align="center">
                <tr>
                    <td>
                        <center><input type="submit" value="Ver Factura" name="factura" /></center>
                    </td>
                </tr>                
                    <tr>                        
                        <td>
                            <center>Buscar Productos</center><br>
                            <div>
                                <center><input type="text" name="txtBuscar" size="30" value="" id="inputString" autocomplete="off" onkeyup="lookup(this.value);" /></center>
                            </div>
                            <br>
                            <div class="suggestionsBox" id="suggestions" style="display: none;">
                            <div class="suggestionList" id="autoSuggestionsList">
                            </div>
                            </div>                            
                        </td>
                    </tr>
            </table>

        <%
        //-------------------- metodo para armar la sesion con los datos de la factura
        if (request.getParameter("agregar") != null)
        {          
            // capturo la lista de chekbox
            String[] check  = request.getParameterValues("producto");
            // valido que se escoja al menos un producto
            if( check != null )
            {                
                //Esta variable es para hacer el doble recorrido y saber cuales de lso chekbox a selecsionado
                String[] valores  = request.getParameterValues("valor");

                String[] producto = request.getParameterValues("idPro");
                String[] cantidad = request.getParameterValues("cantidad");
                String[] valor = request.getParameterValues("valor");
                String[] miIdPro = request.getParameterValues("idPro");

                for(int k = 0; k < check.length; k++)
                {
                    for(int l = 0; l < valores.length; l++)
                    {
                        if(l == Integer.decode(check[k]))
                        {
                            boolean existe = false;
                            
                            String inicio = "Select ";
                            String fin2 = " from productos where cod_producto="+producto[l];
                            String nombreProducto = control.retornoCodigo(inicio, "des_producto", fin2);

                            if ( idProducto.size() > 0 )
                            {
                                int posicion = -1;
                                for ( int i = 0 ; i < idProducto.size() && !existe ; i++ )
                                {
                                    String miProducto = (String)idProducto.get(i);
                                    if ( miIdPro[l].equals(miProducto) )
                                    {
                                        existe = true;
                                        posicion = i;
                                    }
                                }
                                if ( existe == true )
                                {
                                    int miCanti = Integer.parseInt(canti.elementAt(posicion).toString());
                                    int miValor = Integer.parseInt(val.elementAt(posicion).toString());
                                    miCanti = miCanti + Integer.parseInt(cantidad[l]);
                                    miValor = miValor + Integer.parseInt(valor[l]);
                                    canti.set(posicion, miCanti);
                                    val.set(posicion, miValor);
                                }
                                else
                                {
                                    codigo.addElement(nombreProducto);
                                    canti.addElement(cantidad[l]);
                                    val.addElement(valor[l]);
                                    idProducto.addElement(miIdPro[l]);
                                }
                            }
                            else
                            {
                                codigo.addElement(nombreProducto);
                                canti.addElement(cantidad[l]);
                                val.addElement(valor[l]);
                                idProducto.addElement(miIdPro[l]);
                            }
                        }
                    }
                }

                /*for (int t = 0; t < producto.length; t++)
                {
                    codigo.addElement(producto[t]);
                    canti.addElement(cantidad[t]);
                    val.addElement(valor[t]);
                }*/

                sesionOk.setAttribute("codigo", codigo);
                sesionOk.setAttribute("canti", canti);
                sesionOk.setAttribute("val", val);
            }
            else
            {
                out.print("<script languaje = javascript> alert('Escoja un producto');  history.back(); </script>");
                return;
            }
        }
        //-----------metodo para llamar a la factura construida
        if (request.getParameter("factura") != null)
        {
            out.print("<script> window.location='factura.jsp'</script>");
        }
        %>
                
        </form>
    </body>
</html>
