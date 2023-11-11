import 'package:chat_app/models/message.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.content, required this.isSender});

  // const ChatBubble (Key? key,this.content) : super(key: key);
  final Message content;
  final bool isSender;
  @override
  Widget build(BuildContext context) {
    return isSender
        ? Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              margin:
                  const EdgeInsets.only(left: 85, right: 16, top: 8, bottom: 8),
              decoration: const BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  )),
              child: Text(
                content.text,
                style: const TextStyle(color: kSecondryColor, fontSize: 16),
              ),
            ),
          )
        : Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              margin:
                  const EdgeInsets.only(left: 16, right: 85, top: 8, bottom: 8),
              // margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: const BoxDecoration(
                  color: Color(0xff006d84),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  )),
              child: Text(
                content.text,
                style: const TextStyle(color: kSecondryColor, fontSize: 16),
              ),
            ),
          );
  }
}
