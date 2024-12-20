// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class ChatInterface extends StatefulWidget {
//   const ChatInterface({super.key});

//   @override
//   State<ChatInterface> createState() => _ChatInterfaceState();
// }

// class _ChatInterfaceState extends State<ChatInterface> {
//   final TextEditingController _messageController = TextEditingController();
//   final List<ChatMessage> _messages = [];
//   bool _isTyping = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Center(
//           child: const Text(
//             'TutorAI Chat',
//             style: TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//         backgroundColor: // Color.fromARGB(255, 107, 70, 54), // -- original
//             Color.fromARGB(255, 28, 56, 121), // -- navy blue
//         // Color.fromARGB(255, 0, 105, 92), // -- teal
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               reverse: true, // Makes chat scroll from bottom
//               itemCount: _messages.length,
//               itemBuilder: (context, index) {
//                 return _messages[index];
//               },
//             ),
//           ),
//           if (_isTyping)
//             const Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Text('AI is typing...'),
//             ),
//           SafeArea(
//             child: Container(
//               margin: EdgeInsets.only(bottom: 16.0),
//               padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 border: Border(
//                   top: BorderSide(color: Colors.grey[200]!),
//                 ),
//               ),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Container(
//                       margin: const EdgeInsets.symmetric(horizontal: 8.0),
//                       child: TextField(
//                         controller: _messageController,
//                         decoration: const InputDecoration(
//                           hintText: 'Type a message...',
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.all(
//                               Radius.circular(20),
//                             ),
//                           ),
//                           contentPadding:
//                               EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                         ),
//                         onSubmitted: (_) => _sendMessage(),
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.send),
//                     onPressed: _sendMessage,
//                     padding: EdgeInsets.all(12),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _sendMessage() async {
//     if (_messageController.text.trim().isEmpty) return;

//     // Add user message to chat
//     setState(() {
//       _messages.insert(
//         0,
//         ChatMessage(
//           text: _messageController.text,
//           isUser: true,
//         ),
//       );
//       _isTyping = true;
//     });

//     final userMessage = _messageController.text;
//     _messageController.clear();

//     // Make API call
//     try {
//       final response = await _callAPI(userMessage);

//       setState(() {
//         _isTyping = false;
//         _messages.insert(
//           0,
//           ChatMessage(
//             text: response,
//             isUser: false,
//           ),
//         );
//       });
//     } catch (e) {
//       setState(() {
//         _isTyping = false;
//         _messages.insert(
//           0,
//           ChatMessage(
//             text: "Sorry, I couldn't process that message.",
//             isUser: false,
//           ),
//         );
//       });
//     }
//   }

//   Future<String> _callAPI(String message) async {
//     // Replace with your API endpoint
//     const String apiUrl = 'YOUR_API_ENDPOINT';

//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: {
//           'Content-Type': 'application/json',
//           // Add any necessary API keys or authentication headers
//         },
//         body: jsonEncode({
//           'message': message,
//         }),
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         return data['response'] ?? 'No response from API';
//       } else {
//         throw Exception('Failed to get AI response');
//       }
//     } catch (e) {
//       throw Exception('Error calling API: $e');
//     }
//   }

//   @override
//   void dispose() {
//     _messageController.dispose();
//     super.dispose();
//   }
// }

// class ChatMessage extends StatelessWidget {
//   final String text;
//   final bool isUser;

//   const ChatMessage({
//     super.key,
//     required this.text,
//     required this.isUser,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: Row(
//         mainAxisAlignment:
//             isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
//         children: [
//           Container(
//             constraints: BoxConstraints(
//               maxWidth: MediaQuery.of(context).size.width * 0.7,
//             ),
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//             decoration: BoxDecoration(
//               color: isUser
//                   // ? const Color.fromARGB(255, 242, 183, 150) // -- original
//                   // ? const Color.fromARGB(255, 179, 229, 252) // -- light blue
//                   // ? const Color.fromARGB(255, 179, 229, 252) // -- mint
//                   ? const Color.fromARGB(255, 187, 196, 255) // -- softer periwinkle
//                   : const Color(0xFFE8E8E8), // -- original
//               // : const Color.fromARGB(255, 245, 243, 240), // -- warmer gray
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Text(
//               text,
//               style: const TextStyle(fontSize: 18),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatInterface extends StatefulWidget {
  const ChatInterface({super.key});

  @override
  State<ChatInterface> createState() => _ChatInterfaceState();
}

class _ChatInterfaceState extends State<ChatInterface> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];
  bool _isTyping = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            'TutorAI Chat',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 28, 56, 121),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _messages[index];
              },
            ),
          ),
          if (_isTyping)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('AI is typing...'),
            ),
          SafeArea(
            child: Container(
              margin: EdgeInsets.only(bottom: 16.0),
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Colors.grey[200]!),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextField(
                        controller: _messageController,
                        decoration: const InputDecoration(
                          hintText: 'Type a message...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        ),
                        onSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: _sendMessage,
                    padding: EdgeInsets.all(12),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() async {
    if (_messageController.text.trim().isEmpty) return;

    // Add user message to chat
    setState(() {
      _messages.insert(
        0,
        ChatMessage(
          text: _messageController.text,
          isUser: true,
        ),
      );
      _isTyping = true;
    });

    final userMessage = _messageController.text;
    _messageController.clear();

    // Make API call
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/chat'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'message': userMessage}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _isTyping = false;
          _messages.insert(
            0,
            ChatMessage(
              text: data['Answer'],
              isUser: false,
              metadata: {
                'Grade': data['Grade'],
                'Subject': data['Subject'],
                'Chapter': data['Chapter'],
              },
            ),
          );
        });
      } else {
        setState(() {
          _isTyping = false;
          _messages.insert(
            0,
            ChatMessage(
              text: "Sorry, I couldn't process that message.",
              isUser: false,
            ),
          );
        });
      }
    } catch (e) {
      setState(() {
        _isTyping = false;
        _messages.insert(
          0,
          ChatMessage(
            text: "Sorry, I couldn't process that message.",
            isUser: false,
          ),
        );
      });
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}

class ChatMessage extends StatefulWidget {
  final String text;
  final bool isUser;
  final Map<String, dynamic>? metadata;

  const ChatMessage({
    super.key,
    required this.text,
    required this.isUser,
    this.metadata,
  });

  @override
  State<ChatMessage> createState() => _ChatMessageState();
}

class _ChatMessageState extends State<ChatMessage> {
  bool _isFlipped = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment:
            widget.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: widget.isUser
                  ? const Color.fromARGB(255, 187, 196, 255)
                  : const Color(0xFFE8E8E8),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _isFlipped && widget.metadata != null
                      ? 'From Grade ${widget.metadata!['Grade']} ${widget.metadata!['Subject']}\nChapter ${widget.metadata!['Chapter']}'
                      : widget.text,
                  style: const TextStyle(fontSize: 16),
                ),
                if (widget.metadata != null && !widget.isUser) ...[
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isFlipped = !_isFlipped;
                      });
                    },
                    child: Text(
                      _isFlipped ? "Return to Message" : "View Source",
                      style: TextStyle(
                        color: Color.fromARGB(255, 103, 58, 183),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}