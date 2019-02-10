package beans;

import control.RequestControl;
import entity.ActiveContract;

import java.util.List;

/**
 * livello architetturale tra le pagine jsp e la logica di controllo dell'applicazione
 */
public class RequestSessionBean {

    private String userNickName;
    private int contractId;
    private RequestControl control;
    private ErrorMsg msg;

    //costruttore di default inizializza attributi con valori non significativi
    public RequestSessionBean() {
        control = new RequestControl();
        userNickName = "";
        contractId = -1;
        msg= new ErrorMsg();
    }

    public String getUserNickName() {
        return userNickName;
    }

    public void setUserNickName(String userNickName) {
        this.userNickName = userNickName;
        control.setUserNickname(userNickName);
    }

    public int getContractId() {
        return contractId;
    }

    public void setContractId(int contractId) {
        this.contractId = contractId;
        control.setActiveContract(contractId);
    }

    public ErrorMsg getMsg() {
        return msg;
    }

    public ActiveContract getContract(){
        return control.getContract();
    }

    public List<RequestBean> getMyRequest(){
        return  control.getAllRequests();
    }

    public boolean isValid(){
        if (control.getContract() == null) {
            msg.addMsg("Contratto non trovato\nTorna alla pagina iniziale o rieffettua il login\n");
        }
        return !msg.isErr();
    }

    public void deleteRequest(RequestBean request){
        msg.addAllMsg(control.deleteRequest(request));
    }

    public void doSend(RequestBean request){
        msg.clear();
        msg.addAllMsg(control.insertRequest(request));
    }

    public void destroy(){
       control = new RequestControl();
    }

}
