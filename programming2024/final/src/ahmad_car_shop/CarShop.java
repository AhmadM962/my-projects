package ahmad_car_shop;

import javax.swing.*;
import java.awt.*;
import java.util.ArrayList;

public class CarShop {
    private Customer customer;
    private Car selectedCar;
    private ArrayList<Car> availableCars;

    public CarShop() {
        availableCars = new ArrayList<>();
        populateCars();
    }

    private void populateCars() {
        availableCars.add(new Car("SUV", "Toyota", 2010, 20000, 2000));
        availableCars.add(new Car("Sedan", "Porsche", 2015, 30000, 3000));
        availableCars.add(new Car("Truck", "Ford", 2020, 25000, 2500));
        availableCars.add(new Car("Hatchback", "Hyundai", 2018, 18000, 1800));
        availableCars.add(new Car("Sport", "BMW", 2021, 40000, 4000));
    }

    public void displayMenu() {
        JFrame frame = new JFrame("Ahmad's Car Shop");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(600, 400);
        frame.setLayout(new BorderLayout());

        JPanel panel = new JPanel();
        panel.setLayout(new GridLayout(5, 1));
        frame.add(panel, BorderLayout.CENTER);

        JButton chooseCarButton = new JButton("Choose Your Car");
        JButton calculatePriceButton = new JButton("Calculate Price");
        JButton applyDiscountButton = new JButton("Apply Discount");
        JButton printContractButton = new JButton("Print Contract");
        JButton adminLoginButton = new JButton("Admin Login");

        panel.add(chooseCarButton);
        panel.add(calculatePriceButton);
        panel.add(applyDiscountButton);
        panel.add(printContractButton);
        panel.add(adminLoginButton);

        JTextArea outputArea = new JTextArea();
        frame.add(outputArea, BorderLayout.SOUTH);

        chooseCarButton.addActionListener(e -> {
            selectedCar = chooseCar();
            if (selectedCar != null) {
                outputArea.setText("Selected Car: " + selectedCar);
            } else {
                outputArea.setText("Car not found. Please try again.");
            }
        });

        calculatePriceButton.addActionListener(e -> {
            if (selectedCar == null) {
                outputArea.setText("Please choose a car first.");
            } else {
                int totalPrice = calculatePrice(selectedCar);
                outputArea.setText("Total Price: $" + totalPrice);
            }
        });

        applyDiscountButton.addActionListener(e -> {
            if (selectedCar == null) {
                outputArea.setText("Please choose a car first.");
            } else {
                applyDiscount(selectedCar);
            }
        });

        printContractButton.addActionListener(e -> {
            if (selectedCar == null) {
                outputArea.setText("Please choose a car first.");
            } else {
                printContract(customer, selectedCar);
            }
        });

        adminLoginButton.addActionListener(e -> adminLogin());

        frame.setVisible(true);
    }

    public Car chooseCar() {
        String carType = JOptionPane.showInputDialog("Select Car Type: (SUV, Sedan, Truck, Hatchback, Sport)");
        String carBrand = JOptionPane.showInputDialog("Select Car Brand: (Toyota, Porsche, Ford, Hyundai, BMW)");
        int carYear = Integer.parseInt(JOptionPane.showInputDialog("Select Car Year: (2010 - 2024)"));

        for (Car car : availableCars) {
            if (car.getType().equalsIgnoreCase(carType) && car.getBrand().equalsIgnoreCase(carBrand) && car.getYear() == carYear) {
                customer = new Customer("", "", "");
                return car;
            }
        }
        return null;
    }

    public int calculatePrice(Car car) {
        String paymentType = JOptionPane.showInputDialog("Payment Method: Cash or Loan?");
        int totalPrice = car.calculateTotalPrice();

        if (paymentType.equalsIgnoreCase("loan")) {
            int years = Integer.parseInt(JOptionPane.showInputDialog("Enter Loan Duration (in years):"));
            int extraFees = (int) (totalPrice * 0.05 * years);
            totalPrice += extraFees;
            int monthlyPayment = totalPrice / (years * 12);
            int[] paymentSchedule = new int[years * 12];
            for (int i = 0; i < paymentSchedule.length; i++) {
                paymentSchedule[i] = monthlyPayment;
            }
            customer.setPaymentSchedule(paymentSchedule);
            customer.setPaymentType("loan");
        } else {
            JOptionPane.showMessageDialog(null, "Congratulations! You will receive a gift for paying with cash.");
            customer.setPaymentType("cash");
        }
        return totalPrice;
    }

