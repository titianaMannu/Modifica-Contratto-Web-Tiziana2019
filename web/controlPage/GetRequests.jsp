
<jsp:useBean id="msg"
             class="Beans.ErrorMsg"
             scope="request"/>

<jsp:useBean id="RequestModel"
             class="Beans.RequestModelBean"
             scope="session"/>

<jsp:useBean id="RequestList"
             class="Beans.RequestListBean"
             scope="session"/>

<%
    RequestList.clear();
    RequestList.addAll(RequestModel.getModel().getAllRequests());
%>
<jsp:forward page="../viewPage/SummaryPage.jsp"/>