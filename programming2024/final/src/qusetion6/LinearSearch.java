package qusetion6;

public class LinearSearch {
    public static int linearSearch(int[] arr, int target) {
        // Iterate through each element in the array
        for (int i = 0; i < arr.length; i++) {
            // Compare the current element with the target element
            if (arr[i] == target) {
                // Return the index if the target element is found
                return i;
            }
        }
        // Return -1 if the target element is not found
        return -1;
    }

    public static void main(String[] args) {
        int[] arr = {3, 5, 7, 9, 11, 13, 15};
        int target = 9;
        
        // Perform linear search
        int result = linearSearch(arr, target);
        
        // Print the result
        if (result != -1) {
            System.out.println("Element found at index: " + result);
        } else {
            System.out.println("Element not found in the array.");
        }
    }
}
