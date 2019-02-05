

<jsp:useBean id="requestBean"
             class="Beans.RequestBean"
             scope="session"/>

<jsp:useBean id="RequestSession"
             class="Beans.RequestControllerBean"
             scope="session"/>


<%
    RequestSession.doSend(requestBean);
    if (!RequestSession.isValid()){
        %><jsp:forward page="../viewPage/AlertPage.jsp"/><%
    }
    else {
        %><jsp:forward page="../controlPage/GetRequests.jsp"/><%
    }
%>