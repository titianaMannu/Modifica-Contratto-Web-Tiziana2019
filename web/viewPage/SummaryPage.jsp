<%@ page import="beans.RequestBean" %>
<%@ page import="entity.request.RequestStatus" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<jsp:useBean id="RequestSession"
             class="beans.RequestSessionBean"
             scope="session"/>

<jsp:useBean id="RequestList"
             class="beans.RequestListBean"
             scope="session"/>

<meta http-equiv="refresh" content="6; url=../controlPage/GetRequests.jsp">
<%
    RequestSession.getMsg().clear();
    if (RequestList.getList().isEmpty()){
        RequestSession.getMsg().addMsg("Non hai ancora fatto richieste\n");
%><jsp:forward page="../viewPage/AlertPage.jsp"/><%
    }
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
        <th scope="col">Status</th>
        <th scope="col"></th>
    </tr>
    </thead>
    <tbody>
        <%
            for (RequestBean requestBean : RequestList.getList()){
                %>
                    <tr><form action="../controlPage/DeleteRequest.jsp">
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
 <nav aria-label="Page navigation example">
     <ul class="pagination">
         <li class="page-item"><a class="page-link" href="../viewPage/ContractManagementPage.jsp"><< Pagina iniziale   </a></li>
         <li class="page-item"><a class="page-link" href="../controlPage/GetContractInfo.jsp?contractId=<%=RequestSession.getContractId()%>&btnName=make">Gestione modifiche >></a></li>
     </ul>
 </nav>
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
 <script src="../bootstrap-4.2.1-dist/js/bootstrap.min.js"></script>
</body>
</html>
