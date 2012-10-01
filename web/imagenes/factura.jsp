<%@page  import="java.sql.ResultSet" %>
<%@page  import="control.ConectaDb" %>
<%@page session="true" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    <link href="../css/estilos.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        <%    
  ConectaDb control = new ConectaDb();
 // capturo la lista de chekbox
 String[] check  = request.getParameterValues("ch");
 // valido que se escoja al menos un producto
 if(request.getParameterValues("ch") == null){  out.print("<script languaje = javascript> alert('Escoja un producto');  history.back(); </script>"); return; }

// recibiendo valores del formulario
 String[] valores  = request.getParameterValues("val");  //valor unitario
 String[] cantidad  = request.getParameterValues("can"); //cantidad
 String[] productos = request.getParameterValues("idpro"); //idPro
 String Idp = request.getParameter("idp"); // idProveedor
 String login = request.getParameter("log"); // login del usuario logeado

 //consulta para saber el nombre del proveedor dado su codigo
 String inicio = "Select "; String fin = " from proveedores where cod_proveedor="+Idp;
 String Nombre = control.retornoCodigo(inicio, "nom_proveedor", fin);

int y = 0; 
int[] V1 = new int[check.length]; // almacena las cantidades
int[] V2 = new int[check.length]; // almacena los valores unitarios
int[] V3 = new int[check.length]; // almacena el calculo de la cantidad * el valor unitario
String[] P = new String[check.length]; //almacena el nobre de los productos
for(int k = 0; k < check.length; k++)
{
    //valido que checkbox se seleccionaron
   boolean entro = false; int h = 0;
   for(int l = 0; l < valores.length; l++)
   {
       if(l == Integer.decode(check[k])){
             entro = true; h = l; break;
        }
    }

   // si se sellecciono entonces
    if(entro == true)
    {
        //valido que la cantidad no sea vacia
        if(cantidad[h] == ""){  out.print("<script languaje = javascript> alert('Escriba la cantidad');  history.back(); </script>"); return; }
 // valido que el valor no sea vacio
        if(valores[h] == ""){  out.print("<script languaje = javascript> alert('Escriba  un valor');  history.back(); </script>"); return; }

       V1[y]= Integer.parseInt(cantidad[h]); //capturo la cantidad
        V2[y] = Integer.parseInt(valores[h]); // capturo el valor
        V3[y] = Integer.parseInt(cantidad[h]) * Integer.parseInt(valores[h]); // capturo el calculo de multiplicar la cantidad y el valor unitario

        // retorno el nombre del producto dado su id
        String inicio2 = "Select "; String fin2 = " from productos where cod_producto="+productos[h];
        String Nombre2 = control.retornoCodigo(inicio2, "des_producto", fin2);
        P[y] = Nombre2; // capturo el nombre del producto
        y++;
   }
}
// se imprime la factura
        %>
  <table class="tabla" align="center">
            <thead>
                <tr>
                    <th colspan="4" align="center">FACTURA</th>
                </tr>
            </thead>
            <tbody>
               <tr>
                    <td colspan="4">Id proveedor: <%= Idp %> </td>
                    
                </tr>
                <tr>
                     <td colspan="4">Nombre proveedor: <%= Nombre %> </td>
                  
                </tr>

                 <tr>
                     <td colspan="4">Usuario: <%= login %> </td>
                   
                </tr>
            </tbody>
            <tr>
                    <th colspan="4" align="center">Productos</th>
            </tr>

            <tr>
                    <td>producto</td>
                    <td>cantidad</td>
                    <td>valor</td>
                    <td>valor total</td>
            </tr>

         <%

         // se recorre los vectores con los productos, cantidad, valor unitario, valor total, y el total de la factura
            int tot = 0;
            for(int j = 0; j < y; j++)
            {
             tot += V3[j];
             out.print("<tr> <td> "+P[j]+" </td> <td> "+V1[j]+" </td> <td> "+V2[j]+" </td> <td> "+V3[j]+" </td>   </tr>");
            }
            %>
             <tr>
                 <th colspan="4" align="right">TOTAL FACTURA: <%= tot %></th>
             </tr>
             <form name="form1" action="compraProveedor.jsp" method="post">
             <tr>
                 <th colspan="4" align="right"><input type="submit" value="Comprar +" name="comprar" /></th>
             </tr>
             </form>

        </table>
    </body>

</html>
