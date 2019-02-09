<%@ page import="entity.ActiveContract" %>
<%@ page import="java.util.List" %>
<%@page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:useBean id="InitSession"
             class="Beans.InitSessionBean"
             scope="session"/>

<jsp:useBean id="RequestSession"
             class="Beans.RequestSessionBean"
             scope="session"/>



<jsp:useBean id="SubmitSession"
             class="Beans.SubmitSessionBean"
             scope="session"/>

<%
    InitSession.getMsg().clear();
    RequestSession.getMsg().clear();
    SubmitSession.getMsg().clear();
    String usr = request.getParameter("user");
    if ( usr != null){
        InitSession.setUserNickName(usr);
       RequestSession.setUserNickName(usr);
       SubmitSession.setUserNickName(usr);
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
        <tbody> <%
                    List<ActiveContract> list = InitSession.getAllContract(); //lista di contratti in lettura
                    if (list.isEmpty()){
                        InitSession.getMsg().addMsg("Non ci sono contratti da mostrare!\n");
                        %><jsp:forward page="../viewPage/AlertPage.jsp"/><%
                }
                    for (ActiveContract contract : list){
                        %><tr><%
                        out.print("<th scope=\"row\">");
                        out.print(contract.getContractId());
                        out.print("</th><td>");

                        out.print(InitSession.getSubmitsNumber(contract));
                        out.print("</td>");

                        if ( InitSession.getSubmitsNumber(contract) > 0){
                            %>
                <th scope="row">
                <a  class="btn btn-primary" href="../controlPage/GetContractInfo.jsp?contractId=<%=contract.getContractId()%>&btnName=reply" role="button">
                Rispondi</a></th>
                <%}else{ %>
                    <th scope="row"></th>
                <%}%>

                <th scope="row"><a class="btn btn-primary" href="../controlPage/GetContractInfo.jsp?contractId=<%=contract.getContractId()%>&btnName=make" role="button">
                    Gestisci Richieste di modifiche</a></th>

                <th scope="row"><a class="btn btn-primary" href="../controlPage/GetContractInfo.jsp?contractId=<%=contract.getContractId()%>&user=${InitSession.userNickName}&btnName=renew" role="button">
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
