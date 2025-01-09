import 'dart:convert';
import 'package:app_1/src/products/controllers/product_notifier.dart';
import 'package:flutter/material.dart';
import 'package:app_1/src/products/views/product_screen.dart';
import 'package:provider/provider.dart';

String sanitizeMessage(String input) {
  if (input.isEmpty) return "Dữ liệu không hợp lệ";
  try {
    final sanitized = utf8.decode(utf8.encode(input), allowMalformed: true);
    return sanitized;
  } catch (e) {
    return "Dữ liệu không hợp lệ";
  }
}

class ChatMessage extends StatelessWidget {
  final String message;
  final bool isUser;

  const ChatMessage({
    required this.message,
    required this.isUser,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final idRegex = RegExp(r'(?:Product ID|ID là|Mã ID):\s*(\d+)');
    final sanitizedMessage = sanitizeMessage(message);
    final match = idRegex.firstMatch(sanitizedMessage);

    if (match != null) {
      final productId = match.group(1);
      debugPrint("ID trích xuất: $productId");
    } else {}

    if (match != null) {
      final productId = match.group(1)!;
      final beforeId = sanitizedMessage.substring(0, match.start);
      final afterId = sanitizedMessage.substring(match.end);

      return Align(
        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.66,
            ),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: isUser
                  ? const Color.fromARGB(255, 112, 58, 17)
                  : const Color.fromARGB(255, 212, 164, 141),
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(16),
                topRight: const Radius.circular(16),
                bottomLeft: isUser
                    ? const Radius.circular(16)
                    : const Radius.circular(0),
                bottomRight: isUser
                    ? const Radius.circular(0)
                    : const Radius.circular(16),
              ),
            ),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: beforeId,
                    style:
                        TextStyle(color: isUser ? Colors.white : Colors.black),
                  ),
                  WidgetSpan(
                    child: GestureDetector(
                      onTap: () async {
                        try {
                          if (productId.isNotEmpty) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ChangeNotifierProvider(
                                  create: (_) => ProductNotifier()
                                    ..fetchProduct(int.parse(productId)),
                                  child: ProductPage(productId: productId),
                                ),
                              ),
                            );
                          } else {
                            throw Exception("Product ID is empty.");
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Không thể chuyển sang trang sản phẩm: $e'),
                            ),
                          );
                        }
                      },
                      child: Text(
                        'Product ID: $productId',
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  TextSpan(
                    text: afterId,
                    style:
                        TextStyle(color: isUser ? Colors.white : Colors.black),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    // Nếu không có ID, hiển thị nội dung tin nhắn bình thường
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.66,
          ),
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: isUser
                ? const Color.fromARGB(255, 112, 58, 17)
                : const Color.fromARGB(255, 212, 164, 141),
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(16),
              topRight: const Radius.circular(16),
              bottomLeft:
                  isUser ? const Radius.circular(16) : const Radius.circular(0),
              bottomRight:
                  isUser ? const Radius.circular(0) : const Radius.circular(16),
            ),
          ),
          child: Text(
            message,
            style: TextStyle(color: isUser ? Colors.white : Colors.black),
          ),
        ),
      ),
    );
  }
}
