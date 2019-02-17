package beans;

import control.InitControl;
import java.io.Serializable;
import java.util.List;

public class InitSessionBean implements Serializable {
    private String userNickName;
    private InitControl control;
    private ErrorMsg msg;

    public InitSessionBean() {
        userNickName = "";
        control = new InitControl();
        msg = new ErrorMsg();
    }

    public String getUserNickName() {
        return userNickName;
    }

    public void setUserNickName(String userNickName) {
        this.userNickName = userNickName;
        control.setUserNickname(userNickName);
    }
    public ErrorMsg getMsg() {
        return msg;
    }

    public boolean isValid(){
        return !msg.isErr();
    }

    public List<ActiveContractBean> getAllContract(){
        return control.getAllContract();
    }

    public int getSubmitsNumber(ActiveContractBean contract){
        return control.getSubmits(contract);
    }

    public void destroy(){
      control = new InitControl();
    }
}
