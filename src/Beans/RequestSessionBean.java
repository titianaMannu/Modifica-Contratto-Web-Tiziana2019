package Beans;

import Control.RequestModel;
import entity.ActiveContract;

import java.util.List;

/**
 * livello architetturale tra le pagine jsp e la logica di controllo dell'applicazione
 */
public class RequestSessionBean {

    private String userNickName;
    private int contractId;
    private RequestModel model;
    private ErrorMsg msg;

    //costruttore di default inizializza attributi con valori non significativi
    public RequestSessionBean() {
        model = new RequestModel();
        userNickName = "";
        contractId = -1;
        msg= new ErrorMsg();
    }

  /*  public RequestModel getModel() {
        return model;
    }*/

    public String getUserNickName() {
        return userNickName;
    }

    public void setUserNickName(String userNickName) {
        this.userNickName = userNickName;
        model.setUserNickname(userNickName);
    }

    public int getContractId() {
        return contractId;
    }

    public void setContractId(int contractId) {
        this.contractId = contractId;
        model.setActiveContract(contractId);
    }

    public ErrorMsg getMsg() {
        return msg;
    }

    public ActiveContract getContract(){
        return model.getContract();
    }

    public List<RequestBean> getMyRequest(){
        return  model.getAllRequests();
    }

    public boolean isValid(){
        if (model.getContract() == null) {
            msg.addMsg("Contratto non trovato\nTorna alla pagina iniziale o rieffettua il login\n");
        }
        return !msg.isErr();
    }

    public void deleteRequest(RequestBean request){
        msg.addAllMsg(model.deleteRequest(request));
    }

    public void doSend(RequestBean request){
        msg.clear();
        msg.addAllMsg(model.insertRequest(request));
    }

    public void destroy(){
       model = new RequestModel();
    }

}
