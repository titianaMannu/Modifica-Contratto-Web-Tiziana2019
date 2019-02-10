
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
    if (request.getParameter("okBtn") != null){
        %><jsp:setProperty name="requestBean" property="reasonWhy"/><%
        String destination ="../controlPage/DoRequest.jsp";
        response.sendRedirect(response.encodeRedirectURL(destination));
    }
%>
<!--
todo formattare meglio i messaggi di errore
-->
<html>
<head>
    <title>Alert</title>
    <link rel="stylesheet" href="../bootstrap-4.2.1-dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="../bootstrap-4.2.1-dist/css/bootstrap-grid.css">
</head>
<body>

    <%
        if (InitSession == null ){
    %><div class="alert alert-success" role="alert">
        <h4 class="alert-heading">Errore!</h4>
        <p>
            Tornare alla pagina iniziale o rieffettuare il login
        </p><%
        }
    else if ( !InitSession.isValid()){
    %><div class="alert alert-success" role="alert">
        <h4 class="alert-heading">Attenzione!</h4>
        <p><%
            for (String s : InitSession.getMsg().getMsgList()){
            out.println(s);
            }%></p>
    </div><%}
        else if (RequestSession == null ){
            %><div class="alert alert-success" role="alert">
                <h4 class="alert-heading">Errore!</h4>
                <p> rieffettuare il login</p><%
        }
        else if (!RequestSession.isValid()){
                %><div class="alert alert-success" role="alert">
            <h4 class="alert-heading">Attenzione!</h4>
            <p><%
                for (String s : RequestSession.getMsg().getMsgList()) {
                    out.println(s);
                }%></p>
    </div>
    <a href="../viewPage/ContractManagementPage.jsp" class="btn btn-primary" role="button" aria-disabled="true">Torna alla pagina iniziale</a>
    <%   if (RequestSession.getContract() != null){
            %> <a class="btn btn-primary" href="../controlPage/GetContractInfo.jsp?contractId=<%=RequestSession.getContract().getContractId()%>&btnName=make" role="button">Torna alla pagina di gestione delle modifiche</a>
        <%}
        }
        else if (SubmitSession == null ){
            %><div class="alert alert-success" role="alert">
                <h4 class="alert-heading">Errore!</h4>
                <p>
                    Tornare alla pagina iniziale o rieffettuare il login
                </p><%
        }
        else if (!SubmitSession.isValid()){
            %><div class="alert alert-success" role="alert">
                <h4 class="alert-heading">Attenzione!</h4>
                <p><%
                    for (String s : SubmitSession.getMsg().getMsgList()){
                        out.println(s);
            }%></p>
    </div>

    <a href="../viewPage/ContractManagementPage.jsp" class="btn btn-primary" role="button" aria-disabled="true">Torna alla pagina iniziale</a><%
    }
else {%>
        <div class="alert alert-primary" role="alert">
           Attenzione! Sicuro di voler inviare la richiesta? Una volta inviata non potrai più cambiarla.
        </div>
        <form action="../viewPage/AlertPage.jsp" method="post">
        <div class="form-group">
            <label for="reason">Inserisci una motivazione</label>
            <textarea class="form-control" id="reason" name="reasonWhy" rows="3"></textarea>
        </div>
            <input type="submit" name="okBtn" value="Conferma" >
        </form>

        <a class="btn btn-primary" href="../controlPage/GetContractInfo.jsp?contractId=<%=RequestSession.getContract().getContractId()%>&btnName=make" role="button">Torna alla pagina di gestione delle modifiche</a>
    <%}%>
    <a href="../viewPage/LoginPage.jsp" class="btn btn-primary" role="button" aria-disabled="true">Login</a>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="../bootstrap-4.2.1-dist/js/bootstrap.min.js"></script>
</body>
</html>
