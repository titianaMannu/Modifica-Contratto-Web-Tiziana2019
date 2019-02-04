package Beans;

import Control.RequestModel;


public class RequestModelBean {

    private RequestModel model;
    ErrorMsg msg;

    public RequestModelBean() {
        model = new RequestModel();
        msg= new ErrorMsg();
    }

    public RequestModel getModel() {
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
