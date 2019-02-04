<%@ page import="Beans.RequestBean" %>
<%@ page import="entity.request.RequestStatus" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:useBean id="RequestModel"
             class="Beans.RequestModelBean"
             scope="session"/>

<jsp:useBean id="RequestList"
             class="Beans.RequestListBean"
             scope="session"/>

<jsp:useBean id="msg"
             class="Beans.ErrorMsg"
             scope="session"/>

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
        <th scope="col">Status</th>
        <th scope="col"></th>
    </tr>
    </thead>
    <tbody>
        <%
            for (RequestBean requestBean : RequestList.getList()){
                %>
                    <tr><form action="../controlPage/deleteRequest.jsp">
                        <th scope="row"><%=requestBean.getType().getDescription()%></th>
                        <th scope="row"><%=requestBean.getObjectToChange().toString()%></th>
                        <th scope="row"><%=requestBean.getReasonWhy()%></th>
                        <th scope="row"><%=requestBean.getDate().toString()%></th>
                        <th scope="row"><%=requestBean.getStatus().getDescription()%></th>
                        <%
                            if(requestBean.getStatus() != RequestStatus.PENDING){
                                %>
                                <input type="hidden" name="toDelete" value="<%=requestBean.getRequestId()%>">
                                <th scope="row"> <input type="hidden" name="toDelete" value="<%=requestBean.getRequestId()%>">
                                    <input type="submit" name="deleteBtn" value="segna come letto"></th>
                                <%
                            }
                        %>

                    </form></tr>
                <%
            }
        %>
    </tbody>
</table>
<form action="../controlPage/GetContractInfo.jsp">
     <input type="hidden" name="contractId" value="${RequestModel.model.contract.contractId}"/>
    <input type="hidden" name="btnName" value="make">
    <input type="submit" value="Torna alla Pagina di Gestione Modifiche">
</form>
 <form action="../viewPage/ContractManagementPage.jsp">
     <input type="hidden" name="userNickname" value="${RequestModel.model.userNickname}">
     <input type="submit" value="Torna alla pagina iniziale">
 </form>

 <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
 <script src="../bootstrap-4.2.1-dist/js/bootstrap.min.js"></script>
</body>
</html>
