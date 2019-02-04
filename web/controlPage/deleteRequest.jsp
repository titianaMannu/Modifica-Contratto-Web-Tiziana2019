<%@ page import="Beans.RequestBean" %>

<jsp:useBean id="RequestModel"
             class="Beans.RequestModelBean"
             scope="session"/>

<jsp:useBean id="RequestList"
             class="Beans.RequestListBean"
             scope="session"/>

<jsp:useBean id="msg"
             class="Beans.ErrorMsg"
             scope="session"/>

<%
    msg.clear();
    int id = Integer.parseInt(request.getParameter("toDelete"));
    RequestBean requestBean = null;
    for (RequestBean item : RequestList.getList()){
        if (item.getRequestId() == id) {
            requestBean = item;
            break;
        }
    }

    if (requestBean == null){
        msg.addMsg("Operazione fallita, la richiesta non è più valida\n");
        %><jsp:forward page="../viewPage/AlertPage.jsp"/><%
    }
    else{
        msg.addAllMsg(RequestModel.getModel().deleteRequest(requestBean));
    }

%>

<jsp:forward page="../controlPage/GetRequests.jsp"/>