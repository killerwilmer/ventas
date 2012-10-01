<%-- 
    Document   : indexge
    Created on : 27/09/2010, 11:10:18 AM
    Author     : xyz
--%>

    <%@page import="java.awt.Color"%>
    <%@ page session="true" %>
    <%@page language="java" import="java.util.Enumeration" pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
    <%
     request.setCharacterEncoding("UTF-8");
     response.setContentType("text/html; charset=utf-8");
    %>

 <%
    HttpSession sesionOk = request.getSession();
    String gerente = (String)sesionOk.getAttribute("gerente");
    
    if ( gerente == null || gerente.equals("") )
    {
        out.print("<script lenguage=>'Javascript'> alert('Por favor autentificarce');window.location.href='../index.jsp';</script>");
    }
    else
    {
        out.print( "Bienvenid@: " + gerente );
    }
 %>

 <html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Bienvenido Gerente</title>
        <script type="text/javascript" language="JavaScript1.2" src="../menu/stmenu.js"></script>
    </head>
    <body bgcolor="#cccccc">
        <table border="0">
                <tr>
                    <td>
                        <script type="text/javascript" language="JavaScript1.2" src="../menu/menuge.js"></script>
                    </td>
                    <td width="1078">
                        <iframe src="bienvenido.jsp" name="destino" frameborder="0" align="center" height="600" width="100%"></iframe>
                    </td>
                </tr>
        </table>

    </body>
</html>
