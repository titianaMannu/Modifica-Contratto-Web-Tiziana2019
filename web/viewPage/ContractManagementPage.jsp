<%@ page import="entity.ActiveContract" %>
<%@ page import="java.util.List" %>
<%@ page import="beans.ActiveContractBean" %>
<%@page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:useBean id="InitSession"
             class="beans.InitSessionBean"
             scope="session"/>

<jsp:useBean id="RequestSession"
             class="beans.RequestSessionBean"
             scope="session"/>



<jsp:useBean id="SubmitSession"
             class="beans.SubmitSessionBean"
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
<meta http-equiv="refresh" content="6; url=../viewPage/ContractManagementPage.jsp">
<html>
<head>
    <title>Gestione Contratto</title>
    <link rel="stylesheet" href="../bootstrap-4.2.1-dist/css/bootstrap.min.css" >
</head>
<body>
<h1>Gestione Contratto</h1>
    <h2>Hello  ${InitSession.userNickName} !</h2>
    <table class="table">
        <thead  class="thead-dark">
        <tr>
            <th scope="col">Codice Contratto</th>
            <th scope="col">#Richieste</th>
            <th scope="col">Vedi Richieste</th>
            <th scope="col">Invia una richiesta</th>
        </tr>
        </thead>
        <tbody> <%
                    List<ActiveContractBean> list = InitSession.getAllContract(); //lista di contratti in lettura
                    if (list.isEmpty()){
                        InitSession.getMsg().addMsg("Non ci sono contratti da mostrare!\n");
                        %><jsp:forward page="../viewPage/AlertPage.jsp"/><%
                }
                    for (ActiveContractBean contract : list){
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
            </tr>
        <%}%>
        </tbody>
    </table>
<a href="../viewPage/LoginPage.jsp" class="btn btn-primary" role="button" aria-disabled="true">Logout</a>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="../bootstrap-4.2.1-dist/js/bootstrap.min.js"></script>
</body>
</html>
