# Luganda Speech-to-Text App

## Overview
The Luganda Speech-to-Text (STT) app is designed to transcribe spoken Luganda into text in real-time. This tool aims to bridge the communication gap faced by deaf students in Luganda-speaking communities by enabling them to access educational content and participate fully in classroom activities.

## Features
- Real-time transcription of spoken Luganda to text
- User account management
- Storage of transcriptions for future reference

## Technologies Used
- **Framework**: Flutter
- **Backend**: Firebase (for storage and user account management)
- **Speech-to-Text Model**: Indonesian-nlp/wav2vec2-luganda

## Getting Started

### Prerequisites
- Flutter SDK
- Firebase account

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/lucy-kevin/Luganda-Speech-to-Text.git
   cd Luganda-Speech-to-Text
   ```

2. **Set up Firebase:**
   - Go to the [Firebase Console](https://console.firebase.google.com/).
   - Create a new project.
   - Add an Android/iOS app to your Firebase project and follow the instructions to download the `google-services.json` (for Android) or `GoogleService-Info.plist` (for iOS) file.
   - Place the `google-services.json` file in the `android/app` directory or the `GoogleService-Info.plist` file in the `ios/Runner` directory.

3. **Install dependencies:**
   ```bash
   flutter pub get
   ```

4. **Run the app:**
   ```bash
   flutter run
   ```

## Usage
1. **Create an Account/Login:**
   - Users need to create an account or log in to use the app.
   - Firebase handles user authentication and account management.

2. **Record and Transcribe:**
   - Press the record button to start recording audio.
   - The app sends the recorded audio to the API for transcription.
   - The transcribed text is displayed on the screen in real-time.

3. **Save Transcriptions:**
   - Users can save transcriptions for future reference.
   - Saved transcriptions are stored in Firebase.

## Contributing
We welcome contributions! Please read our [Contributing Guidelines](CONTRIBUTING.md) for more information.


## Contact
For any questions or inquiries, please contact us at kayikayikevin7@gmail.com / aningashillah@gmail.com

## Links
- [The Luganda Speech-to-Text API](https://github.com/lucy-kevin/luganda-stt-api)
- [The Luganda Speech-to-Text App](https://github.com/lucy-kevin/Luganda-Speech-to-Text)
