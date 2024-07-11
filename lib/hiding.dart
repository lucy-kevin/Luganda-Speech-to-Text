// // import 'package:flutter/material.dart';
// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:user_repository/src/firebase_user_repo.dart';
// // import 'firebase_options.dart';
// // import 'login.dart';
// // import 'signup.dart';


// // void main() async {
// //    await Firebase.initializeApp(
// //   options: DefaultFirebaseOptions.currentPlatform,
// // );
// //   runApp(MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   MyApp(FirebaseUserRepo firebaseUserRepo);

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Theme Changer',
// //       theme: ThemeData.light(),
// //       darkTheme: ThemeData.dark(),
// //       home: MyHomePage(),
// //       debugShowCheckedModeBanner: false,
// //     );
// //   }
// // }

// // class MyHomePage extends StatefulWidget {
// //   @override
// //   _MyHomePageState createState() => _MyHomePageState();
// // }

// // class _MyHomePageState extends State<MyHomePage> {
// //   ThemeData _currentTheme = ThemeData.light();

// //   TextEditingController _textEditingController = TextEditingController();
// //   String _savedText = '';
// //   String _savedTitle = '';
// //   List<Map<String, String>> _savedTexts = [];

// //   @override
// //   Widget build(BuildContext context) {
// //     return Theme(
// //       data: _currentTheme,
// //       child: Scaffold(
// //         appBar: AppBar(
// //           title: Text('Transcribing'),
// //         ),
// //         body: Padding(
// //           padding: const EdgeInsets.all(16.0),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.center,
// //             children: [
// //               TextField(
// //                 controller: _textEditingController,
// //                 decoration: InputDecoration(
// //                   hintText: 'Type here...',
// //                 ),
// //               ),
// //               SizedBox(height: 16.0),
// //               Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: [
// //                   IconButton(
// //                     icon: Icon(Icons.keyboard),
// //                     onPressed: () {
// //                       // Toggle the keyboard visibility
// //                       FocusScope.of(context).requestFocus(FocusNode());
// //                     },
// //                   ),
// //                   IconButton(
// //                     icon: Icon(Icons.mic),
// //                     onPressed: () {
// //                       // Simulate voice recording and transcription
// //                       _simulateVoiceRecording();
// //                     },
// //                   ),
// //                 ],
// //               ),
// //               SizedBox(height: 16.0),
// //               ElevatedButton(
// //                 onPressed: () {
// //                   // Open a dialog to allow the user to add a title before saving
// //                   _showAddTitleDialog();
// //                 },
// //                 child: Text('Save'),
// //               ),
// //               SizedBox(height: 16.0),
// //               // Display the saved texts
// //               Expanded(
// //                 child: ListView.builder(
// //                   itemCount: _savedTexts.length,
// //                   itemBuilder: (context, index) {
// //                     return ListTile(
// //                       title: Text('${_savedTexts[index]['title']}'),
// //                       subtitle: Text('${_savedTexts[index]['text']}'),
// //                       trailing: IconButton(
// //                         icon: Icon(Icons.edit),
// //                         onPressed: () {
// //                           // Open a dialog to rename the text
// //                           _showRenameDialog(index);
// //                         },
// //                       ),
// //                     );
// //                   },
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //         drawer: Drawer(
// //           child: Column(
// //             children: [
// //                 ListTile(
// //   leading: Icon(Icons.login),
// //   title: Text(
// //     "Login",
// //     style: TextStyle(
// //       fontSize: 18,
// //       fontWeight: FontWeight.bold,
// //       color: Colors.blue,
// //     ),
// //   ),
// //   onTap: () {
// //     Navigator.pop(context);
// //     Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
// //   },
// // ),
// // ListTile(
// //   leading: Icon(Icons.app_registration),
// //   title: Text(
// //     'Sign Up',
// //     style: TextStyle(
// //       fontSize: 18,
// //       fontWeight: FontWeight.bold,
// //       color: Colors.blue,
// //     ),
// //   ),
// //   onTap: () {
// //     Navigator.pop(context);
// //     Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
// //   },
// // ),

// //               // Your existing drawer items

// //               // Spacer to push the theme changer to the bottom
// //               Spacer(),

// //               // Theme changing footer
// //               ListTile(
// //                 title: Text('Change Theme'),
// //                 onTap: () {
// //                   Navigator.pop(context);

