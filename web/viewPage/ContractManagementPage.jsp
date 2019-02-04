<%@ page import="Beans.ActiveContract" %>
<%@page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:useBean id="InitModel"
             class="Beans.InitModelBean"
             scope="session"/>

<jsp:useBean id="RequestModel"
             class="Beans.RequestModelBean"
             scope="session"/>

<jsp:useBean id="SubmitModel"
             class="Beans.SubmitModelBean"
             scope="session"/>

<%

    String usr = request.getParameter("user");
    if ( usr != null){
       InitModel.setUser(usr);
       RequestModel.setUser(usr);
       SubmitModel.setUser(usr);
    }
%>

<html>
<head>
    <title>Gestione Contratto</title>
    <link rel="stylesheet" href="../bootstrap-4.2.1-dist/css/bootstrap.min.css" >
</head>
<body>
<h1>Gestione Contratto</h1>
    <table class="table">
        <thead  class="thead-dark">
        <tr>
            <th scope="col">Codice Contratto</th>
            <th scope="col">#Richieste</th>
            <th scope="col">Vedi Richieste</th>
            <th scope="col">Invia una richiesta</th>
            <th scope="col">Proponi rinnovo</th>
        </tr>
        </thead>
        <tbody>
            <tr>
                <%
                    for (ActiveContract contract : InitModel.getModel().getAllContract()){
                        out.print("<th scope=\"row\">");
                        out.print(contract.getContractId());
                        out.print("</th><td>");

                        out.print(InitModel.getModel().getSubmits(contract));
                        out.print("</td>");

                        if (InitModel.getModel().getSubmits(contract) > 0)
                            %>
                <th scope="row">
                <a  class="btn btn-primary" href="../controlPage/GetContractInfo.jsp?contractId=<%=contract.getContractId()%>&btnName=reply" role="button">
                Rispondi</a></th>

                <th scope="row"><a class="btn btn-primary" href="../controlPage/GetContractInfo.jsp?contractId=<%=contract.getContractId()%>&btnName=make" role="button">
                    Gestisci Richieste di modifiche</a></th>

                <th scope="row"><a class="btn btn-primary" href="../controlPage/GetContractInfo.jsp?contractId=<%=contract.getContractId()%>&user=${InitModel.model.userNickname}&btnName=renew" role="button">
                    Rinnova</a></th>
                <%}%>
            </tr>
        </tbody>
    </table>
<a href="../viewPage/LoginPage.jsp" class="btn btn-primary" role="button" aria-disabled="true">LogOut</a>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="../bootstrap-4.2.1-dist/js/bootstrap.min.js"></script>
</body>
</html>
