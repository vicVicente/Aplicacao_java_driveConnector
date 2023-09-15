<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String c, n, d;
            
            c = request.getParameter("codigo");
            n = request.getParameter("nome");
            d = request.getParameter("duracao");
            
            try {
            
                // Conecta com o banco de dados
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conexao = DriverManager.getConnection("jdbc:mysql://localhost:3306/quintas_noite","root","sua senha");

                //Inserir os dados recebidos no cadcur.html na tabela curso do BD
                String sql = "INSERT INTO curso VALUES(?,?,?)";
                PreparedStatement st = conexao.prepareStatement(sql);
                st.setString(1, c);
                st.setString(2, n);
                st.setString(3, d);
                st.executeUpdate(); 
                // Ele executa o insert
                out.print("Curso cadastrado com sucesso!");
                
            } catch(Exception ex){
                String mensagemErro = ex.getMessage();
                //Duplicate entry 'cc' for key 'curso.PRIMARY'
                 if (mensagemErro.contains("Duplicate entry")) {
                    out.print("<p style='color: blue'>Este curso já está cadastrado<p>");
                } else {
                    out.print("Erro = " + mensagemErro);
                }
            }
            
            %>
    </body>
</html>
