<jsp:useBean id="RequestSession"
             class="Beans.RequestSessionBean"
             scope="session"/>


<jsp:useBean id="SubmitSession"
             class="Beans.SubmitSessionBean"
             scope="session"/>


<%
    RequestSession.getMsg().clear();
    SubmitSession.getMsg().clear();
    int contractId = Integer.parseInt(request.getParameter("contractId"));
    //assegno il contratto ai bean di sessione
    RequestSession.setContractId(contractId);
    SubmitSession.setContractId(contractId);
    if (request.getParameter("btnName").equals("make")){
            %> <jsp:forward page="../viewPage/RequestPage.jsp"/><%
    }
    else if (request.getParameter("btnName").equals("reply")){
        %> <jsp:forward page="../controlPage/GetSubmits.jsp"/><%}

%>
