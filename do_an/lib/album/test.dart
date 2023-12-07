import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

class Name extends StatefulWidget {
  Name({Key? key}) : super(key: key);

  final player = AudioPlayer();

  @override
  State<Name> createState() => _NameState();
}

class _NameState extends State<Name> {
  @override
  Widget build(BuildContext context) {
    Future<void> ok() async {
      widget.player.setAudioSource(
        AudioSource.uri(
          Uri.parse(
              "https://cdns-preview-a.dzcdn.net/stream/c-a8f59d5c41501a2a767a088d92946325-1.mp3"),
          tag: MediaItem(
            // Specify a unique ID for each media item:
            id: '1',
            // Metadata to display in the notification:
            album: "Album name",
            title: "Song name",
            artUri: Uri.parse(
                "https://i.ytimg.com/vi/qHnWFMx2X08/maxresdefault.jpg"),
          ),
        ),
      );

      // Play the audio
      await widget.player.play();
    }

    return Scaffold(
      body: Center(
        child: IconButton(
          onPressed: () {
            ok(); // Call the function directly without setState
            print('ok');
          },
          icon: const Icon(Icons.abc),
        ),
      ),
    );
  }
}
