<%@ page import="beans.RequestBean" %>

<jsp:useBean id="RequestSession"
             class="beans.RequestSessionBean"
             scope="session"/>

<jsp:useBean id="RequestList"
             class="beans.RequestListBean"
             scope="session"/>

<%
   RequestSession.getMsg().clear();
    int id = Integer.parseInt(request.getParameter("toDelete"));
    RequestBean requestBean = null;
    for (RequestBean item : RequestList.getList()){
        if (item.getRequestId() == id) {
            requestBean = item;
            break;
        }
    }

    if (requestBean == null){
        RequestSession.getMsg().addMsg("Operazione fallita, la richiesta non è più valida\n");
        %><jsp:forward page="../viewPage/AlertPage.jsp"/><%
    }
    else{
        RequestSession.getMsg().addAllMsg(RequestSession.getControl().deleteRequest(requestBean));
       //RequestSession.deleteRequest(requestBean);
       if(!RequestSession.isValid()){
        %><jsp:forward page="../viewPage/AlertPage.jsp"/><%
       }
    }

%>

<jsp:forward page="GetRequests.jsp"/>