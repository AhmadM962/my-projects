package ahmad_car_shop;

public class Car extends Vehicle {
    private int basePrice;
    private int featuresCost;

    public Car(String type, String brand, int year, int basePrice, int featuresCost) {
        super(type, brand, year);
        this.basePrice = basePrice;
        this.featuresCost = featuresCost;
    }

    @Override
    public int calculateTotalPrice() {
        return basePrice + featuresCost;
    }

    public int calculateTotalPrice(int discount) {
        return basePrice + featuresCost - discount;
    }

    public int getBasePrice() { return basePrice; }
    public void setBasePrice(int basePrice) { this.basePrice = basePrice; }
    public int getFeaturesCost() { return featuresCost; }
    public void setFeaturesCost(int featuresCost) { this.featuresCost = featuresCost; }
}
