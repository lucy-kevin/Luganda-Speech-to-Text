
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lugandastt/Screens/home/voice_recorder.dart';
import 'package:lugandastt/blocs/signing_bloc/sign_In_bloc.dart';



class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
			appBar: AppBar(
				title: const Text(
					'Transcriber'
				),
				actions: [
					IconButton(
						onPressed: () {
							context.read<SignInBloc>().add(const SignOutRequired());
						}, 
						icon: const Icon(Icons.login)
					)
				],
			),
       body: const Center(
      child: VoiceRecorder(), // Add the VoiceRecorder widget here
    )
    );
  }
}

