
<jsp:useBean id="msg"
             class="Beans.ErrorMsg"
             scope="session"/>

<jsp:useBean id="SubmitModel"
             class="Beans.SubmitModelBean"
             scope="session"/>

<jsp:useBean id="RequestList"
             class="Beans.RequestListBean"
             scope="session"/>

<%
    RequestList.clear();
    RequestList.addAll(SubmitModel.getModel().getSubmits());
%>

<jsp:forward page="../viewPage/SubmitPage.jsp"/>