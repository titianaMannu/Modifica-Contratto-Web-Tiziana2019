<%@ page import="Beans.RequestBean" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<jsp:useBean id="SubmitSession"
             class="Beans.SubmitControllerBean"
             scope="session"/>

<jsp:useBean id="RequestList"
             class="Beans.RequestListBean"
             scope="session"/>

<%

    if (SubmitSession == null){
%><jsp:forward page="../viewPage/AlertPage.jsp"/><%
    }
   else  if ( !SubmitSession.isValid() ){
%><jsp:forward page="../viewPage/AlertPage.jsp"/><%
    }
   else
    SubmitSession.getMsg().clear();
%>
<html>
<head>
    <title>Riepilogo</title>
    <link rel="stylesheet" href="../bootstrap-4.2.1-dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="../bootstrap-4.2.1-dist/css/bootstrap-grid.css">
</head>
<body>
<table class="table table-striped table-dark">
    <thead>
    <tr>
        <th scope="col">Richiesta Modifica</th>
        <th scope="col">Oggetto della modifica</th>
        <th scope="col">Motivazione della richiesta</th>
        <th scope="col">Data Invio</th>
        <th scope="col"></th>
        <th scope="col"></th>
    </tr>
    </thead>
    <tbody>
    <%
        if(RequestList.isEmpty()){
            SubmitSession.getMsg().addMsg("Non ci sono richieste per te\n");
            %><jsp:forward page="../viewPage/AlertPage.jsp"/><%
        }
        for (RequestBean requestBean : RequestList.getList()){
    %>
    <tr>
        <th scope="row"><%=requestBean.getType().getDescription()%></th>
        <th scope="row"><%=requestBean.getObjectToChange().toString()%></th>
        <th scope="row"><%=requestBean.getReasonWhy()%></th>
        <th scope="row"><%=requestBean.getDate().toString()%></th>
        <form action="../controlPage/AcceptPage.jsp">
            <input type="hidden" name="toEvaluate" value="<%=requestBean.getRequestId()%>">
            <th scope="row"><input type="submit" value="accetta"></th></form>
        <form action="../controlPage/DeclinePage.jsp">
        <input type="hidden" name="toEvaluate" value="<%=requestBean.getRequestId()%>">
        <th scope="row"><input type="submit"  value="rifiuta"></th></form>
    </tr>
    <%
        }
    %>
    </tbody>
</table>
<form action="../viewPage/ContractManagementPage.jsp">
    <input type="hidden" name="userNickname" value="${SubmitSession.userNickName}">
    <input type="submit" value="Torna alla pagina iniziale">
</form>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="../bootstrap-4.2.1-dist/js/bootstrap.min.js"></script>
</body>
</html>
