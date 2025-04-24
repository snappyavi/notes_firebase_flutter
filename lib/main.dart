import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes_firebase/change_notifier/notes_provider.dart';
import 'package:notes_firebase/change_notifier/registration_controller.dart';
import 'package:notes_firebase/core/constants.dart';
import 'package:notes_firebase/pages/registration_page.dart';
import 'package:notes_firebase/services/auth_services.dart';
import 'package:provider/provider.dart';
import 'pages/main_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          //allows provider to get access to fab feature and also main page
          create: (context) => NotesProvider(),
        ),
        ChangeNotifierProvider(
          //allows provider to get access to fab feature and also main page
          create: (context) => RegistrationController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Notes',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: primary),
          useMaterial3: true,
          fontFamily: 'Poppins',
          scaffoldBackgroundColor: background,
          //uses existing appbar theme for context for tweaking
          appBarTheme: Theme.of(context).appBarTheme.copyWith(
            backgroundColor: Colors.transparent,
            titleTextStyle: const TextStyle(
              // color: primary,
              fontSize: 32,
              //added font specific for appbar
              fontFamily: 'Fredoka',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        home: StreamBuilder<User?>(
          stream: AuthService.userStream,
          builder: (context, snapshot) {
            return snapshot.hasData?const HomePage(): RegistrationPage();
          }
        ),
      ),
    );
  }
}
