<%@ page import="beans.RequestBean" %>


<jsp:useBean id="SubmitSession"
             class="beans.SubmitSessionBean"
             scope="session"/>

<jsp:useBean id="RequestList"
             class="beans.RequestListBean"
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


    SubmitSession.getMsg().clear();
    SubmitSession.getMsg().addAllMsg(SubmitSession.getControl().decline(requestBean));
    if (!SubmitSession.isValid()){
        %><jsp:forward page="../viewPage/AlertPage.jsp"/><%
        }else{
        %><jsp:forward page="../controlPage/GetContractInfo.jsp">
            <jsp:param name="btnName" value="reply"/>
            <jsp:param name="contractId" value="${SubmitSession.contract.contractId}"/>
        </jsp:forward><%

    }
%>

