import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class Inside extends StatefulWidget {
  const Inside(this.number, {super.key});

  final int number;

  @override
  State<Inside> createState() => _InsideState();
}

class _InsideState extends State<Inside> {
  int currentNumber = 0;
  bool isLooping = false;
  void toggleLoop() {
    setState(() {
      isLooping = !isLooping;
    });

    player.setReleaseMode(isLooping ? ReleaseMode.loop : ReleaseMode.release);
  }

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

  bool isPlaying = false;

  Duration position = Duration.zero;

  Duration duration = Duration.zero;

  final AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    super.initState();

    // لأن الرقم القادم من الصفحة السابقة يبدأ من 1
    currentNumber = widget.number;

    // مكاننا الحالي في الأغنية
    player.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });

    // مدة الأغنية
    player.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    // عند انتهاء الأغنية
    player.onPlayerComplete.listen((event) {
      setState(() {
        position = Duration.zero;
        isPlaying = false;
      });
    });
  }

  // تشغيل وإيقاف الأغنية
  void playMusic() {
    if (isPlaying) {
      player.pause();

      setState(() {
        isPlaying = false;
      });
    } else {
      player.play(AssetSource(musicList[currentNumber]["music"]!));

      setState(() {
        isPlaying = true;
      });
    }
  }

  // تغيير الأغنية
  Future<void> changeMusic(int newNumber) async {
    await player.stop();

    setState(() {
      currentNumber = newNumber;
      isPlaying = false;
      position = Duration.zero;
      duration = Duration.zero;
    });

    await player.setSource(AssetSource(musicList[currentNumber]["music"]!));

    final newDuration = await player.getDuration();

    setState(() {
      duration = newDuration ?? Duration.zero;
    });
  }

  // تحويل الوقت إلى 00:00
  String formatDuration(Duration time) {
    String minutes = time.inMinutes.toString().padLeft(2, '0');

    String seconds = (time.inSeconds % 60).toString().padLeft(2, '0');

    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 166, 204, 200),

      appBar: AppBar(
        backgroundColor: Colors.teal,
        automaticallyImplyLeading: false,

        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(musicList[currentNumber]["text"]!),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_forward),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),

          ClipRRect(
            borderRadius: BorderRadius.circular(12),

            child: Image.asset(
              musicList[currentNumber]["image"]!,
              width: 300,
              height: 300,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 190),

          // الوقت
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(formatDuration(position)),
              ),

              const Expanded(child: SizedBox()),

              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Text(formatDuration(duration)),
              ),
            ],
          ),

          // شريط الصوت
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),

            child: Slider(
              value: position.inSeconds.toDouble(),

              max: duration.inSeconds.toDouble() > 0
                  ? duration.inSeconds.toDouble()
                  : 1,

              activeColor: Colors.blueAccent,

              onChanged: (value) {
                final newPosition = Duration(seconds: value.toInt());

                setState(() {
                  position = newPosition;
                });

                player.seek(newPosition);
              },
            ),
          ),

          // أزرار التحكم
          Stack(
            alignment: Alignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // زر السابق
                  IconButton(
                    onPressed: () {
                      if (currentNumber > 0) {
                        changeMusic(currentNumber - 1);
                      }
                    },
                    icon: const Icon(Icons.skip_previous, size: 50),
                  ),

                  // زر التشغيل
                  IconButton(
                    onPressed: () {
                      playMusic();
                    },
                    icon: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                      size: 50,
                    ),
                  ),

                  // زر التالي
                  IconButton(
                    onPressed: () {
                      if (currentNumber < musicList.length - 1) {
                        changeMusic(currentNumber + 1);
                      }
                    },
                    icon: const Icon(Icons.skip_next, size: 50),
                  ),
                ],
              ),

              // زر التكرار على اليمين
              Positioned(
                right: 20,
                child: IconButton(
                  onPressed: () {
                    toggleLoop();
                  },
                  icon: Icon(
                    Icons.repeat,
                    size: 35,
                    color: isLooping
                        ? Colors.blueAccent
                        : const Color.fromARGB(255, 53, 53, 53),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }
}
