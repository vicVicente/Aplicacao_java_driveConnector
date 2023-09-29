<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Eclusão de cursos</title>
    </head>
    <body>
        <%
            
            //Declaração de variáveis
            String c;
            Connection conexao;
            String Driver, caminhoBD, user, pass, sql ;
            
            //Receber o código digitado no form excur.html
            c = request.getParameter("codigo");
            
            try{

                
                //Conectar com o banco de dados
                Driver ="com.mysql.cj.jdbc.Driver";
                Class.forName(Driver);
                caminhoBD = "jdbc:mysql://localhost:3306/quintas_noite";
                user = "root";
                pass = "Sua senha";
                sql = "DELETE FROM curso WHERE codigo = ?";
                conexao = DriverManager.getConnection(caminhoBD, user , pass);
                //Excluir o curso de código informado
                PreparedStatement st = conexao.prepareStatement(sql);
                st.setString(1,c); //Completa o delete no lugar do "?"
                int resultado = st.executeUpdate(); // Executa o comando "delete", no caso é a query que definimos acima.
                
                if(resultado == 1 ){
                    //Mostra a mesagem de confirmação de exclusão
                    out.print("O curso " + c + " foi deletado com sucesso!");
                }else{
                    //Mostra a mesagem de confirmação de exclusão
                    out.print("O curso de código" + c + " não está cadastrado!");
                }
                
            }catch(SQLException e){
                out.print("Entre em contato com o suporte e informe o erro " + e.getErrorCode());
            }    
        %>
    </body>
</html>
