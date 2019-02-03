package Beans;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class ContractInfoBean implements Serializable {
    private List<RequestBean> requests;
    private String userNickname;
    private ActiveContract contract;

    public ContractInfoBean() {
        requests = new ArrayList<>();
    }

    public String getUserNickname() {
        return userNickname;
    }

    public void setUserNickname(String userNickname) {
        this.userNickname = userNickname;
    }

    public List<RequestBean> getRequests() {
        return requests;
    }

    public void setRequests(List<RequestBean> requests) {
        this.requests = requests;
    }

    public ActiveContract getContract() {
        return contract;
    }

    public void setContract(ActiveContract contract) {
        this.contract = contract;
    }

    public void addRequests(List<RequestBean> requests){
        this.requests.addAll(requests);
    }
}
