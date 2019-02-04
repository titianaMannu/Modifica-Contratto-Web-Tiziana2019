<jsp:useBean id="msg"
             class="Beans.ErrorMsg"
             scope="session"/>

<jsp:useBean id="RequestModel"
             class="Beans.RequestModelBean"
             scope="session"/>

<jsp:useBean id="SubmitModel"
             class="Beans.SubmitModelBean"
             scope="session"/>

<%
    int contractId = Integer.parseInt(request.getParameter("contractId"));

    if (request.getParameter("btnName").equals("make")){
        RequestModel.getModel().setActiveContract(contractId);
            %> <jsp:forward page="../viewPage/RequestPage.jsp"/><%
    }
    else if (request.getParameter("btnName").equals("reply")){
        SubmitModel.getModel().setActiveContract(contractId);
        %> <jsp:forward page="../controlPage/GetSubmits.jsp"/><%}

%>
