<%@ page import="Beans.ContractInfoBean" %>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="contractInfoList"
             class="Beans.ContractInfoBeanList"
             scope="request"/>

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
                    for (ContractInfoBean infoBean : contractInfoList.getContractInfoBeans() ){
                        out.print("<th scope=\"row\">");
                        out.print(infoBean.getContract().getContractId());
                        out.print("</th><td>");

                        out.print(infoBean.getRequests().size());
                        out.print("</td><td>");

                        if (infoBean.getRequests().size() > 0)
                             out.print("<a name=\"reply\" class=\"btn btn-primary\" href=\"../controlPage/GetContractInfo.jsp?contractId=" +
                                     + infoBean.getContract().getContractId() +"&user=" + contractInfoList.getUserNickName()+"\" role=\"button\">" +
                                     "Rispondi</a>");
                        out.print("</td><td>");
                        out.print("<a name=\"make\" class=\"btn btn-primary\" href=\"../controlPage/GetContractInfo.jsp?contractId=" +
                                + infoBean.getContract().getContractId() +"&user=" + contractInfoList.getUserNickName()+
                                "\" role=\"button\">" +
                                "Gestisci Richieste di modifica</a>");

                        out.print("</td><td>");
                        out.print("<a class=\"btn btn-primary\" href=\"#?index=" +
                                + infoBean.getContract().getContractId() +"\" role=\"button\">" +
                                "Rinnova</a>");
                        out.print("</td><td>");
                    }
                %>
            </tr>
        </tbody>
    </table>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="../bootstrap-4.2.1-dist/js/bootstrap.min.js"></script>
</body>
</html>