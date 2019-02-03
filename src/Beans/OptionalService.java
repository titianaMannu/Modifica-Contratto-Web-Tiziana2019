package Beans;

import java.io.Serializable;

/**
 *OptionalService si occupa di incapsulare i propri dati e la loro logica di controllo
 */
public class OptionalService implements Serializable {
    private int serviceId = -1;
    private  String serviceName;
    private int servicePrice;
    private String description;
    private ErrorMsg  msg = new ErrorMsg();

    public OptionalService(int serviceId, String serviceName, int servicePrice, String description) {
       setServiceId(serviceId);
       setServiceName(serviceName);
       setDescription(description);
       setServicePrice(servicePrice);

    }

    /**
     * costruttore per service a cui non è stato ancora assegnato un id
     */
    public OptionalService(String serviceName, int servicePrice, String description) {
        setServiceName(serviceName);
        setServicePrice(servicePrice);
        setDescription(description);

    }

    public OptionalService() {
        //Bean deve avere un costruttore di default
    }

    public boolean isValid(){
        return !msg.isErr();
    }

    public ErrorMsg getMsg() {
        return msg;
    }


    public void setServiceName(String serviceName) {
        if (serviceName!= null && !serviceName.isEmpty())
            this.serviceName = serviceName;
        else msg.addMsg("specificare nome del servizio\n");
    }

    public void setServicePrice(int servicePrice) {
        if (servicePrice < 1) msg.addMsg("specificare prezzo del servizio\n");
        this.servicePrice = servicePrice;
    }

    public void setDescription(String description) {
        if (description != null && !description.isEmpty())
            this.description = description;
        else
            this.description = "";
    }

    public void setServiceId(int serviceId){
        if (serviceId < 1)msg.addMsg("serviceId non corretto\n");
        this.serviceId = serviceId;
    }


    public String getDescription() {
        return description;
    }

    public String getServiceName() {
        return serviceName;
    }

    public int getServiceId() {
        return serviceId;
    }

    public int getServicePrice() {
        return servicePrice;
    }

    @Override
    public String toString() {
        return  serviceName + "  prezzo: " +  servicePrice ;
    }

    @Override
    public boolean equals(Object object) {
        if (this == object) return true;
        if (object == null || getClass() != object.getClass()) return false;
        OptionalService service = (OptionalService) object;
        return serviceId == service.serviceId;
    }


}
