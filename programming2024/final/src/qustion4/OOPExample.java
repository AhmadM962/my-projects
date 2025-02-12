package qustion4;

import java.util.ArrayList;
import java.util.Scanner;

// Abstract Class Vehicle
abstract class Vehicle {
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

    // Getters and setters
    public String getType() { return type; }
    public void setType(String type) { this.type = type; }
    public String getBrand() { return brand; }
    public void setBrand(String brand) { this.brand = brand; }
    public int getYear() { return year; }
    public void setYear(int year) { this.year = year; }
}

// Car class inheriting Vehicle
class Car extends Vehicle {
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

    // Overloaded method
    public int calculateTotalPrice(int discount) {
        return basePrice + featuresCost - discount;
    }

    // Getters and setters
    public int getBasePrice() { return basePrice; }
    public void setBasePrice(int basePrice) { this.basePrice = basePrice; }
    public int getFeaturesCost() { return featuresCost; }
    public void setFeaturesCost(int featuresCost) { this.featuresCost = featuresCost; }
}

// Customer class
class Customer {
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

    public void setPaymentSchedule(int[] paymentSchedule) {
        this.paymentSchedule = paymentSchedule;
    }

    public void setCardNumber(String cardNumber) {
        this.cardNumber = cardNumber;
    }

    public String getCardNumber() {
        return cardNumber;
    }

    @Override
    public String toString() {
        return "Customer Name: " + name + "\nDelivery Location: " + deliveryLocation;
    }

    // Getters and setters
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getDeliveryLocation() { return deliveryLocation; }
    public void setDeliveryLocation(String deliveryLocation) { this.deliveryLocation = deliveryLocation; }
    public String getPaymentType() { return paymentType; }
    public void setPaymentType(String paymentType) { this.paymentType = paymentType; }
    public int[] getPaymentSchedule() { return paymentSchedule; }
}

// CarShop class
class CarShop {
    private static Scanner scanner = new Scanner(System.in);
    private Customer customer; // Declare customer object
    private Car selectedCar; // Declare selectedCar object
    private ArrayList<Car> availableCars; // List of available cars

    public CarShop() {
        availableCars = new ArrayList<>();
        populateCars();
    }

    // Populate available cars
    private void populateCars() {
        availableCars.add(new Car("SUV", "Toyota", 2010, 20000, 2000));
        availableCars.add(new Car("Sedan", "Porsche", 2015, 30000, 3000));
        availableCars.add(new Car("Truck", "Ford", 2020, 25000, 2500));
        availableCars.add(new Car("Hatchback", "Hyundai", 2018, 18000, 1800));
        availableCars.add(new Car("Sport", "BMW", 2021, 40000, 4000));
    }

    // Display menu method
    public void displayMenu() {
        while (true) {
            System.out.println("Welcome to Ahmad's Car Shop");
            System.out.println("Please choose an option from the menu below:");
            System.out.println("1 - Choose Your Car");
            System.out.println("2 - Calculate Price");
            System.out.println("3 - Apply Discount");
            System.out.println("4 - Print Contract");
            System.out.println("5 - Admin Login");
            System.out.println("Type 'exit' to exit at any time");

            String choice = scanner.nextLine();
            if (choice.equalsIgnoreCase("exit")) {
                System.out.println("Thank you for visiting Ahmad's Car Shop!");
                break;
            }

            switch (choice) {
                case "1":
                    selectedCar = chooseCar(); // Choose car option
                    if (selectedCar != null) {
                        System.out.println("Selected Car: " + selectedCar);
                    } else {
                        System.out.println("Car not found. Please try again.");
                    }
                    break;
                case "2":
                    if (selectedCar == null) {
                        System.out.println("Please choose a car first."); // Validate if car is chosen before calculating price
                    } else {
                        int totalPrice = calculatePrice(selectedCar); // Calculate price option
                        System.out.println("Total Price: $" + totalPrice);
                    }
                    break;
                case "3":
                    if (selectedCar == null) {
                        System.out.println("Please choose a car first."); // Validate if car is chosen before applying discount
                    } else {
                        applyDiscount(selectedCar); // Apply discount option
                    }
                    break;
                case "4":
                    if (selectedCar == null) {
                        System.out.println("Please choose a car first."); // Validate if car is chosen before printing contract
                    } else {
                        printContract(customer, selectedCar); // Print contract option
                    }
                    break;
                case "5":
                    adminLogin();
                    break;
                default:
                    System.out.println("Invalid choice. Please try again."); // Handle invalid menu choice
            }
        }
    }

    // Method to choose car
    public Car chooseCar() {
        System.out.println("Select Car Type: (SUV, Sedan, Truck, Hatchback, Sport)");
        String carType = scanner.nextLine();

        System.out.println("Select Car Brand: (Toyota, Porsche, Ford, Hyundai, BMW)");
        String carBrand = scanner.nextLine();

        System.out.println("Select Car Year: (2010 - 2024)");
        int carYear = Integer.parseInt(scanner.nextLine());

        // Linear search to find the car
        for (Car car : availableCars) {
            if (car.getType().equalsIgnoreCase(carType) &&
                car.getBrand().equalsIgnoreCase(carBrand) &&
                car.getYear() == carYear) {
                customer = new Customer("", "", ""); // Initialize the customer object
                return car; // Return the selected car
            }
        }

        return null; // Car not found
    }

