import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music/screens/inside.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Map<String, String>> musicList = [
    {
      'text': 'قران 1',
      'image': 'assets/images/image1.jpg',
      'music': 'file(1).mp3',
    },
    {
      'text': 'قران 2',
      'image': 'assets/images/image2.png',
      'music': 'file(2).mp3',
    },
    {
      'text': 'قران 3',
      'image': 'assets/images/image8.png',
      'music': 'file(3).mp3',
    },
    {
      'text': 'قران 4',
      'image': 'assets/images/image4.png',
      'music': 'file(4).mp3',
    },
    {
      'text': 'قران 5',
      'image': 'assets/images/image5.png',
      'music': 'file(5).mp3',
    },
    {
      'text': 'قران 6',
      'image': 'assets/images/image6.jpg',
      'music': 'file(6).mp3',
    },
    {
      'text': 'قران 7',
      'image': 'assets/images/image7.png',
      'music': 'file(7).mp3',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(239, 255, 255, 255),
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Row(
            children: [
              Icon(Icons.favorite, color: Colors.pinkAccent, size: 40),
              SizedBox(width: 10),
              Text(
                "My App Music",
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Box(
                text: musicList[0]['text']!,
                image: musicList[0]['image']!,
                number: 0,
              ),
              Box(
                text: musicList[1]['text']!,
                image: musicList[1]['image']!,
                number: 1,
              ),
              Box(
                text: musicList[2]['text']!,
                image: musicList[2]['image']!,
                number: 2,
              ),
              Box(
                text: musicList[3]['text']!,
                image: musicList[3]['image']!,
                number: 3,
              ),
              Box(
                text: musicList[4]['text']!,
                image: musicList[4]['image']!,
                number: 4,
              ),
              Box(
                text: musicList[5]['text']!,
                image: musicList[5]['image']!,
                number: 5,
              ),
              Box(
                text: musicList[6]['text']!,
                image: musicList[6]['image']!,
                number: 6,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Box extends StatelessWidget {
  const Box({
    super.key,
    required this.text,
    required this.image,
    required this.number,
  });

  final String text;
  final String image;
  final int number;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Inside(number)),
        );
      },
      splashColor: const Color.fromARGB(234, 186, 245, 245),

      child: Container(
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(color: CupertinoColors.inactiveGray, width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 25,
                color: const Color.fromARGB(255, 78, 78, 78),
              ),
            ),
            SizedBox(width: 15),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                image,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 15),
          ],
        ),
      ),
    );
  }
}
