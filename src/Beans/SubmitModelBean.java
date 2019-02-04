package Beans;

import Control.SubmitModel;

import java.io.Serializable;

public class SubmitModelBean implements Serializable {
    private SubmitModel model;
    private ErrorMsg msg;


    public SubmitModelBean() {
        model= new SubmitModel();
        msg = new ErrorMsg();
    }

    public SubmitModel getModel() {
        return model;
    }

    public void setUser(String userNickname) {
        msg.addAllMsg(model.setUserNickname(userNickname));
    }


    public ErrorMsg getMsg() {
        return msg;
    }

    public boolean isValid(){
        return !msg.isErr();
    }

}
