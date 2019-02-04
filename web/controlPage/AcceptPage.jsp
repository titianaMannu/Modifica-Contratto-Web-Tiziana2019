<%@ page import="entity.request.RequestStatus" %>
<%@ page import="entity.request.RequestForModification" %>
<%@ page import="DAO.modificationDAO.RequestForModificationDao" %>
<%@ page import="DAO.modificationDAO.ModificationDaoFActory" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="Beans.RequestBean" %>

<jsp:useBean id="contractInfo"
             class="Beans.ContractInfoBean"
             scope="session"/>

<jsp:useBean id="msg"
             class="Beans.ErrorMsg"
             scope="request"/>


<%
    int id = Integer.parseInt(request.getParameter("toEvaluate"));
    RequestBean requestBean = new RequestBean();
    requestBean.setRequestId(id);
    for (RequestBean item : contractInfo.getRequests()){
        if (item.equals(requestBean))
            requestBean = item;

    }


    if (requestBean.getStatus() != RequestStatus.PENDING){
        msg.addMsg("Solo richieste pending possono essere accettate\n");
        %><jsp:forward page="../viewPage/SubmitPage.jsp"/><%
    }
    try{
        RequestForModification rqst = new RequestForModification(requestBean.getRequestId(),
                contractInfo.getContract(), requestBean.getType(),requestBean.getObjectToChange(), contractInfo.getUserNickname(),
                requestBean.getReasonWhy(),requestBean.getDate(), requestBean.getStatus());

        RequestForModificationDao dao = ModificationDaoFActory.getInstance().createProduct(requestBean.getType());
        dao.changeRequestStatus(rqst, RequestStatus.ACCEPTED);
        dao.updateContract(rqst);

    }catch(SQLException | NullPointerException e){
        msg.addMsg("Operazione non riuscita: " + e.getMessage());

    } catch (IllegalStateException | IllegalArgumentException e) {
        msg.addMsg(e.getMessage());
    }



%>

<jsp:forward page="../controlPage/GetContractInfo.jsp">
    <jsp:param name="btnName" value="reply"/>
    <jsp:param name="user" value="${contractInfo.userNickname}"/>
    <jsp:param name="contractId" value="<%=contractInfo.getContract().getContractId()%>"/>
</jsp:forward>