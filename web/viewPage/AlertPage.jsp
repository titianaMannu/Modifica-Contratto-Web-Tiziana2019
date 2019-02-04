
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:useBean id="requestBean"
             class="Beans.RequestBean"
             scope="session"/>

<jsp:useBean id="msg"
             class="Beans.ErrorMsg"
             scope="request"/>


<jsp:useBean id="RequestModel"
             class="Beans.RequestModelBean"
             scope="session"/>


<html>
<head>
    <title>Alert</title>
    <link rel="stylesheet" href="../bootstrap-4.2.1-dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="../bootstrap-4.2.1-dist/css/bootstrap-grid.css">
</head>
<body>
    <%
        if (msg.isErr()){
            %><div class="alert alert-success" role="alert">
        <h4 class="alert-heading">Errore!</h4>
        <p><%
            for (String s : msg.getMsgList()){
                out.println(s);
            }%></p>
    </div><%}
        else
            {%>
    <div class="alert alert-primary" role="alert">
       Attenzione! Sicuro di voler inviare la richiesta? Una volta inviata non potrai più cambiarla.
    </div>
    <a class="btn btn-primary" href="../controlPage/doRequest.jsp" role="button">Conferma</a>
<%}%>
    <a class="btn btn-primary" href="../controlPage/GetContractInfo.jsp?contractId=<%=RequestModel.getModel().getContract().getContractId()%>&btnName=make" role="button">Torna alla pagina di gestione delle modifiche</a>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="../bootstrap-4.2.1-dist/js/bootstrap.min.js"></script>
</body>
</html>
