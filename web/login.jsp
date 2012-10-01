 <%@ page session="true" %>
 <%@page import="control.ConectaDb" %>
 <% ConectaDb control = new ConectaDb(); %>
<%
String usuario = "";
String clave = "";
if ( request.getParameter("usuario").trim() != null && request.getParameter("usuario").trim() != "" )
    {
        usuario = request.getParameter("usuario");
    }
else
    {
        %>
            <jsp:forward page="index.jsp">
            <jsp:param name="error" value="Favor digitar el nombre de usuario."/>
            </jsp:forward>
        <%
    }


if ( request.getParameter("clave").trim() != null && request.getParameter("clave").trim() != "" )
    {
        clave = request.getParameter("clave");
    }
else
    {
        %>
            <jsp:forward page="index.jsp">
            <jsp:param name="error" value="Favor digitar la contraseña."/>
            </jsp:forward>
        <%
    }



String sql = "select usuarios.login, usuarios.password from usuarios where usuarios.login='"+ usuario +"' and usuarios.password='"+ clave +"';";
if (control.iden(sql))
{
    HttpSession sesionOk = request.getSession();

    String inicio = "select ";
    String campo = "nivel";
    String fin = " from usuarios where login='" + usuario + "'";
    String tipo = control.retornoCodigo(inicio, campo, fin);
    if (tipo.equals("AD"))
    {
        sesionOk.setAttribute("admin", usuario);
        out.print("<script>window.location='principales/indexad.jsp'</script>");
    }
    else if ( tipo.equals("CA"))
    {
        sesionOk.setAttribute("cajero", usuario);
        out.print("<script>window.location='principales/indexca.jsp'</script>");
    }
    else
    {
        sesionOk.setAttribute("gerente", usuario);
        out.print("<script>window.location='principales/indexge.jsp'</script>");
    }
}
else
{
        %>
            <jsp:forward page="index.jsp">
                <jsp:param name="error" value="Usuario y/o clave incorrectos.<br>Vuelve a intentarlo."/>
            </jsp:forward>
        <%
}
%>
