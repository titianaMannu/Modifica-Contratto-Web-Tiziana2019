

<jsp:useBean id="RequestSession"
             class="Beans.RequestControllerBean"
             scope="session"/>


<jsp:useBean id="RequestList"
             class="Beans.RequestListBean"
             scope="session"/>

<%
    RequestList.clear();
    RequestSession.getMsg().clear();
    RequestList.addAll(RequestSession.getMyRequest());
    if(RequestList.isEmpty()){
        RequestSession.getMsg().addMsg("Non hai ancora fatto richieste\n");
        %><jsp:forward page="../viewPage/AlertPage.jsp"/><%
    }
%>
<jsp:forward page="../viewPage/SummaryPage.jsp"/>