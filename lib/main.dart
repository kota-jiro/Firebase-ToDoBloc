import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase/firebase_options.dart';
import 'package:flutter_firebase/ui/project/login.dart';
import 'package:flutter_firebase/ui/project/register.dart';
import 'package:flutter_firebase/ui/project/todo.dart';
import 'package:flutter_firebase/ui/todo_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoBloc(), // Provide the TodoBloc here
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
        routes: {
          '/login': (context) => LoginPage(),
          '/register': (context) => RegisterPage(),
          '/todo': (context) => MyTodoPage(),
        },
      ),
    );
  }
}
