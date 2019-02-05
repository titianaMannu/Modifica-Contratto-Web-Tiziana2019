<jsp:useBean id="RequestSession"
             class="Beans.RequestControllerBean"
             scope="session"/>


<jsp:useBean id="SubmitSession"
             class="Beans.SubmitControllerBean"
             scope="session"/>


<%
    RequestSession.getMsg().clear();
    SubmitSession.getMsg().clear();
    int contractId = Integer.parseInt(request.getParameter("contractId"));
    RequestSession.setContractId(contractId);
    SubmitSession.setContractId(contractId);
    if (request.getParameter("btnName").equals("make")){
       RequestSession.setContractId(contractId);
            %> <jsp:forward page="../viewPage/RequestPage.jsp"/><%
    }
    else if (request.getParameter("btnName").equals("reply")){
        %> <jsp:forward page="../controlPage/GetSubmits.jsp"/><%}

%>
