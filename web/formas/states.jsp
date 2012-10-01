<%@ page language="java" import="java.sql.*" %>
<%@page import="control.ConectaDb"%>
<%@page language="java" import="java.util.Enumeration" pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%
 request.setCharacterEncoding("UTF-8");
 response.setContentType("text/html; charset=utf-8");
%>
<% ConectaDb control = new ConectaDb(); %>

<% response.setContentType("text/html");%>
<%
String str=request.getParameter("queryString");
System.out.print(str);
try {
String sql = "select * from productos where lower(des_producto) LIKE '%"+str.toLowerCase()+"%' LIMIT 10";
System.out.print(sql);
ResultSet rs = control.consultas(sql);
    %>
    <table align="center">
            <tr> <td></td> <td>Descripcion</td> <td>Cantidad</td> <td>Valor</td> </tr>
            <%
                int i = 0;
                while (rs.next())
                {
                    out.print(control.linea(i) + "<td> <input type='checkbox' name='producto' value='" + i + "' /> </td><td>" + rs.getString(2) + "</td><input type='hidden' name='idPro' value=" + rs.getString(1) + " /><td> <input type='text' name='cantidad' value='' size='10'>" + "</td><td> <input type='text' name='valor' value='' size='10'>" + "</td>");
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
}catch(Exception e){
out.println("Exception is ;"+e);
}
%>
