
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:useBean id="requestBean"
             class="beans.RequestBean"
             scope="session"/>


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
    requestBean.setReasonWhy("");
    if (request.getParameter("okBtn") != null){
        %><jsp:setProperty name="requestBean" property="reasonWhy"/><%
        String destination ="../controlPage/DoRequest.jsp";
        response.sendRedirect(response.encodeRedirectURL(destination));
    }
%>

<html>
<head>
    <title>Alert</title>
    <link rel="stylesheet" href="../bootstrap-4.2.1-dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="../bootstrap-4.2.1-dist/css/bootstrap-grid.css">
</head>
<body>

    <%
       if ( !InitSession.isValid()){
    %><div class="alert alert-danger" role="alert">
        <h4 class="alert-heading">Attenzione!</h4>
       <%
            for (String s : InitSession.getMsg().getMsgList()){
            %><hr> <p>
    <%out.println("\n" + s);
        }%></p>
    </div> <a href="../viewPage/LoginPage.jsp" class="btn btn-primary" role="button" aria-disabled="true">Login</a><%}
        else if (!RequestSession.isValid()){
                %><div class="alert alert-danger" role="alert">
            <h4 class="alert-heading">Attenzione!</h4>
           <%
                for (String s : RequestSession.getMsg().getMsgList()) {
                   %><hr><p><% out.println(s);
                }%></p>
    </div>
    <nav aria-label="Page navigation example">
        <ul class="pagination">
            <li class="page-item"><a class="page-link" href="../viewPage/ContractManagementPage.jsp"> << Pagina iniziale   </a></li>
            <%   if (RequestSession.getContract() != null){
            %> <li class="page-item"><a class="page-link" href="../controlPage/GetContractInfo.jsp?contractId=<%=RequestSession.getContractId()%>&btnName=make">  Gestione modifiche >>   </a></li>
            <%}%>
        </ul>
    </nav>
    <%}
        else if (!SubmitSession.isValid()){
            %><div class="alert alert-danger" role="alert">
                <h4 class="alert-heading">Attenzione!</h4>
                <%
                        for (String s : SubmitSession.getMsg().getMsgList()){
                %><hr><p><% out.println(s);
            }%></p>
    </div>

    <a href="../viewPage/ContractManagementPage.jsp" class="btn btn-primary" role="button" aria-disabled="true">Torna alla pagina iniziale</a><%
    }
else {%>
        <div class="alert alert-warning" role="alert">
           Attenzione! Sicuro di voler inviare la richiesta? Una volta inviata non potrai più cambiarla.
        </div>
        <form action="../viewPage/AlertPage.jsp" method="post">
        <div class="form-group">
            <label for="reason">Inserisci una motivazione</label>
            <textarea class="form-control" id="reason" name="reasonWhy" rows="3"></textarea>
        </div>
            <input type="submit" name="okBtn" value="Conferma" >
        </form>
    <nav aria-label="Page navigation example">
        <ul class="pagination">
            <li class="page-item"><a class="page-link" href="../controlPage/GetContractInfo.jsp?contractId=<%=RequestSession.getContractId()%>&btnName=make"> << Gestione modifiche   </a></li>
            <li class="page-item"><a class="page-link" href="../controlPage/GetRequests.jsp">Riepilogo >></a></li>
        </ul>
    </nav>
    <%}%>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="../bootstrap-4.2.1-dist/js/bootstrap.min.js"></script>
</body>
</html>
