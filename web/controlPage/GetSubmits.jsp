
<jsp:useBean id="SubmitSession"
             class="Beans.SubmitControllerBean"
             scope="session"/>


<jsp:useBean id="RequestList"
             class="Beans.RequestListBean"
             scope="session"/>

<%
    RequestList.clear();
    SubmitSession.getMsg().clear();
    RequestList.addAll(SubmitSession.getMySubmits());
    if(RequestList.isEmpty()){
        SubmitSession.getMsg().addMsg("Non ci sono richieste per te\n");
        %><jsp:forward page="../viewPage/AlertPage.jsp"/><%
    }
%>

<jsp:forward page="../viewPage/SubmitPage.jsp"/>