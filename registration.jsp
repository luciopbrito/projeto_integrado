<%@page language="java" import="java.util.*" import="java.sql.*" contentType="text/html" pageEncoding="UTF-8"%>
<%
    // cria as variaveis e armazena as informações digitadas pelo usuario
    String name = new String(request.getParameter("name").getBytes("ISO-8859-1"), "UTF-8");
    String surname = new String(request.getParameter("surname").getBytes("ISO-8859-1"), "UTF-8");
    String full_name = new String(name + " " + surname);
    String cep = request.getParameter("cep");
    String street = request.getParameter("street");
    String number = request.getParameter("number");
    String district = new String(request.getParameter("district").getBytes("ISO-8859-1"), "UTF-8");
    String city = new String(request.getParameter("city").getBytes("ISO-8859-1"), "UTF-8");
    String cpf = request.getParameter("cpf");
    String phone =  request.getParameter("phone");
    String endereco = "Rua " + street + "," + number + "-" + district + "." + cep + " " + city;
    String email = request.getParameter("email");
    String password = new String(request.getParameter("password").getBytes("ISO-8859-1"), "UTF-8");

    // String vnome  = request.getParameter("txtNome");
    // int    vidade = Integer.parseInt( request.getParameter("txtIdade") );
    // String vemail = request.getParameter("txtEmail");

    // variaveis para o banco de dados
    String banco    = "projetointegrador";
    String enderecoBanco = "jdbc:mysql://localhost:3306/" + banco ;
    String usuario  = "root" ;
    String senha    = "" ;

    String driver   = "com.mysql.jdbc.Driver" ;

    //Carregar o driver na memoria
    Class.forName( driver );

    //cria a variavel para conectar com o banco
    Connection conexao ;

    //Abrir a conexao com o banco de dados
    conexao = DriverManager.getConnection(enderecoBanco, usuario, senha) ;

    //Cria a variavel sql com o comando de Inserir
    // String sql = "INSERT INTO alunos (nome,idade,email) values(?,?,?)" ;

    // teste
    String sql = "SELECT email FROM clientes WHERE email = '" + email + "'";

    PreparedStatement stm = conexao.prepareStatement(sql);
    ResultSet dados = stm.executeQuery() ;
    String test_email = "";
    Boolean do_register = false;
    while (dados.next())
    {
        test_email = dados.getString("email");
        if (test_email != "")
        {
            // String message = "<h1>Este email já é utilizado no sistema</h1>";
            // String button = "<button onclick='history_back()'>Voltar ao Cadastro</button>";
            // String script = "<script src='./js/backHistory.js'></script>";
            // out.print(message + button + script);
            out.print("exite este email");
            do_register = true;
        }
    }

    if (do_register == false)
    {
        //inserindo no banco
        sql = "INSERT INTO clientes (name, phone, email, password, cpf, endereco) values(?,?,?,?,?,?)";

        stm = conexao.prepareStatement(sql);
        stm.setString(1, full_name);
        stm.setString(2, phone);
        stm.setString(3, email);
        stm.setString(4, password);
        stm.setString(5, cpf);
        stm.setString(6, endereco);

        stm.execute() ;
        stm.close();
        response.sendRedirect("./success-register.html");
    } 
%>