import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:gatcha/data/items.dart';
import 'package:gatcha/widgets/custom_text.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smashing Feathers',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 238, 238, 239)),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StreamController<int> controller = StreamController<int>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 60, 0, 60),
                child: Image.asset('images/smashing-feathers-logo.png'),
              ),
              FortuneBar(
                  styleStrategy: const AlternatingStyleStrategy(),
                  height: 100,
                  selected: controller.stream,
                  animateFirst: false,
                  items: [
                    for (var item in items)
                      FortuneItem(child: CustomText(text: item)),
                  ]),
              SizedBox.fromSize(size: const Size.fromHeight(100)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        minimumSize: const Size.fromHeight(60),
                        backgroundColor:
                            const Color.fromARGB(255, 12, 106, 70)),
                    onPressed: () {
                      controller.add(Random().nextInt(items.length));
                    },
                    child: Text(
                      'Roll',
                      style: GoogleFonts.lilitaOne(
                          fontSize: 20,
                          color: const Color.fromARGB(255, 255, 255, 255)),
                    )),
              )
            ],
          )), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
