package Beans;

import Control.SubmitModel;

import java.io.Serializable;
import java.util.List;

public class SubmitControllerBean implements Serializable {
    private SubmitModel model;
    private int contractId;
    private String userNickName;
    private ErrorMsg msg;


    public SubmitControllerBean() {
        userNickName = "";
        contractId = -1;
        model= new SubmitModel();
        msg = new ErrorMsg();
    }

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

    public boolean isValid(){
        if (model.getContract() == null) {
            msg.addMsg("Contratto non trovato\nTorna alla pagina iniziale o rieffettua il login\n");
        }
        return !msg.isErr();
    }

    public ActiveContract getContract(){
        return model.getContract();
    }

    public List<RequestBean> getMySubmits(){
        return model.getSubmits();
    }

    public void accept(RequestBean request){
        msg.addAllMsg(model.accept(request));
    }

    public void decline(RequestBean request){
        msg.addAllMsg(model.decline(request));
    }
}
