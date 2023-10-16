import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MyTextField extends StatefulWidget {
  final Color textColor;
  final bool? hasPrefixIcon;
  final bool? hasPass;
  final String? textHint;
  final String? errorText;
  final Function(String)? onChange;
  MyTextField(
      {Key? key,
      this.textHint,
      this.errorText,
      this.onChange,
      this.hasPass,
      this.textColor = Colors.white,
      this.hasPrefixIcon})
      : super(key: key);

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool checkPass = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          TextField(
            onChanged: widget.onChange,
            style: TextStyle(color: widget.textColor, fontSize: 17),
            obscureText: widget.hasPass != null ? !checkPass : checkPass,
            decoration: InputDecoration(
                prefixIcon:
                    widget.hasPrefixIcon != null ? Icon(Icons.search) : null,
                hintText: widget.textHint,
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
                    : null,
                hintStyle: const TextStyle(color: Colors.purple, fontSize: 18),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: widget.textColor),
                    borderRadius: BorderRadius.circular(20))),
          ),
          if (widget.errorText != null)
            Text(
              '${widget.errorText}',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255), fontSize: 15),
            )
        ],
      ),
    );
  }
}
