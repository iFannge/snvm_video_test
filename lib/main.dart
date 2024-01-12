import 'package:dart_vlc/dart_vlc.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DartVLC.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Screensaver(),
    );
  }
}

class Screensaver extends StatefulWidget {
  const Screensaver({super.key});

  @override
  State<Screensaver> createState() => _ScreensaverState();
}

class _ScreensaverState extends State<Screensaver> {
  Player player = Player(id: 12345);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      if(!kDebugMode) {
        DesktopWindow.setFullScreen(true);
      }
    });

    final media = Media.asset('assets/videos/Example.mp4');
    player.setVolume(0);
    player.setPlaylistMode(PlaylistMode.loop);
    player.open(media, autoStart: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onPanDown: (value) {
          print('[Click] User clicked on the screen');
        },
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Video(
                player: player,
                showControls: false,
                fit: BoxFit.cover,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    color: const Color(0x88000000),
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Center(
                      child: Text(
                        'Нажмите для продолжения',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.03,
                            color: Colors.white
                        ),
                      ),
                    )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
