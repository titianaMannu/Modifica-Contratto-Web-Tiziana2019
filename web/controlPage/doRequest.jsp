<%@ page import="entity.request.RequestForModification" %>
<%@ page import="entity.request.RequestStatus" %>
<%@ page import="DAO.modificationDAO.RequestForModificationDao" %>
<%@ page import="DAO.modificationDAO.ModificationDaoFActory" %>
<%@ page import="java.sql.SQLException" %>

<jsp:useBean id="requestBean"
             class="Beans.RequestBean"
             scope="session"/>

<jsp:useBean id="msg"
             class="Beans.ErrorMsg"
             scope="request"/>

<jsp:useBean id="contractInfo"
             class="Beans.ContractInfoBean"
             scope="session"/>
<%

    RequestForModification requestForModfc = null;
    try {
        if (requestBean.getStatus() != RequestStatus.PENDING) {
            //le richieste possono essere fatte solo se sono nello stato PENDING
            msg.addMsg("Stato della richiesta non corretto: non può essere inviata\n");
            %> <jsp:forward page="../controlPage/GetRequests.jsp">
    <jsp:param name="user" value="${contractInfo.userNickname}"/>
    <jsp:param name="contractId" value="<%=contractInfo.getContract().getContractId()%>"/>
</jsp:forward> <%
        }
        try {
            requestForModfc = new RequestForModification(contractInfo.getContract(), requestBean.getType(),
                    requestBean.getObjectToChange(), contractInfo.getUserNickname(), requestBean.getReasonWhy(),
                    requestBean.getDate(), requestBean.getStatus());
        }catch (IllegalArgumentException e){
            msg.addMsg(e.getMessage());
            %> <jsp:forward page="../controlPage/GetRequests.jsp">
                <jsp:param name="user" value="${contractInfo.userNickname}"/>
                <jsp:param name="contractId" value="<%=contractInfo.getContract().getContractId()%>"/>
            </jsp:forward> <%
        }
        RequestForModificationDao dao = ModificationDaoFActory.getInstance().createProduct(requestBean.getType());
        try {//prima di inserire una richiesta nel sistema ne fa la validazione
            if ( !requestForModfc.getModification().validate( requestForModfc.getActiveContract() )){
                msg.addMsg("Specificare una modifica significativa\n");
                %> <jsp:forward page="../controlPage/GetRequests.jsp">
                    <jsp:param name="user" value="${contractInfo.userNickname}"/>
                    <jsp:param name="contractId" value="<%=contractInfo.getContract().getContractId()%>"/>
                </jsp:forward> <%
            }
            else if (! dao.validateRequest(requestForModfc) ){
                msg.addMsg("Esiste giá una richiesta per questa modifca\nControlla nel pannello di riepilogo\n");
%> <jsp:forward page="../controlPage/GetRequests.jsp">
    <jsp:param name="user" value="${contractInfo.userNickname}"/>
    <jsp:param name="contractId" value="<%=contractInfo.getContract().getContractId()%>"/>
</jsp:forward> <%
            }

        } catch (SQLException e) {
            msg.addMsg(e.getMessage());
%> <jsp:forward page="../controlPage/GetRequests.jsp">
    <jsp:param name="user" value="${contractInfo.userNickname}"/>
    <jsp:param name="contractId" value="<%=contractInfo.getContract().getContractId()%>"/>
</jsp:forward> <%
        }
        dao.insertRequest(requestForModfc);
    } catch (SQLException | NullPointerException e) {
        msg.addMsg("Operazione non riuscita: " + e.getMessage());

    } catch (IllegalArgumentException | IllegalStateException e) {
        msg.addMsg(e.getMessage());
    }
%>

<jsp:forward page="../controlPage/GetRequests.jsp">
    <jsp:param name="user" value="${contractInfo.userNickname}"/>
    <jsp:param name="contractId" value="<%=contractInfo.getContract().getContractId()%>"/>
</jsp:forward>