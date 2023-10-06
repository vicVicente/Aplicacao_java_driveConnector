<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException" %>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Dados do curso</title>
    </head>
    <body>
        <%
            //Declaração de variáveis 
            String c;
            Connection conexao;
            String sql;
            PreparedStatement st;
            try {
                //Receber o código do curso  digitado no form altcur.html
                c = request.getParameter("codigo");
                //Conectar com o banco de dados
                Class.forName("com.mysql.cj.jdbc.Driver");
                conexao = DriverManager.getConnection("jdbc:mysql://localhost:3306/quintas_noite", "root", "Sua senha");
                //Buscar o curso na tabela do BD
                sql = "SELECT * FROM curso WHERE codigo = ?";
                st = conexao.prepareStatement(sql);
                st.setString(1, c);
                ResultSet resultado = st.executeQuery();//Executa o select

                if (resultado.next()) {//Se o curso foi encontrado na tabela
                    //Carregar os dados do curso em um formulário HTML           
%>
        <form method="post" action="altcur.jsp">
            <p>
                <label for="cod">Código:*</label>
                <input readonly id="cod" type="text" name="codigo" size="5" maxlength="5" required value="<%= resultado.getString("codigo")%>"> 
            </p>
            <p>
                <label for="nom">Nome:*</label>
                <input id="nom" type="text" name="nome" size="50" maxlength="50" required value="<%= resultado.getString("nome")%>">
            </p>
            <p>
                <label for="dur">Duração:</label>
                <input id="dur" type="text" name="duracao" size="15" maxlength="15" value="<%= resultado.getString("duracao")%>">
            </p>
            <p>
                <input type="submit" value="Salvar Alterações">
            </p>                
        </form>        
        <%
                } else {
                    out.print("Este curso de código " + c + " não está cadastrado.");
                }
            } catch (SQLException e) {
                out.print("Entre em contato com  o suporte e informe o código de erro: " + e.getErrorCode());
            }

        %>
    </body>
</html>
