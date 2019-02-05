package Beans;

import Control.InitModel;

import java.io.Serializable;
import java.util.List;

public class InitControllerBean implements Serializable {
    private String userNickName;
    private InitModel model;
    private ErrorMsg msg;

    public InitControllerBean() {
        userNickName = "";
        model = new InitModel();
        msg = new ErrorMsg();
    }

    public String getUserNickName() {
        return userNickName;
    }

    public void setUserNickName(String userNickName) {
        this.userNickName = userNickName;
        model.setUserNickname(userNickName);
    }
    public ErrorMsg getMsg() {
        return msg;
    }

    public boolean isValid(){
        return !msg.isErr();
    }

    public List<ActiveContract> getAllContract(){
        return model.getAllContract();
    }

    public int getSubmitsNumber(ActiveContract contract){
        return model.getSubmits(contract);
    }
}
