<%@ page import="entity.TypeOfPayment" %>
<%@ page import="entity.modification.TypeOfModification" %>
<%@ page import="java.util.Formatter" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="Beans.OptionalService" %>

<jsp:useBean id="contractInfo"
             class="Beans.ContractInfoBean"
             scope="session"/>

<jsp:useBean id="msg"
             class="Beans.ErrorMsg"
             scope="request"/>

<jsp:useBean id="requestBean"
             class="Beans.RequestBean"
             scope="session"/>

<html>
<head>
    <title>Gestione Modifiche</title>
    <link rel="stylesheet" href="../bootstrap-4.2.1-dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="../bootstrap-4.2.1-dist/css/bootstrap-grid.css">
</head>
<body>

<%
    if (request.getParameter("paymentMethodBtn") != null) { //metodo di pagamento
        String valoreSelect = request.getParameter("objectToChange");
                // Effettuo il redirect alla pagina di destinazione
    %>
        <jsp:setProperty name="requestBean" property="sender" value="${contractInfo.userNickname}"/>
       <jsp:setProperty name="requestBean" property="type" value="<%=TypeOfModification.CHANGE_PAYMENTMETHOD%>"/>
        <jsp:setProperty name="requestBean" property="objectToChange" value="<%=TypeOfPayment.getType(valoreSelect)%>"/>
     <%
                String destination ="../viewPage/AlertPage.jsp";
        response.sendRedirect(response.encodeRedirectURL(destination));
    }


    else if (request.getParameter("TerminationDateBtn") != null){ //data di scadenza
        String valoreSelect = request.getParameter("data");
     %>
        <jsp:setProperty name="requestBean" property="sender" value="${contractInfo.userNickname}"/>
        <jsp:setProperty name="requestBean" property="type" value="<%=TypeOfModification.CHANGE_TERMINATIONDATE%>"/>
        <jsp:setProperty name="requestBean" property="objectToChange" value="<%=LocalDate.parse(valoreSelect)%>"/>
        <%
                String destination ="../viewPage/AlertPage.jsp";
                response.sendRedirect(response.encodeRedirectURL(destination));
            }

    else if (request.getParameter("DeleteServiceBtn") != null){ //rimozione servizio
        String valoreSelect = request.getParameter("serviceId");
        OptionalService service = new OptionalService();
        service.setServiceId(Integer.parseInt(valoreSelect));
        for (OptionalService item : contractInfo.getContract().getServiceList())
            if (item.equals(service)){
                service = item;
                break;
            }
            %>
            <jsp:setProperty name="requestBean" property="sender" value="${contractInfo.userNickname}"/>
            <jsp:setProperty name="requestBean" property="type" value="<%=TypeOfModification.REMOVE_SERVICE%>"/>
            <jsp:setProperty name="requestBean" property="objectToChange" value="<%=service%>"/>
            <%

            String destination ="../viewPage/AlertPage.jsp";
            response.sendRedirect(response.encodeRedirectURL(destination));
        }

    else if (request.getParameter("AddServiceBtn") != null){ //aggiunta servizio
        OptionalService service;
        int price = 0;
        try {
            price = Integer.parseInt(request.getParameter("servicePrice"));
        } catch(NumberFormatException e){
            e.printStackTrace();
        }finally {
            service = new OptionalService(request.getParameter("serviceName"), price, request.getParameter("serviceDescription"));
        }
        if (service.isValid()){
    %>
        <jsp:setProperty name="requestBean" property="sender" value="${contractInfo.userNickname}"/>
        <jsp:setProperty name="requestBean" property="type" value="<%=TypeOfModification.ADD_SERVICE%>"/>
        <jsp:setProperty name="requestBean" property="objectToChange" value="<%=service%>"/>
    <%
                String destination ="../viewPage/AlertPage.jsp";
                response.sendRedirect(response.encodeRedirectURL(destination));
        }
        else {
            for (String item : service.getMsg().getMsgList()){
            %><div class="alert alert-danger" role="alert"><%out.println(item);%> </div><%
            }
        }
    }
