import 'package:chatapp/widget/message_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatWidget extends StatefulWidget {
  final String? apikey;
  const ChatWidget({super.key, required this.apikey});

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  late final GenerativeModel _model;
  late final ChatSession _chat;
  final ScrollController _scrollController = ScrollController();
  bool _loading = false;
  final TextEditingController _textController = TextEditingController();
  final FocusNode _textFieldFocus = FocusNode();
  final List<({Image? image, String text, bool fromuser})> _generatedContent =
      [];

  @override
  void initState() {
    _model = GenerativeModel(
        model: 'gemini-1.5-flash-latest', apiKey: widget.apikey ?? "");
    _chat = _model.startChat();
    super.initState();
  }

  void _scrolldown() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 750),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: widget.apikey?.isNotEmpty ?? false
              ? ListView.builder(
                  controller: _scrollController,
                  itemCount: _generatedContent.length,
                  itemBuilder: (context, index) {
                    final content = _generatedContent[index];
                    return MessageWidget(
                      isfromuser: content.fromuser,
                      text: content.text,
                      image: content
                          .image, // Pass directly without force unwrapping
                    );
                  },
                )
              : ListView(
                  children: const [
                    Text(
                      "No API key found. Please get it from Google AI Studio.",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  onSubmitted: _sendMessage,
                  autofocus: true,
                  focusNode: _textFieldFocus,
                  controller: _textController,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    hintText: widget.apikey?.isNotEmpty ?? false
                        ? "Type a message..."
                        : "Enter your API key to start chatting",
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: const BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  enabled: widget.apikey?.isNotEmpty ?? false,
                ),
              ),
              const SizedBox.square(
                dimension: 10,
              ),
              IconButton(
                onPressed: () {
                  // Pick the image
                },
                icon: const Icon(
                  Icons.image,
                  color: Colors.white24,
                ),
              ),
              if (!_loading)
                IconButton(
                  onPressed: () {
                    _sendMessage(_textController.text);
                  },
                  icon: const Icon(
                    Icons.send,
                    color: Colors.blue,
                    size: 40,
                  ),
                )
              else
                const CircularProgressIndicator(),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _sendMessage(String message) async {
    setState(() {
      _loading = true;
    });
    try {
      // Add user's message
      _generatedContent.add((image: null, text: message, fromuser: true));

      // Send message to Gemini
      final response = await _chat.sendMessage(Content.text(message));

      // Add Gemini's response
      final text = response.text ?? "No response from AI";
      _generatedContent.add((image: null, text: text, fromuser: false));

      setState(() {
        _loading = false;
        _scrolldown();
      });
    
      // Scroll to the bottom
    } catch (e) {
      showError(e.toString());
      setState(() {
        _loading = false;
      });
    } finally {
      _textController.clear();
      setState(() {
        _loading = false;
      });
      _textFieldFocus.requestFocus();
    }
  }

  Future<dynamic> showError(String message) {
    return showDialog(
      context: context,
      builder: (context) {
        return _showErrorMessage(message, context);
      },
    );
  }

  AlertDialog _showErrorMessage(String message, BuildContext context) {
    return AlertDialog(
      title: const Text("Something Went Wrong"),
      content: SingleChildScrollView(
        child: SelectableText(message),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("OK"),
        ),
      ],
    );
  }
}
