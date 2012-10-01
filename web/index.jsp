<%-- 
    Document   : index
    Created on : 23/08/2010, 11:51:06 AM
    Author     : Wilmer Arteaga
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true" %>

<html>    
    <head>
        <link href="./css/estilos.css" rel="stylesheet" type="text/css">
        <title>Seguridad</title>
    </head>
    
    <body>
   <form action="login.jsp" method="post">
   <table align="center">
    <tr>
        <td colspan="2"> <h3 align="center" >SEGURIDAD</h3> </td>
    </tr>
    <tr>
        <td>Login:</td>
        <td> <input type="text" name="usuario" value="" /> </td>
    </tr>
    <tr>
        <td>Password:</td>
        <td> <input type="password" name="clave" value="" />  </td>
    </tr>
    <tr>
        <td>
            <center><input name="enviar" type="submit" value="Enviar" /></center>
        </td>
        <td>
            <center><input name="cancelar" type="reset" value="Cancelar" /></center>
        </td>
    </tr>
    </table>
       <h4 style="color:red" align="center">
       
           <%
                if(request.getParameter("error")!=null)
                {
                    out.println(request.getParameter("error"));               
                }
           %>
       </h4>
        </form>
    </body>
</html>
