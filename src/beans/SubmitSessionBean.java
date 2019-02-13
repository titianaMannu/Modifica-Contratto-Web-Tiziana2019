package beans;

import control.EvaluateControl;
import entity.ActiveContract;

import java.io.Serializable;
import java.util.List;

public class SubmitSessionBean implements Serializable {
    private EvaluateControl control;
    private int contractId;
    private String userNickName;
    private ErrorMsg msg;


    public SubmitSessionBean() {
        userNickName = "";
        contractId = -1;
        control = new EvaluateControl();
        msg = new ErrorMsg();
    }

    public EvaluateControl getControl() {
        return control;
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

    public boolean isValid(){
        if (control.getContract() == null) {
            msg.addMsg("Contratto non trovato\nTorna alla pagina iniziale o rieffettua il login\n");
        }
        return !msg.isErr();
    }

    public ActiveContract getContract(){
        return control.getContract();
    }

    public List<RequestBean> getMySubmits(){
        return control.getSubmits();
    }


    public void destroy(){
        control = new EvaluateControl();
    }
}
