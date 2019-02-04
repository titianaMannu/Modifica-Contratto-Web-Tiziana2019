<%@ page import="Beans.RequestBean" %>
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
    int id = Integer.parseInt(request.getParameter("toEvaluate"));
    RequestBean requestBean = new RequestBean();
    requestBean.setRequestId(id);
    for (RequestBean item : RequestList.getList()) {
        if (item.equals(requestBean)) {
            requestBean = item;
            break;
        }
    }

    msg.clear();
    msg.addAllMsg(SubmitModel.getModel().accept(requestBean));

    if (msg.isErr()){
        %><jsp:forward page="../viewPage/AlertPage.jsp"/><%
    }else{
        %><jsp:forward page="../controlPage/GetContractInfo.jsp">
        <jsp:param name="btnName" value="reply"/>
        <jsp:param name="contractId" value="${SubmitModel.model.contract.contractId}"/>
        </jsp:forward><%
    }
%>

