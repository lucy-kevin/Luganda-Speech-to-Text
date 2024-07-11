import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

late Timer _transcriptionTimer;
class Note {
  final String title;
  final String transcription;

  Note({
    required this.title,
    required this.transcription,
  });
}

class VoiceRecorder extends StatefulWidget {
  const VoiceRecorder({Key? key}) : super(key: key);

  @override
  _VoiceRecorderState createState() => _VoiceRecorderState();
}

class _VoiceRecorderState extends State<VoiceRecorder> {
  FlutterSoundRecorder? _audioRecorder;
  FlutterSoundPlayer? _audioPlayer;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _transcriptionController = TextEditingController();
  String _recorderStatus = 'Uninitialized';
  bool _isPlaying = false;
  bool _isRecording = false;
  String? _currentRecordingPath;
  List<Note> _savedNotes = [];

  @override
  void initState() {
    super.initState();
    _initializeRecorderAndPlayer();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _transcriptionController.dispose();
    _disposeAsync();
    super.dispose();
  }

  Future<void> _disposeAsync() async {
    try {
      await _audioRecorder?.closeRecorder();
      await _audioPlayer?.closePlayer();
    } catch (e) {
      print('Error during async disposal: $e');
    }
  }

  Future<void> _initializeRecorderAndPlayer() async {
    try {
      // Initialize audio recorder
      if (_audioRecorder == null) {
        _audioRecorder = FlutterSoundRecorder();
        await _audioRecorder?.openRecorder();
      }

      // Initialize audio player
      if (_audioPlayer == null) {
        _audioPlayer = FlutterSoundPlayer();
        await _audioPlayer?.openPlayer();
      }

      // Update recorder status in state
      setState(() {
        _recorderStatus = 'Initialized';
      });
    } catch (e) {
      print('Error initializing recorder or player: $e');
      setState(() {
        _recorderStatus = 'Initialization Error';
      });
    }
  }

  Future<void> requestMicrophonePermission() async {
    final PermissionStatus status = await Permission.microphone.request();
    if (status == PermissionStatus.granted) {
      _toggleRecording();
    } else {
      setState(() {
        _recorderStatus = 'Permission Denied';
      });
    }
  }

