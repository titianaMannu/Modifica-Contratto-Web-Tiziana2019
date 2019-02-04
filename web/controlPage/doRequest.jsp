

<jsp:useBean id="requestBean"
             class="Beans.RequestBean"
             scope="session"/>

<jsp:useBean id="msg"
             class="Beans.ErrorMsg"
             scope="request"/>

<jsp:useBean id="RequestModel"
             class="Beans.RequestModelBean"
             scope="session"/>


<%
    msg.clear();
    msg.addAllMsg(RequestModel.getModel().insertRequest(requestBean));  
    if (msg.isErr()){
        %><jsp:forward page="../viewPage/AlertPage.jsp"/><%
    }
    else {
        %><jsp:forward page="../controlPage/GetRequests.jsp"/><%
    }
%>