<%@page import="javax.swing.GroupLayout.Alignment"%>
<%@page import="java.io.DataOutputStream"%>
<%@page import="com.itextpdf.text.Document"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="com.itextpdf.text.pdf.PdfWriter"%>
<%@page import="com.itextpdf.text.Paragraph"%>
<%@page import="java.io.DataOutput"%>
<%@page import="java.io.*"%>
<%@page import="java.awt.Color"%>
<%@page import="com.itextpdf.text.*"%>
<%@page import="com.itextpdf.text.pdf.*"%>
<%@page import="com.itextpdf.text.BaseColor"%>

<%@page import="java.util.Calendar"%>
<%@page import="java.util.Vector"%>
<%@page import="java.sql.ResultSet" %>
<%@page import="control.ConectaDb" %>
<%@page session="true" %>

        <%
        HttpSession sesionOk = request.getSession();

        Vector codigo = (Vector) sesionOk.getAttribute("codigo");
        Vector canti = (Vector) sesionOk.getAttribute("canti");
        Vector val = (Vector) sesionOk.getAttribute("val");
        Vector idProducto = (Vector) sesionOk.getAttribute("idProducto");

        String nomCli = (String)sesionOk.getAttribute("sesionNomCliente");
        String idCli = (String)sesionOk.getAttribute("sesionIdCliente");
        String gerente = (String)sesionOk.getAttribute("gerente");
        %>

<%

response.setContentType ( "application/pdf");

Document document = new Document();

ByteArrayOutputStream buffer = new ByteArrayOutputStream ();

PdfWriter writer = PdfWriter.getInstance(document, response.getOutputStream());

document.open (); // de aqui para abajo se forma el documento
Image imagen = Image.getInstance ("/logo.gif");//este es para la imagen del logo
Paragraph titulo = new Paragraph("Factura de venta a Clientes");//titulo
Paragraph espacio = new Paragraph("                     ");//espacio
titulo.setAlignment(Element.ALIGN_CENTER);//para centrar el titulo

PdfPTable table=new PdfPTable(5);

PdfPCell cell = new PdfPCell (new Paragraph ("Factura"));
cell.setColspan (5);
cell.setHorizontalAlignment (Element.ALIGN_CENTER);
cell.setPadding (10.0f);
table.addCell (cell);

table.addCell("Cliente");
table.addCell(nomCli);
table.addCell("");
table.addCell("Id");
table.addCell(idCli);

table.addCell("Vendedor");
table.addCell("");
table.addCell(gerente);
table.addCell("");
table.addCell("");

table.addCell("Numero");
table.addCell("Nombre");
table.addCell("Valor");
table.addCell("Cantidad");
table.addCell("Valor Parcial");

    double total = 0;
    double totalIva = 0;
    for (int i = 0; i < codigo.size(); i++)
    {
        Object miCodigo = codigo.elementAt(i);
        Object miValor = val.elementAt(i);
        Object miCan = canti.elementAt(i);
        long vpar = 0;
        vpar = Long.parseLong(val.elementAt(i).toString()) * Long.parseLong(canti.elementAt(i).toString());
        table.addCell(""+(i+1));
        table.addCell(""+miCodigo);
        table.addCell(""+miValor);
        table.addCell(""+miCan);
        table.addCell(""+vpar);
        total += vpar;
    }

    totalIva = total * 0.16;

table.addCell("Total Iva");
table.addCell("" + totalIva);
table.addCell("");
table.addCell("Total Factura");
table.addCell("" + total + totalIva);


//de aqui para abajo agregamos lo que queremos
document.add(imagen);
document.add(titulo);
document.add(espacio);
document.add(table);


document.close ();

DataOutput output = new DataOutputStream (response.getOutputStream ());

byte [] bytes = buffer.toByteArray ();

response.setContentLength (bytes.length);

for(int i = 0; i <bytes.length; i ++)
{
    output.writeByte (bytes [i]);
}

%>
