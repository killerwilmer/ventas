<%--
    Document   : indexge
    Created on : 27/09/2010, 11:10:18 AM
    Author     : xyz
--%>

 <%@ page session="true" %>

 <%
    HttpSession sesionOk = request.getSession();
    String cajero = (String)sesionOk.getAttribute("cajero");
    
    if (cajero == null || cajero.equals(""))
    {
        out.print("<script lenguage=>'Javascript'> alert('Por favor autentificarce');window.location.href='../index.jsp';</script>");
    }
    else
    {
        out.print( "Bienvenid@: " + cajero );
    }
 %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Bienvenido Cajero</title>
        <script type="text/javascript" language="JavaScript1.2" src="../menu/stmenu.js"></script>
    </head>
    <body bgcolor="#cccccc">
        <table border="0">
                <tr>
                    <td>
                        <script type="text/javascript" language="JavaScript1.2" src="../menu/menuca.js"></script>
                    </td>
                    <td width="1078">
                        <iframe name="destino" frameborder="0" align="center" height="600" width="100%"></iframe>
                    </td>
                </tr>
        </table>

    </body>
</html>
