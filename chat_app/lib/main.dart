import 'package:chat_app/screens/authentication_screen.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/loading_sceen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:chat_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const App(),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FlutterChat',
      theme: ThemeData().copyWith(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 4, 78, 7)),
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, snapshot) {
          /* If already Logged In ( With Firebase Token ) */
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingSceen();
          } else if (snapshot.hasData) {
            return const ChatScreen();
          } else {
            return const AuthenticationScreen();
          }
        },
      ),
    );
  }
}
