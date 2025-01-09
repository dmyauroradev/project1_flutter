import 'package:app_1/common/services/storage.dart';
import 'package:app_1/common/utils/kcolors.dart';
import 'package:app_1/common/utils/kstrings.dart';
import 'package:app_1/common/widgets/app_style.dart';
import 'package:app_1/common/widgets/reusable_text.dart';
import 'package:app_1/src/auth/views/login_screen.dart';
import 'package:app_1/src/chatbot/controllers/chatbot_notifier.dart';
import 'package:app_1/src/chatbot/widgets/chatbot_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatbotPage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // Lắng nghe thay đổi để cuộn xuống cuối khi có tin nhắn mới
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ChatbotNotifier>(context, listen: false).addListener(() {
        if (mounted) {
          _scrollToBottom();
        }
      });
    });
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      Provider.of<ChatbotNotifier>(context, listen: false).sendMessage(text);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString('accessToken');

    if (accessToken == null) {
      return const LoginPage();
    }
    final messages = context.watch<ChatbotNotifier>().messages;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: ReusableText(
            text: AppText.kChatbot,
            style: appStyle(16, Kolors.kPrimary, FontWeight.bold)),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<ChatbotNotifier>(
              builder: (context, chatbot, child) {
                if (chatbot.messages.isEmpty) {
                  return const Center(
                    child: Text(
                      "Bắt đầu trò chuyện thôi nàaao!^^",
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }

                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.only(bottom: 130.0),
                  itemCount: chatbot.messages.length,
                  itemBuilder: (context, index) {
                    final message = chatbot.messages[index];
                    final isUser = message["sender"] == "user";
                    //final message = messageData["message"]!;
                    return ChatMessage(
                      message: message["message"] ?? "",
                      isUser: isUser,
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 56.0),
            child: Container(
              padding: const EdgeInsets.all(6.0),
              //color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: "Nhập tin nhắn",
                        fillColor: const Color.fromARGB(
                            255, 237, 224, 224), // Màu nền xám nhạt
                        filled: true, // Bật nền
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none, // Bỏ viền
                        ), // Tăng độ bo góc của TextField
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 8.0, // Giảm chiều cao của TextField
                          horizontal: 18.0,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: _sendMessage,
                    /*onPressed: () {
                      if (_controller.text.isNotEmpty) {
                        context
                            .read<ChatbotNotifier>()
                            .sendMessage(_controller.text);
                        _controller.clear();
                      }
                    },*/
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