 Future<void> _toggleRecording() async {
  if (_isRecording) {
    // Stop recording and cancel the transcription timer
    try {
      await _audioRecorder!.stopRecorder();
      _transcriptionTimer.cancel(); // Cancel the timer
      setState(() {
        _isRecording = false;
        _recorderStatus = 'Stopped';
      });

      // Transcribe the recording after stopping it
      await _transcribeRecording();
    } catch (e) {
      print('Error stopping recording: $e');
    }
  } else {
    // Start recording and start the transcription timer
    try {
      final Directory appDocDirectory = await getApplicationDocumentsDirectory();
      _currentRecordingPath = '${appDocDirectory.path}/temp_record.wav';
      await _audioRecorder!.startRecorder(
        toFile: _currentRecordingPath,
        codec: Codec.pcm16WAV,
      );
      setState(() {
        _isRecording = true;
        _recorderStatus = 'Recording';
      });

      // Start the transcription timer
      _transcriptionTimer = Timer.periodic(const Duration(seconds: 5), (Timer timer) async {
        await _transcribeRecording();
      });
    } catch (e) {
      print('Error starting recording: $e');
    }
  }
}

Future<void> _transcribeRecording() async {
  if (_currentRecordingPath != null) {
    final apiUrl = 'http://35.180.10.138/transcribe';
    try {
      final File audioFile = File(_currentRecordingPath!);
      final fileLength = await audioFile.length();
      final request = http.MultipartRequest('POST', Uri.parse(apiUrl))
        ..files.add(http.MultipartFile(
          'audio',
          audioFile.openRead(),
          fileLength,
          filename: 'audio.wav',
        ));

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final decodedBody = jsonDecode(responseBody);
        final transcription = decodedBody['transcription'];
        setState(() {
          _transcriptionController.text = transcription;
        });
        print('API call successful: $transcription');
      } else {
        final responseBody = await response.stream.bytesToString();
        print('Failed to call API: ${response.statusCode}');
        print('Response body: $responseBody');
      }
    } catch (e) {
      print('Error making API call: $e');
    }
  }
}


  Future<void> playRecordedSound() async {
    if (_isPlaying) {
      // Stop playing
      await _audioPlayer!.stopPlayer();
      setState(() {
        _isPlaying = false;
      });
      return;
    }

    // Start playing
    try {
      setState(() => _isPlaying = true);
      await _audioPlayer!.startPlayer(
        fromURI: _currentRecordingPath,
        whenFinished: () {
          setState(() => _isPlaying = false);
        },
      );
    } catch (e) {
      print('Error playing recorded sound: $e');
      setState(() => _isPlaying = false);
    }
  }

  Future<void> saveNote() async {
    final String title = _titleController.text;
    final String transcription = _transcriptionController.text;

    if (title.isNotEmpty && transcription.isNotEmpty) {
      try {
        // Save the note to Firestore
        await FirebaseFirestore.instance.collection('notes').add({
          'title': title,
          'transcription': transcription,
        });

        setState(() {
          _savedNotes.add(Note(title: title, transcription: transcription));
          _titleController.clear();
          _transcriptionController.clear();
        });
      } catch (e) {
        print('Error saving note: $e');
      }
    } else {
      print('Title or transcription is empty.');
    }
  }

  Future<void> deleteNoteFromFirestore(String noteId) async {
    try {
      await FirebaseFirestore.instance.collection('notes').doc(noteId).delete();
    } catch (e) {
      print('Error deleting note from Firestore: $e');
    }
  }

  void deleteNoteAtIndex(int index) {
    if (index >= 0 && index < _savedNotes.length) {
      final Note note = _savedNotes[index];
      deleteNoteFromFirestore(note.title);
      setState(() {
        _savedNotes.removeAt(index);
      });
    }
  }

  void editNoteAtIndex(int index) {
    if (index >= 0 && index < _savedNotes.length) {
      final Note note = _savedNotes[index];
      _titleController.text = note.title;
      _transcriptionController.text = note.transcription;
      deleteNoteAtIndex(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTitleInput(),
            _buildTranscriptionInput(),
            _buildRecorderStatus(),
            _buildRecordButton(),
            _buildPlayButton(),
            _buildSaveButton(),
            if (_savedNotes.isNotEmpty) _buildSavedNotesList(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: _titleController,
        decoration: InputDecoration(
          hintText: 'Enter title',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  Widget _buildTranscriptionInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: _transcriptionController,
        decoration: InputDecoration(
          hintText: 'Transcription will appear here',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  Widget _buildRecorderStatus() {
    return Text(
      _recorderStatus,
      style: const TextStyle(fontSize: 16),
    );
  }

  Widget _buildRecordButton() {
    return ElevatedButton.icon(
      icon: Icon(_isRecording ? Icons.stop : Icons.mic),
      label: Text(_isRecording ? 'Stop Recording' : 'Start Recording'),
      onPressed: _isPlaying ? null : requestMicrophonePermission,
    );
  }

  Widget _buildPlayButton() {
    return ElevatedButton.icon(
      icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
      label: Text(_isPlaying ? 'Stop' : 'Play'),
      onPressed: (_recorderStatus == 'Recording') ? null : playRecordedSound,
    );
  }


Widget _buildSaveButton() {
  return ElevatedButton.icon(
    icon: const Icon(Icons.save),
    label: const Text('Save'),
    onPressed: () {
      if (_titleController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please enter a title'),
            duration: Duration(seconds: 2),
          ),
        );
        return; // Return if the title is empty
      }
      saveNote(); // Call saveNote if the title is not empty
    },
  );
}

Widget _buildSavedNotesList() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Saved Notes:',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 10),
      ListView.builder(
        shrinkWrap: true,
        itemCount: _savedNotes.length,
        itemBuilder: (context, index) {
          final Note note = _savedNotes[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: ListTile(
              title: Text(note.title),
              subtitle: Text(note.transcription),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => editNoteAtIndex(index),
                  ),
                    IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => deleteNoteAtIndex(index),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ],
  );
}

}
