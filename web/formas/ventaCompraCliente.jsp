<%--
    Document   : compras
    Created on : 2/11/2010, 11:31:44 AM
    Author     : xyz
--%>

<%@page import="java.util.Vector"%>
<%@ page session="true" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="control.ConectaDb"%>
<% ConectaDb control = new ConectaDb(); %>

 <%
    HttpSession sesionOk = request.getSession();
    Vector codigo = (Vector) sesionOk.getAttribute("codigo");
    Vector canti = (Vector) sesionOk.getAttribute("canti");
    Vector val = (Vector) sesionOk.getAttribute("val");
    Vector idProducto = (Vector) sesionOk.getAttribute("idProducto");

    String nomCli = (String)sesionOk.getAttribute("sesionNomCliente");
    String idCli = (String)sesionOk.getAttribute("sesionIdCliente");
    String gerente = (String)sesionOk.getAttribute("gerente");

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
        <form name="form1" method="POST" action="ventaCompraCliente.jsp">
            <table align="center">

                <tbody>
                    <tr>
                        <td>Usuario conectado: </td>
                        <td><% out.print(gerente);%></td>
                    </tr>
                    <tr>
                        <td>Nombre Cliente  </td>
                        <td><% out.print(nomCli);%></td>
                    </tr>
                    <tr>
                        <td>Id Cliente  </td>
                        <td><% out.print(idCli);%></td>
                    </tr>
                </tbody>
            </table>
            <br>
            <table align="center">
                    <tr>
                        <td>Buscar Productos: <input type="text" size="30" name="txtBuscar" value="" /><input type="submit" value="Buscar" name="btnBuscar" />  <input type="submit" value="Ver Factura" name="factura" /></td>
                    </tr>
            </table>
            <br>
            <%
                if (request.getParameter("btnBuscar") != null)
                {
                    String texto = request.getParameter("txtBuscar");
                    ConectaDb conec = new ConectaDb();
                    String consulta = "select s.cod_producto,p.des_producto,s.val_venta from productos as p, stoc as s where p.des_producto like('%"+texto+"%') and p.cod_producto=s.cod_producto;";
                    //String consulta = "select * from productos where des_producto like('%"+texto+"%');";
                    ResultSet listaProductos = conec.consultas(consulta);
            %>

            <table align="center">
            <tr> <td></td> <td>Descripcion</td> <td>Valor</td> <td>Cantidad</td> </tr>
            <%
                int i = 0;
                while (listaProductos.next() && listaProductos != null)
                {
                    out.print(conec.linea(i) + "<td> <input type='checkbox' name='producto' value='" + i + "' /> </td><td>" + listaProductos.getString(2) + "</td><input type='hidden' name='idPro' value=" + listaProductos.getString(1) + " /><td><input readonly type='text' name='valor' value='" + listaProductos.getString(3) + "' size='10'></td><td> <input type='text' name='cantidad' value='' size='10'>" + "</td>");
                    i++;
                }
            %>
                <tr>
                    <td colspan="4">
                        <center><input type="submit" name="agregar" value="Agregar Carrito" align="center" ></center>
                    </td>
                </tr>
            </table>
            <%
                }
            %>

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
            out.print("<script> window.location='ventaFacturaCliente.jsp'</script>");
        }
        %>

        </form>
    </body>
</html>