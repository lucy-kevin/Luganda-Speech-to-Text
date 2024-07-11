import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lugandastt/app.dart';
import 'package:user_repository/user_repository.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'simple_bloc_observer.dart';

void main() async {
    // Ensure Flutter is initialized
    WidgetsFlutterBinding.ensureInitialized();

    // Initialize Firebase and other dependencies
    await initializeDependencies();

    // Run the app with the FirebaseUserRepo
    runApp(MyApp(FirebaseUserRepo()));
}

Future<void> initializeDependencies() async {
    // Initialize Firebase
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
    );

    // Set up Bloc observer
    Bloc.observer = SimpleBlocObserver();
}
