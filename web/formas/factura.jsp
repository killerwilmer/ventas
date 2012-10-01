<%@page import="java.util.Calendar"%>
<%@page import="java.util.Vector"%>
<%@page import="java.sql.ResultSet" %>
<%@page import="control.ConectaDb" %>
<%@page session="true" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Factua Proveedor</title>
    <link href="../css/estilos.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        <%
        ConectaDb control = new ConectaDb();
        
        HttpSession sesionOk = request.getSession();

        Vector codigo = (Vector) sesionOk.getAttribute("codigo");
        Vector canti = (Vector) sesionOk.getAttribute("canti");
        Vector val = (Vector) sesionOk.getAttribute("val");
        Vector idProducto = (Vector) sesionOk.getAttribute("idProducto");

        String nomPro = (String)sesionOk.getAttribute("sesionNomProveedor");
        String idPro = (String)sesionOk.getAttribute("sesionIdProveedor");
        String gerente = (String)sesionOk.getAttribute("gerente");

        if (request.getParameter("dato") != null)
        {
            int dat = Integer.parseInt(request.getParameter("dato"));
            codigo.removeElementAt(dat);
            val.removeElementAt(dat);
            canti.removeElementAt(dat);
            idProducto.removeElementAt(dat);
            
            sesionOk.setAttribute("codigo", codigo);
            sesionOk.setAttribute("canti", canti);
            sesionOk.setAttribute("val", val);
            sesionOk.setAttribute("idProducto", idProducto);
        }

        if (request.getParameter("guardar") != null)
        {
            if ( codigo.size() <= 0 )
            {
                out.print("<script languaje = javascript> alert('Aun no ha productos registrados');history.back();</script>");
            }
            else
            {
                Calendar fecha = Calendar.getInstance();
                String fechaActual = fecha.get(Calendar.YEAR) + "-" + (fecha.get(Calendar.MONTH)+1) + "-" + fecha.get(Calendar.DATE);
                String SqlInsert = "insert into compras (cod_proveedor,fec_compra) values('"+idPro+"','"+fechaActual+"');";
                if ( control.transaccion(SqlInsert) )
                {
                        String inicio = "SELECT ";
                        String campo = "max(int2(cod_compra))";
                        String fin = " FROM compras;";
                        int codCompra = Integer.parseInt( control.retornaInt(inicio, campo, fin));
                    for (int i = 0; i < codigo.size(); i++)
                    {
                        String SqlInsertar = "INSERT INTO factura_compra (cod_compra,cod_producto,val_compra,can_compra) values('"+codCompra+"','"+idProducto.elementAt(i)+"','"+val.elementAt(i)+"','"+canti.elementAt(i)+"');";
                        control.transaccion(SqlInsertar);
                    }
                    
                    out.print("<script languaje = javascript> alert('Factura guardada correctamente');document.location=('../principales/bienvenido.jsp');</script>");
                }
                else
                {
                    out.print("<script languaje = javascript> alert('No se pudo guardar esta factura');document.location=('../principales/bienvenido.jsp');</script>");
                }
            }         
        }
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../css/estilos.css" rel="stylesheet" type="text/css">
        <title>JSP Page</title>
    </head>
    <body>

        <table align="center">
            <tr>
                <td colspan="6" ><center> <b>Factura de Compra a Proveedores</b> </center> </td>
            </tr>
            <tr>
                <td colspan="3"> Proveedor </td>
                <td colspan="1"> <% out.print("<B>" + nomPro + "</B>"); %> </td>
                <td colspan="1"> id </td>
                <td colspan="1"> <% out.print("<B>" + idPro + "</B>"); %> </td>
            </tr>
            <tr>
                <td colspan="3">Comprador </td><td colspan="3">
                        <%
                            out.print("<B>" + gerente + "</B>");
                        %>
                    </td>
            </tr>
            <tr bgcolor="#ACFA58"><td>Numero</td><td>Nombre</td><td>Valor</td><td>Cantidad</td><td>Valor Parcial</td><td>Eliminar?</td>

            <%
                double total = 0;
                double totalIva = 0;
                for (int i = 0; i < codigo.size(); i++)
                    {
                    long vpar = 0;
                    vpar = Long.parseLong(val.elementAt(i).toString()) * Long.parseLong(canti.elementAt(i).toString());
                    out.print(control.linea(i) + "<td>" + ( i + 1 ) + "</td><td>" + codigo.elementAt(i) + "</td><td>" + val.elementAt(i) + "</td><td>" + canti.elementAt(i) + "</td><td>" + vpar + "</td><td><a href='factura.jsp?dato=" + i + "'>Elimnar</a></td></tr>");
                    total += vpar;
                    }
                
                totalIva = total * 0.16;
            %>

            <tr bgcolor="#FFFFE0"><td colspan="2">  Total Iva ---></td> <td>  <% out.print( totalIva );%></td>
                <td colspan="2">  Total Factura ---></td> <td>  <% out.print( total + totalIva );%></td>
        </table>
        <br>

        <table align="center">
                <tr>
                    <td valign="middle"><A href="imprimir.jsp" target="_blank">Imprimir Factura</A></td>
                    <td valign="middle"><A href="compraProveedor.jsp">Seguir Comprando</A></td>
                    <td valign="middle"><A href="factura.jsp?guardar=1">Guardar Factura</A></td>
                </tr>
        </table>
    </body>
</html>