<jsp:useBean id="RequestSession"
             class="beans.RequestSessionBean"
             scope="session"/>


<jsp:useBean id="SubmitSession"
             class="beans.SubmitSessionBean"
             scope="session"/>


<%
    RequestSession.getMsg().clear();
    SubmitSession.getMsg().clear();
    if (request.getParameter("contractId") != null) {
        int contractId = Integer.parseInt(request.getParameter("contractId"));
        //assegno il contratto ai bean di sessione
        RequestSession.setContractId(contractId);
        SubmitSession.setContractId(contractId);
    }

    if (request.getParameter("btnName").equals("make")){
            %> <jsp:forward page="../viewPage/RequestPage.jsp"/><%
    }
    else if (request.getParameter("btnName").equals("reply")){
        %> <jsp:forward page="../controlPage/GetSubmits.jsp"/><%}

%>