    // Method to calculate price
    public int calculatePrice(Car car) {
        System.out.println("Payment Method: Cash or Loan?");
        String paymentType = scanner.nextLine();

        int totalPrice = car.calculateTotalPrice(); // Calculate total price of the car

        if (paymentType.equalsIgnoreCase("loan")) {
            System.out.println("Enter Loan Duration (in years):");
            int years = Integer.parseInt(scanner.nextLine());
            int extraFees = (int) (totalPrice * 0.05 * years); // Calculate extra fees for loan
            totalPrice += extraFees;
            int monthlyPayment = totalPrice / (years * 12); // Calculate monthly payment
            int[] paymentSchedule = new int[years * 12];
            for (int i = 0; i < paymentSchedule.length; i++) {
                paymentSchedule[i] = monthlyPayment; // Set payment schedule
            }

            System.out.println("Monthly Payment: $" + monthlyPayment);
            System.out.println("Payment Schedule:");
            for (int i = 1; i <= years * 12; i++) {
                System.out.println("Month " + i + ": $" + monthlyPayment);
            }

            customer.setPaymentSchedule(paymentSchedule); // Set payment schedule for customer
            customer.setPaymentType("loan"); // Set payment type to loan
        } else {
            System.out.println("Congratulations! You will receive a gift for paying with cash.");
            customer.setPaymentType("cash"); // Set payment type to cash
        }

        return totalPrice;
    }

    // Method to apply discount
    public void applyDiscount(Car car) {
        System.out.println("Enter Discount Amount:");
        int discount = Integer.parseInt(scanner.nextLine());
        int discountedPrice = car.calculateTotalPrice(discount);
        System.out.println("Discounted Price: $" + discountedPrice);
    }

    // Method to print contract
    public void printContract(Customer customer, Car car) {
        System.out.println("Enter your name:");
        customer.setName(scanner.nextLine()); // Set customer name

        System.out.println("Enter delivery location:");
        customer.setDeliveryLocation(scanner.nextLine()); // Set delivery location

        if (customer.getPaymentType().equalsIgnoreCase("loan")) {
            System.out.println("Enter card number:");
            customer.setCardNumber(scanner.nextLine()); // Set card number for loan payment
        }

        // Print contract details
        System.out.println("------- Car Purchase Contract -------");
        System.out.println(car);
        System.out.println(customer);
        System.out.println("Payment Type: " + customer.getPaymentType());

        if (customer.getPaymentType().equalsIgnoreCase("loan")) {
            System.out.println("Payment Schedule:");
            int[] schedule = customer.getPaymentSchedule();
            for (int i = 0; i < schedule.length; i++) {
                System.out.println("Month " + (i + 1) + ": $" + schedule[i]);
            }
            System.out.println("Card Number: " + customer.getCardNumber());
        }

        System.out.println("Total Price: $" + car.calculateTotalPrice());
        System.out.println("Signature: ______________________");
        System.out.println("Thank you for your purchase!");
        System.out.println("---------------------------------");
    }

    // Admin login method
    private void adminLogin() {
        System.out.println("Enter username:");
        String username = scanner.nextLine();
        System.out.println("Enter password:");
        String password = scanner.nextLine();

        if (username.equals("admin") && password.equals("admin")) {
            System.out.println("Admin login successful.");
            adminMenu();
        } else {
            System.out.println("Invalid username or password.");
        }
    }

    // Admin menu method
    private void adminMenu() {
        while (true) {
            System.out.println("Admin Menu:");
            System.out.println("1 - Add Car");
            System.out.println("2 - Delete Car");
            System.out.println("3 - Print All Cars");
            System.out.println("Type 'back' to return to the main menu");

            String choice = scanner.nextLine();
            if (choice.equalsIgnoreCase("back")) {
                break;
            }

            switch (choice) {
                case "1":
                    addCar();
                    break;
                case "2":
                    deleteCar();
                    break;
                case "3":
                    printAllCars();
                    break;
                default:
                    System.out.println("Invalid choice. Please try again.");
            }
        }
    }

    // Method to add car
    private void addCar() {
        System.out.println("Enter Car Type:");
        String type = scanner.nextLine();
        System.out.println("Enter Car Brand:");
        String brand = scanner.nextLine();
        System.out.println("Enter Car Year:");
        int year = Integer.parseInt(scanner.nextLine());
        System.out.println("Enter Base Price:");
        int basePrice = Integer.parseInt(scanner.nextLine());
        System.out.println("Enter Features Cost:");
        int featuresCost = Integer.parseInt(scanner.nextLine());

        availableCars.add(new Car(type, brand, year, basePrice, featuresCost));
        System.out.println("Car added successfully.");
    }

    // Method to delete car
    private void deleteCar() {
        System.out.println("Enter Car Type:");
        String type = scanner.nextLine();
        System.out.println("Enter Car Brand:");
        String brand = scanner.nextLine();
        System.out.println("Enter Car Year:");
        int year = Integer.parseInt(scanner.nextLine());

        // Linear search to find and remove the car
        for (Car car : availableCars) {
            if (car.getType().equalsIgnoreCase(type) &&
                car.getBrand().equalsIgnoreCase(brand) &&
                car.getYear() == year) {
                availableCars.remove(car);
                System.out.println("Car deleted successfully.");
                return;
            }
        }

        System.out.println("Car not found.");
    }

    // Method to print all cars
    private void printAllCars() {
        System.out.println("Current available cars:");
        for (Car car : availableCars) {
            System.out.println(car);
        }
    }
}

// Main class
public class OOPExample {
    public static void main(String[] args) {
        CarShop shop = new CarShop();
        shop.displayMenu();
    }
}
