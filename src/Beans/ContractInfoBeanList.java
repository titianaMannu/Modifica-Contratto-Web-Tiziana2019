package Beans;

import java.util.ArrayList;
import java.util.List;

public class ContractInfoBeanList {
    List<ContractInfoBean> contractInfoBeans;
    String userNickName;

    public ContractInfoBeanList() {
        contractInfoBeans = new ArrayList<>();
        userNickName = "";
    }

    public void add(ContractInfoBean other) {
        contractInfoBeans.add(other);
    }

    public ContractInfoBean getInfo(int contractId){
        for (ContractInfoBean item : contractInfoBeans)
            if (item.getContract().getContractId() == contractId)
                return item ;
        return null;
    }

    public String getUserNickName() {
        return userNickName;
    }

    public List<ContractInfoBean> getContractInfoBeans() {
        return contractInfoBeans;
    }

    public void setUserNickName(String userNickName) {
        this.userNickName = userNickName;
    }
}
