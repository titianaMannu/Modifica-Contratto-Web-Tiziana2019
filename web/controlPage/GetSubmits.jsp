<%@ page import="Beans.RequestBean" %>
<%@ page import="java.util.List" %>
<%@ page import="entity.modification.TypeOfModification" %>
<%@ page import="DAO.modificationDAO.RequestForModificationDao" %>
<%@ page import="DAO.modificationDAO.ModificationDaoFActory" %>


<jsp:useBean id="contractInfo"
             class="Beans.ContractInfoBean"
             scope="session"/>

<jsp:useBean id="msg"
             class="Beans.ErrorMsg"
             scope="request"/>

<%
    contractInfo.getRequests().clear();

    try{
        for (TypeOfModification type : TypeOfModification.values()) {
            RequestForModificationDao modfcDao = ModificationDaoFActory.getInstance().createProduct(type);
            List<RequestBean> tmp = modfcDao.getSubmits(contractInfo.getContract(), contractInfo.getUserNickname());
            contractInfo.getRequests().addAll(tmp);
        }
    }catch (IllegalArgumentException e){ //caso in cui factory riscontra un errore
        msg.addMsg(e.getMessage());
    }

%>

<jsp:forward page="../viewPage/SubmitPage.jsp"/>