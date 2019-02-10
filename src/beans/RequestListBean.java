package beans;

import java.util.ArrayList;
import java.util.List;

public class RequestListBean {
    private List<RequestBean> list;

    public RequestListBean() {
        list = new ArrayList<>();
    }

    public RequestBean find(int requestId){
        for (RequestBean item : list)
            if (item.getRequestId() == requestId)
                return item;
        return null;
    }

    public void addAll(List<RequestBean> otherList){
        list.addAll(otherList);
    }

    public void add(RequestBean bean){
        list.add(bean);
    }

    public void clear(){
        list.clear();
    }

    public List<RequestBean> getList() {
        return list;
    }

    public void setList(List<RequestBean> list) {
        this.list = list;
    }

    public boolean isEmpty(){
        return list.isEmpty();
    }
}
