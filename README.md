# Notes Cloud App

![Flutter](https://img.shields.io/badge/Flutter-2.8.0-1389FD?logo=flutter)
![Firebase](https://img.shields.io/badge/Firebase-9.0.0-FFCA28?logo=firebase)

Notes Cloud App is a Flutter application that allows you to easily and securely take and manage your notes. The app uses Firebase for authentication and cloud data storage.

## Screenshots



## Features

- **User Authentication:** Users can log in with their account or register for a new one.
- **Note Management:** Create, edit, and delete notes.
- **Favorites:** Mark your notes as favorites.
- **Reminder Functionality:** Set reminders for your notes.

## Technologies Used

- **Flutter:** The application is developed using the Flutter framework.
- **Firebase Authentication:** Handles user authentication.
- **Cloud Firestore:** Stores and syncs data in real-time.

## Project Structure

- **`lib/`**: Contains the main source code of the application.
  - **`pages/`**: Contains the different pages of the app (Auth, Home, etc.).
  - **`services/`**: Includes services for authentication and Firestore.
  - **`widgets/`**: Reusable UI components used across the app.

## Getting Started

1. **Clone the Repository:**
    ```bash
    git clone https://github.com/tu-usuario/notes-cloud-app.git
    cd notes-cloud-app
    ```

2. **Install Dependencies:**
    ```bash
    flutter pub get
    ```

3. **Run the Application:**
    ```bash
    flutter run
    ```

## Understanding the Code

- **`main.dart`:** Entry point of the application, initializes Firebase and runs the app.
- **`pages/`:** Contains the different screens/pages of the app (authentication, home, etc.).
- **`services/`:** Includes authentication and Firestore services.
- **`widgets/`:** Reusable UI components like dialogs and list items.
- **`FirestoreService.dart`:** Manages interactions with Cloud Firestore.

## Contributions

Thank you for considering contributing to the project! If you would like to contribute, please follow these steps:

1. Fork the Repository
2. Create Your Branch (`git checkout -b feature/AmazingFeature`)
3. Commit Your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push Your Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## Contact

- Hernán Rodríguez Garnica
- Email: hernanrg85@gmail.com
