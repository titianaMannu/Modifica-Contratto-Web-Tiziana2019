package beans;

import control.RequestControl;
import entity.ActiveContract;

import java.io.Serializable;
import java.util.List;

/**
 * livello architetturale tra le pagine jsp e la logica di controllo dell'applicazione
 */
public class RequestSessionBean implements Serializable {

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

    public RequestControl getControl() {
        return control;
    }

    public void setControl(RequestControl control) {
        this.control = control;
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

    public void destroy(){
       control = new RequestControl();
    }

}
