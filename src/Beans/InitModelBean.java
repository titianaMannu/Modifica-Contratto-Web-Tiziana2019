package Beans;

import Control.InitModel;

import java.io.Serializable;

public class InitModelBean implements Serializable {
    private InitModel model;
    ErrorMsg msg;

    public InitModelBean() {
        model = new InitModel();
        msg = new ErrorMsg();
    }

    public InitModel getModel() {
        return model;
    }

    public void setUser(String userNickname) {
        msg.addAllMsg(model.setUserNickname(userNickname));
    }

    public boolean isValid(){
        return !msg.isErr();
    }
}
