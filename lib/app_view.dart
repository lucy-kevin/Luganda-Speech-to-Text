
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lugandastt/Screens/auth/Welcome_Screen.dart';
import 'package:lugandastt/Screens/home/home_Screen.dart';
import 'package:lugandastt/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:lugandastt/blocs/signing_bloc/sign_In_bloc.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Transcribe',
      debugShowCheckedModeBanner: false,
       theme: ThemeData(
        colorScheme: const ColorScheme.light(
          background: Color.fromARGB(255, 226, 202, 250), 
          primary: Color.fromARGB(239, 152, 58, 240), 
          onPrimary: Colors.black, 
          secondary: Color.fromARGB(209, 29, 33, 224),
          onSecondary: Color.fromRGBO(5, 246, 222, 0.742),
          error: Colors.red, 
          outline: Color(0xFF424242),
          tertiary: Color.fromARGB(255, 228, 226, 219),
          onBackground: Color.fromARGB(255, 75, 21, 21))
          
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state){
          
          if(state.status == AuthenticationStatus.authenticated){
            return BlocProvider(
              create: (context) => SignInBloc(
                userRepository: context.read<AuthenticationBloc>().userRepository

              ),
              child: const HomeScreen(), 
            );
          }else{
            return const WelcomeScreen();
          }
        }
      ),
    );
  }
}