// //                   // Open a dialog to choose the theme
// //                   showDialog(
// //                     context: context,
// //                     builder: (BuildContext context) {
// //                       return AlertDialog(
// //                         title: Text('Select Theme'),
// //                         content: Column(
// //                           children: [
// //                             ElevatedButton(
// //                               onPressed: () {
// //                                 // Change to light theme
// //                                 Navigator.pop(context);
// //                                 _changeTheme(ThemeData.light());
// //                               },
// //                               child: Text('Light Theme'),
// //                             ),
// //                             ElevatedButton(
// //                               onPressed: () {
// //                                 // Change to dark theme
// //                                 Navigator.pop(context);
// //                                 _changeTheme(ThemeData.dark());
// //                               },
// //                               child: Text('Dark Theme'),
// //                             ),
// //                           ],
// //                         ),
// //                       );
// //                     },
// //                   );
// //                 },
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //    // Function to show a dialog for adding a title before saving
// //   Future<void> _showAddTitleDialog() async {
// //     return showDialog<void>(
// //       context: context,
// //       builder: (BuildContext context) {
// //         TextEditingController _titleEditingController = TextEditingController();

// //         return AlertDialog(
// //           title: Text('Add Title before Save'),
// //           content: Column(
// //             mainAxisSize: MainAxisSize.min,
// //             children: [
// //               TextField(
// //                 controller: _titleEditingController,
// //                 decoration: InputDecoration(
// //                   labelText: 'Title',
// //                 ),
// //               ),
// //             ],
// //           ),
// //           actions: <Widget>[
// //             TextButton(
// //               onPressed: () {
// //                 Navigator.of(context).pop();
// //               },
// //               child: Text('Cancel'),
// //             ),
// //             TextButton(
// //               onPressed: () {
// //                 // Save the text with the provided title
// //                 String title = _titleEditingController.text;
// //                 setState(() {
// //                   _savedText = _textEditingController.text ?? '';
// //                   _savedTitle = title.isNotEmpty ? title : 'Default Title';
// //                   _savedTexts.add({'title': _savedTitle, 'text': _savedText});
// //                 });
// //                 // Clear the text field
// //                 _textEditingController.clear();

// //                 // Show a Snackbar for save feedback
// //                 ScaffoldMessenger.of(context).showSnackBar(
// //                   SnackBar(
// //                     content: Text('Text saved with title: $_savedTitle'),
// //                     duration: Duration(seconds: 2),
// //                   ),
// //                 );

// //                 Navigator.of(context).pop(); // Close the dialog
// //               },
// //               child: Text('Save'),
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }
// //  Future<void> _showRenameDialog(int index) async {
// //     return showDialog<void>(
// //       context: context,
// //       builder: (BuildContext context) {
// //         return AlertDialog(
// //           title: Text('Rename Text'),
// //           content: Column(
// //             mainAxisSize: MainAxisSize.min,
// //             children: [
// //               TextField(
// //                 controller: TextEditingController()..text = _savedTexts[index]['title'] ?? '',
// //                 onChanged: (value) {
// //                   _savedTexts[index]['title'] = value;
// //                 },
// //                 decoration: InputDecoration(
// //                   labelText: 'New Title',
// //                 ),
// //               ),
// //             ],
// //           ),
// //           actions: <Widget>[
// //             TextButton(
// //               onPressed: () {
// //                 Navigator.of(context).pop();
// //               },
// //               child: Text('Cancel'),
// //             ),
// //             TextButton(
// //               onPressed: () {
// //                 // Save the new title
// //                 setState(() {
// //                   // Update the title
// //                   _savedTexts[index]['title'] = _savedTexts[index]['title']?.trim() ?? '';
// //                 });
// //                 Navigator.of(context).pop();
// //               },
// //               child: Text('Save'),
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }

// //   void _simulateVoiceRecording() {
// //     // Your existing code for simulating voice recording and transcription
// //     // ...

// //     // Example code:
// //     // ...
// //   }

// //   void _changeTheme(ThemeData themeData) {
// //     setState(() {
// //       _currentTheme = themeData;
// //     });
// //   }
// // }

// // ignore: must_be_immutable
// class VoiceRecorder extends StatefulWidget {
// late Record audioRecord;
// late AudioPlayer audioPlayer;
// bool isRecording = false;
// String  audioPath ='';

// void initState(){
//   audioPlayer= AudioPlayer();
//   audioRecord = Record();
 
//   super.initState();

// }

// @override
// void dispose(){
//   audioPlayer.dispose();
//   audioRecord.dispose();
  

//   super.dispose();
// }






//   const VoiceRecorder({super.key});

//   @override
//   _VoiceRecorderState createState() => _VoiceRecorderState();
// }

