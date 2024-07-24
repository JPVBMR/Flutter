# Chat App Development Overview


### 1. Flutter Basics
- Creating a new Flutter project.
- Replacing the default `main.dart` file with a basic app widget for theming.

### 2. User Authentication
- All users must create an account and sign in before sending or receiving messages.
- User authentication involves:
  - Collecting user credentials (email and password).
  - Sending credentials to a backend for validation and storage.

### 3. Backend Service: Firebase
- Firebase will be used for user authentication.
- Firebase Authentication provides storage and validation of user credentials.

### 4. Firebase Authentication REST API
- Firebase provides specific URLs to send user credentials.
- These URLs are used for creating and signing in users.

### 5. HTTP Requests
- Communication between frontend (Flutter app) and backend (Firebase) happens through HTTP requests.
- Manually handling HTTP requests can be cumbersome.

### 6. Firebase SDK
- SDK (Software Development Kit) is a collection of pre-built code to simplify working with services like Firebase.
- The Firebase SDK makes it easier to handle authentication, image upload, push notifications, etc.

# Step-by-Step Development

### Step 1: Create a New Flutter Project
- Name the project (e.g., `ChatApp`).
- Replace the default `main.dart` with a basic app widget.

### Step 2: Add User Authentication
- Create a screen and a form to collect user credentials.
- Use Firebase for authentication.

### Step 3: Firebase CLI Installation
- Install the Firebase CLI to interact with Firebase.
- This tool is essential for working with Firebase services on your system.

### Step 4: Install Firebase CLI
- Use a package manager like NPM to install Firebase CLI.
- Verify installation by running `firebase` in your system terminal.

### Step 5: Login to Firebase
- Use the Firebase CLI to log into your Google account.
- Authenticate your CLI with your Firebase project.

### Step 6: Install FlutterFire CLI
- Install the FlutterFire CLI using the Firebase CLI.
- This tool helps manage Firebase integration in Flutter projects.

### Step 7: Configure Flutter Project for Firebase
- Use FlutterFire CLI to configure your Flutter project for Firebase.
- This involves setting up necessary Firebase services in the project.
- **FlutterFire Configuration** - connect our Flutter project to Firebase by running the flutterfire configure command. When going through all the questions asked by this command, you must specify an Android application ID. **Specify the name of your package which you find in the android/app/build.gradle file**.


### Tools and Commands

#### Firebase CLI Commands
- `firebase login`: Log into your Firebase account.
- `firebase init`: Initialize Firebase services in your project.

#### FlutterFire CLI Commands
- `flutterfire configure`: Configure Firebase in your Flutter project.
- Ensure the FlutterFire CLI path is correctly set up in your terminal configuration.

## Architecture

### Frontend: Flutter App
- **Main.dart**: Defines the basic app widget and theming.
- **Authentication Screen**: 
  - Form to collect email and password.
  - Interface for user login and registration.
- **Firebase SDK**: Used for seamless communication with Firebase services.

### Backend: Firebase
- **Firebase Project**: Create a new Firebase project.
- **Authentication Setup**:
  - Enable Email/Password authentication in Firebase.
  - Manage user authentication and credential validation.
- **Firebase CLI**: Tool for managing Firebase services.
- **FlutterFire CLI**: Tool for integrating Firebase with Flutter projects.

## Advanced Features to be Added
- **Image Upload**: Allow users to upload and display profile pictures.
- **Push Notifications**: Notify users of new messages and updates.