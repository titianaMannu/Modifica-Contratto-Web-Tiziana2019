<%@ page import="DAO.ContractDao" %>
<%@ page import="Beans.ActiveContract" %>
<jsp:useBean id="contractInfo"
             class="Beans.ContractInfoBean"
             scope="session"/>

<jsp:useBean id="msg"
             class="Beans.ErrorMsg"
             scope="request"/>


<%
    String userNickname = request.getParameter("user");
    int contractId = Integer.parseInt(request.getParameter("contractId"));

    //SetUserNickname
    contractInfo.setUserNickname(userNickname);

    //SetActiveContract
    ContractDao dao = ContractDao.getInstance();
    ActiveContract activeContract = dao.getContract(contractId);
    if (activeContract == null)
        msg.addMsg("Il contratto selezionato non è stato trovato\nPotrebbe non essere più attivo\n");
    else if (!(activeContract.getRenterNickname().equals(userNickname) ||
            activeContract.getTenantNickname().equals(userNickname)) )
        msg.addMsg("UserName e/o codice contratto non compatibili\n");
    else
        contractInfo.setContract(activeContract);

    if (request.getParameter("btnName").equals("reply")){
        %> <jsp:forward page="../controlPage/GetSubmits.jsp"/><%}

%>


<jsp:forward page="../viewPage/RequestPage.jsp"/>