import 'package:fluchat/app.dart';
import 'package:fluchat/screens/select_user_screen.dart';
import 'package:fluchat/theme.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final client = StreamChatClient(
    streamKey,
    // logLevel: Level.INFO,
  );
  runApp(
    MyApp(
      client: client,
      appTheme: AppTheme(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final StreamChatClient client;
  final AppTheme appTheme;
  const MyApp({Key? key, required this.client, required this.appTheme})
      : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme.light,
      darkTheme: appTheme.dark,
      themeMode: ThemeMode.dark,
      title: 'Chatter',
      builder: (context, child) {
        return StreamChatCore(
          client: client,
          child: ChannelsBloc(
            child: UsersBloc(
              child: child!,
            ),
          ),
        );
      },
      home: const SelectUserScreen(),
    );
  }
}