%>


    <h1>Gestione Modifiche</h1>

    <h2>Dati Contrattuali</h2>

    <!--
    todo controllo sui dati !
    -->
    <div class="alert alert-primary" role="alert">
        A simple primary alert—check it out!
    </div>

    <table class="table table-sm">
        <thead>
        <tr>
            <th scope="col"></th>
            <th scope="col"></th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <th scope="row">Codice</th>
            <th scope="row">
                <%
                    out.print(contractInfo.getContract().getContractId());
                %>
            </th>
        </tr>
        <tr>
            <th scope="row">Locatore</th>
            <th scope="row"><%
                out.print(contractInfo.getContract().getTenantNickname());
            %></th>
        </tr>
        <tr>
            <th scope="row">Locatario</th>
            <th scope="row"><%
                out.print(contractInfo.getContract().getRenterNickname());
            %></th>
        </tr>
        <tr>
            <th scope="row">Prezzo lordo per rata</th>
            <th scope="row"><%
                out.print(contractInfo.getContract().getGrossPrice());
            %></th>
        </tr>
        <tr>
            <th scope="row">Prezzo netto per rata</th>
            <th scope="row"><%
                out.print(contractInfo.getContract().getNetPrice());
            %></th>
        </tr>
        <tr>
            <th scope="row">Pagamento ogni:
            <%
                out.print(contractInfo.getContract().getFrequencyOfPayment());
            %></th><th scope="row">mesi</th>

        </tr>
        <tr>
            <th scope="row">Metodo di pagamento</th>
             <th>  <form action="../viewPage/RequestPage.jsp?" method="post" >
                 <select name="objectToChange" >
                     <%
                         for (TypeOfPayment payment : TypeOfPayment.values() ) {
                             Formatter f = new Formatter() ;
                             f.format("<option value=\"%s\" %s>%s</option>",
                                     payment.name(),
                                     payment.name().equals(contractInfo.getContract().getPaymentMethod())
                                             ? "selected=\"selected\"" : "",
                                     payment.getDescription() ) ;
                             out.println(f.toString()) ;
                         }
                     %>
                 </select>
                 <input type="submit" name="paymentMethodBtn" value="Cambia"/>
             </form>
             </th>
        </tr>
        <tr>
            <th scope="row">Data Stipulazione</th>
            <th>   <% out.print(contractInfo.getContract().getStipulationDate()); %></th>
        </tr>
        <tr>
            <th scope="row">Data Terminazione</th>
            <th scope="row"><form action="../viewPage/RequestPage.jsp" method="post">
                <div><id></id></div>
                <input type="date" name="data" value="<%=contractInfo.getContract().getTerminationDate()%>"/>
                <input type="submit" name="TerminationDateBtn" value="Cambia"/>
            </form></th>
        </tr>
        </tbody>
    </table>

<h2>Lista dei servizi</h2>
<table class="table">
    <thead class="thead-dark">
    <tr>
        <th scope="col">codice</th>
        <th scope="col">servizio</th>
        <th scope="col">prezzo</th>
        <th scope="col">descrizione</th>
        <th scope="col"></th>
    </tr>
    </thead>
    <tbody>
    <%
        for (OptionalService service : contractInfo.getContract().getServiceList()){%>
    <tr><form action="../viewPage/RequestPage.jsp" method="post">
        <th scope="row"><%=service.getServiceId()%></th>
        <th scope="row"><%=service.getServiceName()%></th>
        <th scope="row"><%=service.getServicePrice()%></th>
        <th scope="row"><%=service.getDescription()%></th>
        <input type="hidden" name="serviceId" value="<%=service.getServiceId()%>">
        <th scope="row"><input type="submit" name="DeleteServiceBtn" value="elimina"></th>
    </form></tr><%
        }%>

    <tr><form action="../viewPage/RequestPage.jsp" method="post">
        <th scope="row"></th>
        <th scope="row">
           <div class="input-group mb-3">
            <input type="text" class="form-control" placeholder="Nome servizio" name="serviceName" aria-describedby="basic-addon1">
           </div>
        </th>
        <th scope="row">
            <div class="input-group mb-3">
            <input type="text" class="form-control" placeholder="Prezzo servizio" name="servicePrice" aria-describedby="basic-addon1">
            </div>
        </th>
        <th scope="row">
            <div class="input-group mb-3">
                <input type="text" class="form-control" placeholder="descrizione" name="serviceDescription" aria-describedby="basic-addon1">
            </div>
        </th>
        <th scope="row">
            <input type="submit" class="form-control" placeholder="" aria-label="" name="AddServiceBtn" aria-describedby="basic-addon1">
        </th>
    </form></tr>
    </tbody>
</table>
<a href="../controlPage/GetRequests.jsp" class="btn btn-primary" role="button" aria-disabled="true">Riepilogo</a>
</body>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="../bootstrap-4.2.1-dist/js/bootstrap.min.js"></script>
</html>
