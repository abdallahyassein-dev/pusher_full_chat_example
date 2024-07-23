import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pusher_full_chat_example/core/dio_helper.dart';
import 'package:pusher_full_chat_example/core/navigator_utils.dart';
import 'package:pusher_full_chat_example/core/widgets/app_button.dart';
import 'package:pusher_full_chat_example/features/chat/chat_screen.dart';
import 'package:pusher_full_chat_example/features/chat/cubit/chat_cubit.dart';

void main() {
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Full Pusher Chat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff168AFF)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Pusher Full Features Chat'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(),
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                widget.title,
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff168AFF)),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(400),
                    child: Image.asset("assets/images/logo.png")),
              ),
              const SizedBox(
                height: 10,
              ),
              AppButton(
                  buttonText: "Go To Chat",
                  onPressed: () {
                    pushScreen(
                        context,
                        BlocProvider(
                            create: (context) => ChatCubit(),
                            child: const ChatScreen()));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