// class _VoiceRecorderState extends State<VoiceRecorder> {
//   FlutterSoundRecorder? _audioRecorder;
//   String _recorderStatus = "Uninitialized";
//   String _pathToFile = "";

//   @override
//   void initState() {
//     super.initState();
//     openTheRecorder();
//   }

//   @override
//   void dispose() async {
//     await _audioRecorder!.closeRecorder();
//     super.dispose();
//   }

//   // Future<void> openTheRecorder() async {
//   //   try {
//   //     _audioRecorder ??= FlutterSoundRecorder();

//   //     await _audioRecorder!.openRecorder();
//   //     _recorderStatus = "Initialized";
//   //     setState(() {});
//   //   } catch (e) {
//   //     print('Error: $e');
//   //   }
//   // }

//   Future<void> startRecording() async {
//     try {
//       if(await audioRecord.hasPermission())
//       {
//         await AudioRecord.start();
//         setState(() {
//           isRecording = true;
//         });
//       }
//     }
//       catch(e){
//         print('Error Start Recording : $e');
//       }
//   }

//   Future<void> stopRecording() async {
//     try {
//       await audioRecord.stop();
//       String? path | await audiaRecord.stop();
//       setState(() {
//         isRecording = false;
//         audioPath = path!;
//       });
//     } catch (e) {
//       print('Error Stopping record: $e');
//     }
//   }

//  Future<void> playRecording() async{
//         try {
//           Source urlSource = UrlSource(audioPath);
//           await audioPlayer.play(source);
//         } catch (e) {
//           print('Error Playing Recording: $e');
//         }
//       }






//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children:<Widget> [
//        if(isRecording)
//        Text('Recording in Progress', )

//       ElevatedButton(
//           onPressed: isRecording ? stopRecording: startRecording,
//           child:isRecording
//           ?  const Text('Stop Recording')
//           : const Text('Start Recording'),
//         ),
//         SizedBox(height: 25,
//         ),
//         if(!isRecording && audioPath != null)
//         ElevatedButton(
//           onPressed: playRecording,
//           child: const Text('Play Recording'))

     






//         // ElevatedButton(
//         //   onPressed: _recorderStatus == "Recording" ? null : startRecording,
//         //   child: const Text('Start Recording'),
//         // ),
//         // const SizedBox(height: 20),
//         // ElevatedButton(
//         //   onPressed: _recorderStatus == "Recording" ? stopRecording : null,
//         //   child: const Text('Stop Recording'),
//         // ),
//       ],
//     );
//   }
// }





























// class VoiceRecorder extends StatefulWidget {
//   const VoiceRecorder({super.key});

//   @override
//   _VoiceRecorderState createState() => _VoiceRecorderState();
// }

// class _VoiceRecorderState extends State<VoiceRecorder> {
//   FlutterSoundRecorder? _audioRecorder;
//   String _recorderStatus = "Uninitialized";
//   String _pathToFile = "";

//   @override
//   void initState() {
//     super.initState();
//     openTheRecorder();
//   }

//   @override
//   void dispose() async {
//     await _audioRecorder!.closeRecorder();
//     super.dispose();
//   }

//   Future<void> openTheRecorder() async {
//     try {
//       _audioRecorder ??= FlutterSoundRecorder();

//       await _audioRecorder!.openRecorder();
//       _recorderStatus = "Initialized";
//       setState(() {});
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   Future<void> startRecording() async {
//     try {
//       Directory appDocDirectory = await getApplicationDocumentsDirectory();
//       String pathToFile = '${appDocDirectory.path}/temp_record.aac';

//       await _audioRecorder!.startRecorder(toFile: pathToFile, codec: Codec.aacADTS);
//       _pathToFile = pathToFile;
//       _recorderStatus = "Recording";
//       setState(() {});
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   Future<void> stopRecording() async {
//     try {
//       await _audioRecorder!.stopRecorder();
//       _recorderStatus = "Stopped";
//       setState(() {});
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(
//           _recorderStatus,
//           style: const TextStyle(fontSize: 20),
//         ),
//         const SizedBox(height: 20),
//         ElevatedButton(
//           onPressed: _recorderStatus == "Recording" ? null : startRecording,
//           child: const Text('Start Recording'),
//         ),
//         const SizedBox(height: 20),
//         ElevatedButton(
//           onPressed: _recorderStatus == "Recording" ? stopRecording : null,
//           child: const Text('Stop Recording'),
//         ),
//       ],
//     );
//   }
// }
