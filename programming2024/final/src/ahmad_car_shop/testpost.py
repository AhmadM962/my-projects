import requests
import json

# Set the base URL for the Flask server
BASE_URL = "http://192.168.1.4:5000"

# Helper function to print formatted JSON responses
def print_response(response):
    print(json.dumps(response.json(), indent=4))

# Function to initialize a wallet
def initialize_wallet():
    user = input("Enter the name of the user: ")
    balance = int(input("Enter the initial balance: "))
    response = requests.post(f"{BASE_URL}/initialize_wallet", json={"user": user, "balance": balance})
    print_response(response)

# Function to add a new transaction
def add_transaction():
    sender = input("Enter the sender's name: ")
    receiver = input("Enter the receiver's name: ")
    amount = int(input("Enter the transaction amount: "))
    response = requests.post(f"{BASE_URL}/add_transaction", json={"sender": sender, "receiver": receiver, "amount": amount})
    print_response(response)

# Function to mine a new block
def mine_block():
    response = requests.get(f"{BASE_URL}/mine_block")
    print_response(response)

# Function to get the full blockchain
def get_chain():
    response = requests.get(f"{BASE_URL}/get_chain")
    print_response(response)

# Function to check if the blockchain is valid
def is_valid():
    response = requests.get(f"{BASE_URL}/is_valid")
    print_response(response)

# Function to display the menu and take user input
def display_menu():
    print("\n=== Blockchain Test Menu ===")
    print("1. Initialize Wallet")
    print("2. Add Transaction")
    print("3. Mine a Block")
    print("4. Get Full Blockchain")
    print("5. Check Blockchain Validity")
    print("6. Exit")

# Main function to drive the menu and handle user choices
def main():
    while True:
        display_menu()
        choice = input("Enter your choice (1-6): ")

        if choice == "1":
            print("\n--- Initialize Wallet ---")
            initialize_wallet()

        elif choice == "2":
            print("\n--- Add Transaction ---")
            add_transaction()

        elif choice == "3":
            print("\n--- Mine a Block ---")
            mine_block()

        elif choice == "4":
            print("\n--- Get Full Blockchain ---")
            get_chain()

        elif choice == "5":
            print("\n--- Check Blockchain Validity ---")
            is_valid()

        elif choice == "6":
            print("Exiting... Goodbye!")
            break

        else:
            print("Invalid choice! Please choose an option from 1 to 6.")

# Run the main function if the script is executed directly
if __name__ == "__main__":
    main()
