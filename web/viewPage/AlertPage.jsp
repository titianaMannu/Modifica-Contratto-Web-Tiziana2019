
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:useBean id="requestBean"
             class="Beans.RequestBean"
             scope="session"/>
<html>
<head>
    <title>Alert</title>
    <link rel="stylesheet" href="../bootstrap-4.2.1-dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="../bootstrap-4.2.1-dist/css/bootstrap-grid.css">
</head>
<body>
    <div class="alert alert-primary" role="alert">
       Attenzione! Sicuro di voler inviare la richiesta? Una volta inviata non potrai più cambiarla.
    </div>

    <a class="btn btn-primary" href="../controlPage/doRequest.jsp" role="button">Conferma</a>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="../bootstrap-4.2.1-dist/js/bootstrap.min.js"></script>
</body>
</html>
