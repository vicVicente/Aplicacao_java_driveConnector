<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Listagem de Cursos</title>
        <link rel="stylesheet" href="tabela.css">
    </head>
    <body>
        <%
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conexao = DriverManager.getConnection("jdbc:mysql://localhost:3306/quintas_noite", "root", "Sua senha");

            //Buscar todos os cursos da tabela curso do BD
            String sql = "SELECT * FROM curso";
            PreparedStatement st = conexao.prepareStatement(sql);

            ResultSet resultado = st.executeQuery();
        %>
        <table>
            <tr>  
                <th> Código </th>
                <th> Nome </th>
                <th> Duração </th>
                <th> Exclusão </th>
            </tr>

            <%
                //Exibindo os cursos
                while (resultado.next()) {
            %>
                    <tr>
                        <td><%=resultado.getString("codigo")%></td>
                        <td><%=resultado.getString("nome")%></td>
                        <td><%=resultado.getString("duracao")%></td>
                        <td><a href="excur.jsp?codigo=<%=resultado.getString("codigo")%>"> Excluir </a></td>
                    </tr>
            <%       
                }
            %>
        </table>
    </body>
</html>
