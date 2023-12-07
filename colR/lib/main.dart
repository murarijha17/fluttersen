import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.amber),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      appBar: AppBar(
        title: Text(
          "Hello World",
          style: TextStyle(
              fontFamily: 'FontMain',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              backgroundColor: Colors.red),
        ),
      ),
      body: Column(
        children: <Text>[
          //<Widget>
          Text(
            'Cow Hamari Mata Hai Humko AAJ BHI ISSKE ALWA KUCH NHI AATA HAI',
            style: TextStyle(
                backgroundColor: Colors.amber,
                color: Colors.white,
                fontFamily: 'FontMain',
                fontSize: 22,
                fontWeight: FontWeight.bold),
          ),
          Text(
            'Cow Hamari Mata Hai Humko AAJ BHI ISSKE ALWA KUCH NHI AATA HAI',
            style: TextStyle(
                backgroundColor: Colors.blue,
                color: Colors.white,
                fontFamily: 'FontMain',
                fontSize: 23,
                fontWeight: FontWeight.bold),
          ),
          Text(
            'Cow Hamari Mata Hai Humko AAJ BHI ISSKE ALWA KUCH NHI AATA HAI',
            style: TextStyle(
                backgroundColor: Colors.black,
                color: Colors.white10,
                fontFamily: 'FontMain',
                fontSize: 23,
                fontWeight: FontWeight.w100),
          ),
          Text(
            'Cow Hamari Mata Hai Humko AAJ BHI ISSKE ALWA KUCH NHI AATA HAI',
            style: TextStyle(
                backgroundColor: Colors.white,
                color: Colors.amber,
                fontFamily: 'Fontmain',
                fontSize: 22,
                fontWeight: FontWeight.bold),
          ),
          Text(
            'Cow Hamari Mata Hai Humko AAJ BHI ISSKE ALWA KUCH NHI AATA HAI',
            style: TextStyle(
                backgroundColor: Colors.brown,
                color: Colors.white,
                fontFamily: 'FontMain',
                fontSize: 23,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
