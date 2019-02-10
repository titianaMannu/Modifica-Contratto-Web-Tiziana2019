

<jsp:useBean id="requestBean"
             class="beans.RequestBean"
             scope="session"/>

<jsp:useBean id="RequestSession"
             class="beans.RequestSessionBean"
             scope="session"/>


<%
    RequestSession.getMsg().clear();
    RequestSession.doSend(requestBean);
    if (!RequestSession.isValid()){
        %><jsp:forward page="../viewPage/AlertPage.jsp"/><%
    }
    else {
        %><jsp:forward page="GetRequests.jsp"/><%
    }
%>