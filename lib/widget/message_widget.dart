import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MessageWidget extends StatelessWidget {
  final String? text;
  final bool isfromuser;
  final Image? image;

  const MessageWidget({
    super.key,
    required this.isfromuser,
    required this.text,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isfromuser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: IntrinsicWidth(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 300),
              decoration: BoxDecoration(
                color: isfromuser ? Colors.greenAccent : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(18),
                  topRight: const Radius.circular(18),
                  bottomLeft: isfromuser ? const Radius.circular(18) : Radius.zero,
                  bottomRight: isfromuser ? Radius.zero : const Radius.circular(18),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (text != null)
                    MarkdownBody(
                      data: text!,
                      styleSheet: MarkdownStyleSheet(
                        p: const TextStyle(color: Colors.black), 
                      ),
                    ),
                  if (image != null) image!,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
