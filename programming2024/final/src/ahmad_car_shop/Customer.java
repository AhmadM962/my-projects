package ahmad_car_shop;

public class Customer {
    private String name;
    private String deliveryLocation;
    private String paymentType;
    private int[] paymentSchedule;
    private String cardNumber;

    public Customer(String name, String deliveryLocation, String paymentType) {
        this.name = name;
        this.deliveryLocation = deliveryLocation;
        this.paymentType = paymentType;
    }

    public void setPaymentSchedule(int[] paymentSchedule) { this.paymentSchedule = paymentSchedule; }
    public void setCardNumber(String cardNumber) { this.cardNumber = cardNumber; }
    public String getCardNumber() { return cardNumber; }

    @Override
    public String toString() {
        return "Customer Name: " + name + "\nDelivery Location: " + deliveryLocation;
    }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getDeliveryLocation() { return deliveryLocation; }
    public void setDeliveryLocation(String deliveryLocation) { this.deliveryLocation = deliveryLocation; }
    public String getPaymentType() { return paymentType; }
    public void setPaymentType(String paymentType) { this.paymentType = paymentType; }
    public int[] getPaymentSchedule() { return paymentSchedule; }
}
