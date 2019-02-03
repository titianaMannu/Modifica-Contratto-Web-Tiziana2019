<%@ page import="DAO.ContractDao" %>
<%@ page import="entity.UserType" %>
<%@ page import="java.util.List" %>
<%@ page import="Beans.ActiveContract" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="entity.modification.TypeOfModification" %>
<%@ page import="DAO.modificationDAO.RequestForModificationDao" %>
<%@ page import="DAO.modificationDAO.ModificationDaoFActory" %>
<%@ page import="Beans.ContractInfoBean" %>

<jsp:useBean id="contractInfoList"
             class="Beans.ContractInfoBeanList"
             scope="request"/>

<%
    String userNickName = request.getParameter("userNickname");
    contractInfoList.setUserNickName(userNickName);
    List<ActiveContract> contracts = new ArrayList<>();
    ContractDao dao = ContractDao.getInstance();
    for (UserType type : UserType.values()) {
        contracts.addAll(dao.getAllActiveContracts(userNickName, type));
    }

    for (ActiveContract contract : contracts) {
        ContractInfoBean info = new ContractInfoBean();
        info.setContract(contract);
        try {
            for (TypeOfModification type : TypeOfModification.values()) {
                RequestForModificationDao requestDao = ModificationDaoFActory.getInstance().createProduct(type);
                info.addRequests(requestDao.getSubmits(contract, userNickName));
            }
        } catch (NullPointerException e) {
            e.printStackTrace();
        }
        contractInfoList.add(info);
    }

%>

<jsp:forward  page="../viewPage/ContractManagementPage.jsp"/>