    public void applyDiscount(Car car) {
        int discount = Integer.parseInt(JOptionPane.showInputDialog("Enter Discount Amount:"));
        int discountedPrice = car.calculateTotalPrice(discount);
        JOptionPane.showMessageDialog(null, "Discounted Price: $" + discountedPrice);
    }

    public void printContract(Customer customer, Car car) {
        customer.setName(JOptionPane.showInputDialog("Enter your name:"));
        customer.setDeliveryLocation(JOptionPane.showInputDialog("Enter delivery location:"));

        if (customer.getPaymentType().equalsIgnoreCase("loan")) {
            customer.setCardNumber(JOptionPane.showInputDialog("Enter card number:"));
        }

        StringBuilder contract = new StringBuilder("------- Car Purchase Contract -------\n");
        contract.append(car).append("\n").append(customer).append("\n");
        contract.append("Payment Type: ").append(customer.getPaymentType()).append("\n");

        if (customer.getPaymentType().equalsIgnoreCase("loan")) {
            contract.append("Payment Schedule:\n");
            int[] schedule = customer.getPaymentSchedule();
            for (int i = 0; i < schedule.length; i++) {
                contract.append("Month ").append(i + 1).append(": $").append(schedule[i]).append("\n");
            }
            contract.append("Card Number: ").append(customer.getCardNumber()).append("\n");
        }

        contract.append("Total Price: $").append(car.calculateTotalPrice()).append("\n");
        contract.append("Signature: _________________________\n");
        contract.append("Thank you for your purchase!\n");
        contract.append("---------------------------------");

        JOptionPane.showMessageDialog(null, contract.toString());
    }

    private void adminLogin() {
        String username = JOptionPane.showInputDialog("Enter username:");
        String password = JOptionPane.showInputDialog("Enter password:");

        if (username.equals("admin") && password.equals("admin")) {
            JOptionPane.showMessageDialog(null, "Admin login successful.");
            adminMenu();
        } else {
            JOptionPane.showMessageDialog(null, "Invalid username or password.");
        }
    }

    private void adminMenu() {
        String[] options = {"Add Car", "Delete Car", "Print All Cars", "Back"};
        int choice;
        do {
            choice = JOptionPane.showOptionDialog(null, "Admin Menu", "Admin Menu",
                    JOptionPane.DEFAULT_OPTION, JOptionPane.INFORMATION_MESSAGE, null, options, options[0]);
            switch (choice) {
                case 0:
                    addCar();
                    break;
                case 1:
                    deleteCar();
                    break;
                case 2:
                    printAllCars();
                    break;
                default:
                    break;
            }
        } while (choice != 3);
    }

    private void addCar() {
        String type = JOptionPane.showInputDialog("Enter Car Type:");
        String brand = JOptionPane.showInputDialog("Enter Car Brand:");
        int year = Integer.parseInt(JOptionPane.showInputDialog("Enter Car Year:"));
        int basePrice = Integer.parseInt(JOptionPane.showInputDialog("Enter Base Price:"));
        int featuresCost = Integer.parseInt(JOptionPane.showInputDialog("Enter Features Cost:"));

        availableCars.add(new Car(type, brand, year, basePrice, featuresCost));
        JOptionPane.showMessageDialog(null, "Car added successfully.");
    }

    private void deleteCar() {
        String type = JOptionPane.showInputDialog("Enter Car Type:");
        String brand = JOptionPane.showInputDialog("Enter Car Brand:");
        int year = Integer.parseInt(JOptionPane.showInputDialog("Enter Car Year:"));

        for (Car car : availableCars) {
            if (car.getType().equalsIgnoreCase(type) && car.getBrand().equalsIgnoreCase(brand) && car.getYear() == year) {
                availableCars.remove(car);
                JOptionPane.showMessageDialog(null, "Car deleted successfully.");
                return;
            }
        }
        JOptionPane.showMessageDialog(null, "Car not found.");
    }

    private void printAllCars() {
        StringBuilder carsList = new StringBuilder("Current available cars:\n");
        for (Car car : availableCars) {
            carsList.append(car).append("\n");
        }
        JOptionPane.showMessageDialog(null, carsList.toString());
    }
}
