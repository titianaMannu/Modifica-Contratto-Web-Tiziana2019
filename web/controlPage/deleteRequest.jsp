<%@ page import="Beans.RequestBean" %>

<jsp:useBean id="RequestSession"
             class="Beans.RequestSessionBean"
             scope="session"/>

<jsp:useBean id="RequestList"
             class="Beans.RequestListBean"
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
       RequestSession.deleteRequest(requestBean);
       if(!RequestSession.isValid()){
        %><jsp:forward page="../viewPage/AlertPage.jsp"/><%
       }
    }

%>

<jsp:forward page="../controlPage/GetRequests.jsp"/>