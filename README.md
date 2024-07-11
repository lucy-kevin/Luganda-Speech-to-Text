# Luganda-Speech-to-Text
## Inspiration
The inspiration for developing the Luganda Speech-to-Text (STT) system came from the desire to bridge the communication gap faced by deaf students in Luganda-speaking communities. We recognized the need for a tool that could transcribe spoken Luganda into text, enabling these students to access educational content and participate fully in classroom activities.

## What it does
The Luganda STT application transcribes spoken Luganda into text in real-time, allowing users to save the transcriptions for future reference. 
## How we built it
We reviewed existing literature on speech-to-text systems to understand methodologies, challenges, and opportunities. Based on our findings, we designed a robust system architecture that includes a mobile application and an API.
Using the Flutter framework and Dart language, we created a user-friendly mobile application. The app records audio, sends it to the API for transcription, and displays the transcribed text.
We used Flask to develop the API, which interacts with the pre-trained Indonesian-nlp/wav2vec2-luganda model to process the audio data and return the transcriptions.
We conducted comprehensive testing, including accuracy and usability tests, to ensure the system’s functionality and performance.

## Challenges we ran into
Ensuring seamless communication between the mobile application and the API required significant effort and hosting the API is quite costly. 
## Accomplishments that we're proud of
We successfully developed a working Luganda STT application that transcribes spoken Luganda into text.
The application empowers deaf students by providing them with a tool that enhances their communication and access to educational content.
Hosting the API on an AWS EC2 instance ensures that the system is scalable and reliable, capable of handling an increasing number of users.
## What we learned
We gained valuable experience in mobile application development using Flutter, API development with Flask, and integrating speech recognition models.
The quality and diversity of training data are crucial for the accuracy of speech-to-text models.
Designing user-friendly interfaces and conducting thorough testing are essential for creating tools that meet users’ needs effectively.
## What's next for Luganda Speech to text 
