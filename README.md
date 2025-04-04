# Shoptreo - Flutter Developer Assessment

## Project Description

**Shoptreo** is a Flutter-based mobile application designed to facilitate user registration, product browsing, and seamless authentication. The app integrates with [fakestoreapi.com](https://fakestoreapi.com) for fetching product data and includes essential features such as login, signup, and viewing product details. This assessment evaluates skills in Flutter development, state management using **Provider**, and API integration.

---

## Table of Contents

* [Setup Instructions](#setup-instructions)
* [Features](#features)
* [API Integration](#api-integration)
* [Technologies Used](#technologies-used)
* [App Walkthrough](#app-walkthrough)
* [Test Credentials](#test-credentials)
* [Notes](#notes)
* [Screenshots](#screenshots)
* [Submission](#submission)

---

## Setup Instructions

Follow these instructions to set up and run the project on your local machine.

### Prerequisites

* **Flutter SDK:** Ensure you have the Flutter SDK installed. You can download it from [https://flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install).
* **Android Studio or Xcode (Optional):** These IDEs are recommended for a better development experience, but you can also use other editors like VS Code.
* **Emulator or Physical Device:** You'll need an Android emulator, iOS simulator, or a physical device to run the app.

### Installation Steps

1.  **Clone the Repository:**

    Clone the repository to your local machine using Git:

    ```bash
    git clone https://github.com/Bert1041/shoptreo.git
    cd shoptreo
    ```

2.  **Install Dependencies:**

    Navigate to the project directory in your terminal and run the following command to fetch all the necessary packages:

    ```bash
    flutter pub get
    ```

3.  **Run the Application:**

    Connect an emulator or physical device. Then, execute the following command to build and run the app:

    ```bash
    flutter run
    ```

---

## Features

* **Onboarding Screens:** Introduces users to the app's core functionality.
* **User Authentication:**
    * **Login:** Allows existing users to access their accounts securely.
    * **Signup:** Enables new users to create accounts.
* **Product List:** Fetches and displays a list of products from the fakestoreapi.com.
* **Product Details:** Provides detailed information about individual products when selected.
* **Logout Functionality:** Allows users to securely log out of their session.

---

## API Integration

The app communicates with the [fakestoreapi.com](https://fakestoreapi.com) to retrieve product data.

* **Base URL:** `https://fakestoreapi.com`
* **API Endpoints:**
    * `/products`: Fetches a list of all products.
    * `/products/{id}`: Fetches details for a specific product using its ID.

---

## Technologies Used

* **Flutter:** A cross-platform UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.
* **Provider:** A state management package that simplifies managing and accessing application state.
* **HTTP:** The `http` package for making network requests to the fakestoreapi.com.
* **Flutter Secure Storage:** A package for securely storing sensitive data like authentication tokens.
* **Shared Preferences:** A plugin for simple key-value storage of persistent data.
* **Freezed:** A code generation package for creating immutable data classes, reducing boilerplate code.
* **JSON Serialization:** `json_serializable` and `freezed_annotation` are used together to automate the serialization and deserialization of JSON data.
* **Flutter ScreenUtil:** A package to adapt UI to different screen sizes and densities.

---

## App Walkthrough

1.  **Login:** Users can log in using their registered credentials.
    * **Test Credentials (for demonstration):**
        * **Email:** `test@test.com`
        * **Password:** `Password123!`

2.  **Sign Up:** New users can create an account by providing the required information:
    * Email
    * Password
    * First Name
    * Last Name
    * Agreement to Terms and Conditions

3.  **Product List:** Upon successful login, users are directed to the product list screen. Products are displayed in a grid or list format, fetched dynamically from the API.

4.  **Product Details:** Tapping on a product in the list navigates the user to the product details screen, showcasing comprehensive information about the selected product.

5.  **Logout:** Users can log out of the application, which clears the current session and returns them to the login screen.

---

## Test Credentials

For quick testing and demonstration purposes, you can use the following credentials:

* **Email:** `test@test.com`
* **Password:** `Password123!`

