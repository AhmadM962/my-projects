package ahmad_car_shop;

public abstract class Vehicle {
    private String type;
    private String brand;
    private int year;

    public Vehicle(String type, String brand, int year) {
        this.type = type;
        this.brand = brand;
        this.year = year;
    }

    public abstract int calculateTotalPrice();

    @Override
    public String toString() {
        return type + " " + brand + " " + year;
    }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }
    public String getBrand() { return brand; }
    public void setBrand(String brand) { this.brand = brand; }
    public int getYear() { return year; }
    public void setYear(int year) { this.year = year; }
}
