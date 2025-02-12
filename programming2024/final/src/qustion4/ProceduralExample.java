package qustion4;
import java.util.Scanner;

public class ProceduralExample {

    // Scanner for user input
    static Scanner scanner = new Scanner(System.in);
    
    // Variables to store selected car details and total price
    static String selectedCar = "";
    static int totalPrice = 0;
    
    // Variables to store payment type and schedule
    static String paymentType = "";
    static int[] paymentSchedule;
    
    // Variables to store customer details
    static String customerName = "";
    static String deliveryLocation = "";
    
    // Private variable to store card number
    private static String cardNumber = "";

    public static void main(String[] args) {
        // Main menu loop
        while (true) {
            // Display main menu options
            System.out.println("Welcome to Ahmad's Car Shop");
            System.out.println("Please choose an option from the menu below:");
            System.out.println("1 - Choose Your Car");
            System.out.println("2 - Calculate Price");
            System.out.println("3 - Print Contract");
            System.out.println("Type 'exit' to exit at any time");

            // Get user choice
            String choice = scanner.nextLine();
            if (choice.equalsIgnoreCase("exit")) {
                System.out.println("Thank you for visiting Ahmad's Car Shop!");
                break;
            }

            // Handle menu options
            switch (choice) {
                case "1":
                    selectedCar = chooseCar();
                    System.out.println("Selected Car: " + selectedCar);
                    break;
                case "2":
                    totalPrice = calculatePrice();
                    System.out.println("Total Price: $" + totalPrice);
                    break;
                case "3":
                    // Overloaded printContract method based on payment type
                    if (paymentType.equalsIgnoreCase("cash")) {
                        printContract(true);
                    } else {
                        printContract(false);
                    }
                    break;
                default:
                    System.out.println("Invalid choice. Please try again.");
            }
        }
    }

    /**
     * Prompts the user to choose a car and returns the selected car details.
     * @return A string containing the selected car type, brand, and year.
     */
    public static String chooseCar() {
        // Get car type from user
        System.out.println("Select Car Type: (SUV, Sedan, Truck, Hatchback, Sport)");
        String[] carTypes = {"SUV", "Sedan", "Truck", "Hatchback", "Sport"};
        String carType = scanner.nextLine();
        if (!linearSearch(carTypes, carType)) {
            System.out.println("Invalid car type. Please try again.");
            return chooseCar();
        }

        // Get car brand from user
        System.out.println("Select Car Brand: (Toyota, Porsche, Ford, Hyundai, BMW)");
        String[] carBrands = {"Toyota", "Porsche", "Ford", "Hyundai", "BMW"};
        String carBrand = scanner.nextLine();
        if (!linearSearch(carBrands, carBrand)) {
            System.out.println("Invalid car brand. Please try again.");
            return chooseCar();
        }

        // Get car year from user
        System.out.println("Select Car Year: (2010 - 2024)");
        int carYear = Integer.parseInt(scanner.nextLine());
        if (carYear < 2010 || carYear > 2024) {
            System.out.println("Invalid car year. Please try again.");
            return chooseCar();
        }

        // Return selected car details
        return carType + " " + carBrand + " " + carYear;
    }

    /**
     * Performs a linear search on an array to check if the given value exists.
     * @param array The array to search through.
     * @param value The value to search for.
     * @return True if the value is found, otherwise false.
     */
    public static boolean linearSearch(String[] array, String value) {
        for (String element : array) {
            if (element.equalsIgnoreCase(value)) {
                return true;
            }
        }
        return false;
    }

    /**
     * Calculates the total price of the car based on user input and payment method.
     * @return The total price of the car.
     */
    public static int calculatePrice() {
        // Get base price from user
        System.out.println("Enter Car Price:");
        int basePrice = Integer.parseInt(scanner.nextLine());

        // Check if user wants to add features
        System.out.println("Add Features? (yes/no)");
        String withFeatures = scanner.nextLine();
        int featuresCost = 0;
        if (withFeatures.equalsIgnoreCase("yes")) {
            System.out.println("Enter the Cost of Features:");
            featuresCost = Integer.parseInt(scanner.nextLine());
        }

        int totalPrice = basePrice + featuresCost;

        // Determine payment method and calculate total price
        System.out.println("Payment Method: Cash or Loan?");
        paymentType = scanner.nextLine();
        if (paymentType.equalsIgnoreCase("loan")) {
            // Calculate loan details
            System.out.println("Enter Loan Duration (in years):");
            int years = Integer.parseInt(scanner.nextLine());
            int extraFees = (int) (totalPrice * 0.05 * years);
            totalPrice += extraFees;
            int monthlyPayment = totalPrice / (years * 12);
            paymentSchedule = new int[years * 12];
            for (int i = 0; i < paymentSchedule.length; i++) {
                paymentSchedule[i] = monthlyPayment;
            }
            System.out.println("Monthly Payment: $" + monthlyPayment);

            // Print payment schedule
            System.out.println("Payment Schedule:");
            for (int i = 1; i <= years * 12; i++) {
                System.out.println("Month " + i + ": $" + monthlyPayment);
            }
        } else {
            // Cash payment
            paymentSchedule = new int[1];
            paymentSchedule[0] = totalPrice;
        }

        return totalPrice;
    }

    /**
     * Overloaded method to print the contract for cash payments with a special gift.
     * @param isCashPayment Boolean indicating if the payment method is cash.
     */
    public static void printContract(boolean isCashPayment) {
        // Ensure a car is selected
        if (selectedCar.isEmpty()) {
            System.out.println("No car selected. Please choose a car first.");
            return;
        }

        // Get customer details
        System.out.println("Enter your name:");
        customerName = scanner.nextLine();
        System.out.println("Enter your delivery location:");
        deliveryLocation = scanner.nextLine();

        // Get card number if payment method is loan
        if (paymentType.equalsIgnoreCase("loan")) {
            System.out.println("Enter your card number:");
            cardNumber = scanner.nextLine();
        }

        // Print contract details
        System.out.println("--------------- Car Purchase Contract ---------------");
        System.out.println("Customer Name: " + customerName);
        System.out.println("Delivery Location: " + deliveryLocation);
        System.out.println("Car Details: " + selectedCar);
        System.out.println("Total Price: $" + totalPrice);
        System.out.println("Payment Method: " + (isCashPayment ? "Cash" : "Loan"));

        if (isCashPayment) {
            System.out.println("Special Gift: Thank you for choosing cash payment! You will receive a complimentary car care kit.");
        } else {
            System.out.println("Card Number: " + "****-****-****-" + cardNumber.substring(cardNumber.length() - 4));
            System.out.println("Payment Schedule:");
            for (int i = 1; i <= paymentSchedule.length; i++) {
                System.out.println("Month " + i + ": $" + paymentSchedule[i - 1]);
            }
        }
        
        System.out.println("------------------------------------------------------");

        // Confirm purchase
        System.out.println("Confirm Purchase? (yes/no)");
        String confirmation = scanner.nextLine();
        if (confirmation.equalsIgnoreCase("yes")) {
            System.out.println("Thank you for your purchase at Ahmad's Car Shop!");
            System.out.println("Your car will be delivered to " + deliveryLocation + " within 7 business days.");
        } else {
            System.out.println("Purchase cancelled. Thank you for visiting Ahmad's Car Shop.");
        }
    }

    /**
     * Overloaded method to print the standard contract without a gift.
     */
    public static void printContract() {
        printContract(false);
    }
}
