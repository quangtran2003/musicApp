// ignore_for_file: unused_field

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart';

class MyTextField extends StatefulWidget {
  final Color? textColor;
  final bool? hasPrefixIcon;
  final bool? hasPass;
  final String? textHint;
  final String? errorText;
  final Function(String)? onChange;
  final VoidCallback? onEditingComplete;
  final bool? autoFocus;

  const MyTextField({
    Key? key,
    this.textHint,
    this.errorText,
    this.onChange,
    this.hasPass,
    this.textColor,
    this.hasPrefixIcon,
    this.onEditingComplete,
    this.autoFocus = false,
  }) : super(key: key);

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool checkPass = false;
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  bool _isListening = false;
  String _text = '';
  double _confidence = 1.0;
  String _lastWords = '';
  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    try {
      _speechEnabled = await _speechToText.initialize();
    } catch (e) {
      Get.snackbar('Thông báo', 'Có lỗi xảy ra, không thể nhận dạng giọng nói');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _listen() async {
    String temp = _text;
    if (!_isListening) {
      bool available = await _speechToText.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speechToText.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            _controller.text = _text;
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speechToText.stop();
    }

    Future.delayed(const Duration(seconds: 5), () {
      if (_controller.text == temp) {
        setState(() => _isListening = false);
        _speechToText.stop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          TextField(
            autofocus: widget.autoFocus ?? false,
            focusNode: _focusNode,
            controller: _controller,
            onEditingComplete: widget.onEditingComplete,
            onChanged: widget.onChange,
            style: TextStyle(color: widget.textColor, fontSize: 17),
            obscureText: widget.hasPass != null ? !checkPass : checkPass,
            decoration: InputDecoration(
                prefixIcon: widget.hasPrefixIcon != null
                    ? const Icon(Icons.search)
                    : null,
                hintText: widget.textHint,
                focusColor: Colors.purple,
                fillColor: const Color.fromARGB(255, 195, 75, 216),
                filled: false,
                suffixIcon: widget.hasPass != null
                    ? checkPass
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                checkPass = !checkPass;
                              });
                            },
                            icon: const Icon(Icons.visibility_outlined,
                                color: Colors.purple))
                        : IconButton(
                            onPressed: () {
                              setState(() {
                                checkPass = !checkPass;
                              });
                            },
                            icon: const Icon(
                              Icons.visibility_off_outlined,
                              color: Colors.purple,
                            ))
                    : Container(
                        padding: EdgeInsets.only(right: 20),
                        child: AvatarGlow(
                          repeat: true,
                          glowColor: Colors.purple,
                          duration: Duration(milliseconds: 2000),
                          animate: _isListening,
                          child: IconButton(
                              onPressed: () async {
                                _listen();
                              },
                              tooltip:
                                  'Listen', // stt.SpeechToText speech = stt.SpeechToText();
                              icon: Icon(_speechToText.isNotListening
                                  ? Icons.mic_off
                                  : Icons.mic)),
                        ),
                      ),
                hintStyle: TextStyle(
                    color: widget.textColor ?? Colors.purple, fontSize: 18),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
                border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: widget.textColor ?? Colors.purple),
                    borderRadius: BorderRadius.circular(20))),
          ),
          if (widget.errorText != null)
            Container(
              padding: const EdgeInsets.only(top: 5),
              alignment: Alignment.centerLeft,
              child: Text(
                '${widget.errorText}',
                style: const TextStyle(color: Colors.red, fontSize: 15),
              ),
            )
        ],
      ),
    );
  }
}
