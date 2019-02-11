package control;

import entity.ActiveContract;
import beans.RequestBean;

import DAO.ContractDao;
import DAO.modificationDAO.ModificationDaoFActory;
import DAO.modificationDAO.RequestForModificationDao;
import beans.ErrorMsg;
import entity.modification.TypeOfModification;
import entity.request.RequestForModification;
import entity.request.RequestStatus;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * inserisci richiesta
 * visualizza proposte
 * ottieni contratto
 * chiudi richiesta (segna come letto)
 *
 */

public class RequestControl {
    private String userNickname = "";
    private ActiveContract activeContract = null;


    public RequestControl() {
        this.activeContract = null;
        this.userNickname = "";
    }

    public ActiveContract getContract(){
        return activeContract;
    }

    public String getUserNickname() {
        return userNickname;
    }

    public ErrorMsg setUserNickname(String userNickname) {
        ErrorMsg msg = new ErrorMsg();
        if (userNickname!= null && !userNickname.isEmpty())
            this.userNickname = userNickname;
        else
            msg.addMsg("Il nome dell'utente non è corretto\n");
        return msg;
    }

    public ErrorMsg setActiveContract(int contractId) {
        ErrorMsg msg = new ErrorMsg();
        ContractDao dao = ContractDao.getInstance();
        ActiveContract contract = dao.getContract(contractId);
        if (contract == null)
            msg.addMsg("Il contratto selezionato non è stato trovato\nPotrebbe non essere più attivo\n");
        else if (!(contract.getRenterNickname().equals(userNickname) ||
                contract.getTenantNickname().equals(userNickname)) )
            msg.addMsg("UserName e/o codice contratto non compatibili\n");
        else
            this.activeContract = contract;
        return msg;
    }

    public ErrorMsg insertRequest(RequestBean requestBean) {
        ErrorMsg msg = new ErrorMsg();
        RequestForModification request;
        try {
            if (requestBean.getStatus() != RequestStatus.PENDING) {
                //le richieste possono essere fatte solo se sono nello stato PENDING
                msg.addMsg("Stato della richiesta non corretto: non può essere inviata\n");
                return msg;
            }
            try {
                 request = new RequestForModification(activeContract, requestBean.getType(),
                        requestBean.getObjectToChange(), userNickname, requestBean.getReasonWhy(),
                        requestBean.getDate(), requestBean.getStatus());
            }catch (IllegalArgumentException e){
                msg.addMsg(e.getMessage());
                return msg;
            }
            RequestForModificationDao dao = ModificationDaoFActory.getInstance().createProduct(requestBean.getType());
            try {//prima di inserire una richiesta nel sistema ne fa la validazione
                if ( !request.validate() ){
                    msg.addMsg("Specificare una modifica significativa\n");
                    return msg;
                }
                else if (! dao.validateRequest(request) ){
                    msg.addMsg("Esiste giá una richiesta per questa modifca\nControlla nel pannello di riepilogo\n");
                    return msg;
                }

            } catch (SQLException e) {
                msg.addMsg(e.getMessage());
                return msg;
            }
            dao.insertRequest(request);
        } catch (SQLException | NullPointerException e) {
            msg.addMsg("Operazione non riuscita: " + e.getMessage());

        } catch (IllegalArgumentException | IllegalStateException e) {
            msg.addMsg(e.getMessage());
        }

        return msg;
    }

    public List<RequestBean> getAllRequests(){
        List<RequestBean> list = new ArrayList<>();
        try{
            for (TypeOfModification type : TypeOfModification.values()) {
                RequestForModificationDao dao = ModificationDaoFActory.getInstance().createProduct(type);
                List<RequestBean> tmp = dao.getRequests(activeContract, userNickname);
                list.addAll(tmp);
            }
        }catch (NullPointerException e){
           e.printStackTrace();
        }
        return list;
    }

    /**
     * eliminazione
     * @param requestBean
     * @return
     */
    public ErrorMsg deleteRequest(RequestBean requestBean){
        ErrorMsg msg = new ErrorMsg();
        try{
            if (requestBean.getStatus() == RequestStatus.PENDING){
                //le richieste possono essere fatte solo se sono nello stato CLOSED
                msg.addMsg("Stato della richiesta non corretto: non può essere chiusa\n");
                return msg;
            }
            RequestForModification request = new RequestForModification(requestBean.getRequestId(),
                    activeContract, requestBean.getType(),requestBean.getObjectToChange(), userNickname,
                    requestBean.getReasonWhy(),requestBean.getDate(), requestBean.getStatus());

            RequestForModificationDao dao = ModificationDaoFActory.getInstance().createProduct(requestBean.getType());
            dao.deleteRequest(request);

        }catch(SQLException | NullPointerException e){
            msg.addMsg("Operazione non riuscita: " + e.getMessage());

        } catch (IllegalArgumentException | IllegalStateException e) {
            msg.addMsg(e.getMessage());
        }
        return msg;

    }

}
