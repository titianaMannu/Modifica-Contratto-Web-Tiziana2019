<%@ page import="Beans.RequestBean" %>
<%@ page import="entity.request.RequestStatus" %>
<%@ page import="entity.request.RequestForModification" %>
<%@ page import="DAO.modificationDAO.RequestForModificationDao" %>
<%@ page import="DAO.modificationDAO.ModificationDaoFActory" %>
<%@ page import="java.sql.SQLException" %>

<jsp:useBean id="contractInfo"
             class="Beans.ContractInfoBean"
             scope="session"/>


<jsp:useBean id="msg"
             class="Beans.ErrorMsg"
             scope="request"/>

<%
    int id = Integer.parseInt(request.getParameter("toDelete"));
    RequestBean requestBean = null;
    for (RequestBean item : contractInfo.getRequests()){
        if (item.getRequestId() == id) {
            requestBean = item;
            break;
        }
    }

    if (requestBean == null){
        msg.addMsg("Operazione fallita, la richiesta non è più valida\n");
    }
    else
        try{
            if (requestBean.getStatus() == RequestStatus.PENDING){
                //le richieste possono essere fatte solo se sono nello stato CLOSED
                msg.addMsg("Stato della richiesta non corretto: non può essere chiusa\n");
            }
            else {
                RequestForModification rqst = new RequestForModification(requestBean.getRequestId(),
                        contractInfo.getContract(), requestBean.getType(), requestBean.getObjectToChange(), contractInfo.getUserNickname(),
                        requestBean.getReasonWhy(), requestBean.getDate(), requestBean.getStatus());

                RequestForModificationDao dao = ModificationDaoFActory.getInstance().createProduct(requestBean.getType());
                dao.deleteRequest(rqst);
            }

        }catch(SQLException | NullPointerException e){
            msg.addMsg("Operazione non riuscita: " + e.getMessage());

        } catch (IllegalArgumentException | IllegalStateException e) {
            msg.addMsg(e.getMessage());
        }

%>

<jsp:forward page="../controlPage/GetRequests.jsp"/>