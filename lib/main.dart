import 'package:chatapp/screen/chat_screen.dart';
import 'package:chatapp/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(AiSample(
    apikey: dotenv.env["API_KEY"],
  ));
}

class AiSample extends StatelessWidget {
  const AiSample({super.key, this.apikey});
  final String? apikey;



  @override
  Widget build(BuildContext context) {
  
 
    return MaterialApp(
  
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: const Color.fromARGB(255, 0, 0, 0),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) {
          ScreenUtil.init(context);
          return  ChatScreen(apikey: apikey,);
        },
      ),
    );
  }
}
