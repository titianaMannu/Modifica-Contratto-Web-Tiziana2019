package Control;

import entity.ActiveContract;
import Beans.ErrorMsg;
import Beans.RequestBean;
import DAO.ContractDao;
import DAO.modificationDAO.ModificationDaoFActory;
import DAO.modificationDAO.RequestForModificationDao;
import entity.modification.TypeOfModification;
import entity.request.RequestForModification;
import entity.request.RequestStatus;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * ottieni contratto
 * ottieni proposte
 * accetta proposta
 * respingi proposta
 * subroutine che si occupa di settare le richieste expired (dovrebbe essere un caso d'uso a parte)
 */

public class SubmitModel {
    private String userNickname;
    private ActiveContract activeContract;

    public SubmitModel() {
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
        activeContract = null;
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

    public List<RequestBean> getSubmits(){
        List<RequestBean> list = new ArrayList<>();
        try{
            for (TypeOfModification type : TypeOfModification.values()) {
                RequestForModificationDao dao = ModificationDaoFActory.getInstance().createProduct(type);
                List<RequestBean> tmp = dao.getSubmits(activeContract, userNickname);
                list.addAll(tmp);
            }
        }catch (NullPointerException e){
            e.printStackTrace();
        }
        return list;

    }

    public ErrorMsg accept(RequestBean requestBean){
        ErrorMsg msg = new ErrorMsg();
        if (requestBean.getStatus() != RequestStatus.PENDING){
            msg.addMsg("Solo richieste pending possono essere accettate\n");
            return msg;
        }
        try{
            RequestForModification request = new RequestForModification(requestBean.getRequestId(),
                    activeContract, requestBean.getType(),requestBean.getObjectToChange(), userNickname,
                    requestBean.getReasonWhy(),requestBean.getDate(), requestBean.getStatus());

            RequestForModificationDao dao = ModificationDaoFActory.getInstance().createProduct(requestBean.getType());
            dao.updateContract(request);
            dao.changeRequestStatus(request, RequestStatus.ACCEPTED);
        }catch(SQLException | NullPointerException e){
            msg.addMsg("Operazione non riuscita: " + e.getMessage());

        } catch (IllegalStateException | IllegalArgumentException e) {
            msg.addMsg(e.getMessage());
        }

        return msg;
    }


    public ErrorMsg decline(RequestBean requestBean){
        ErrorMsg msg = new ErrorMsg();
        if (requestBean.getStatus() != RequestStatus.PENDING){
            msg.addMsg("Solo richieste pending possono essere respinte\n");
            return msg;
        }
        try{
            RequestForModification request = new RequestForModification(requestBean.getRequestId(),
                    activeContract, requestBean.getType(),requestBean.getObjectToChange(), userNickname,
                    requestBean.getReasonWhy(),requestBean.getDate(), requestBean.getStatus());

            RequestForModificationDao dao = ModificationDaoFActory.getInstance().createProduct(requestBean.getType());
            dao.changeRequestStatus(request, RequestStatus.DECLINED);

        }catch(SQLException | NullPointerException e){
            msg.addMsg("Operazione non riuscita: " + e.getMessage());

        } catch (IllegalStateException | IllegalArgumentException e) {
            msg.addMsg(e.getMessage());
        }

        return msg;
    }


}
