import 'dart:convert';

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:studcoo/Pages/chat_page/constant.dart';
import 'model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ChatPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

const backgroundColor = Colors.white;
const botBackgroundColor = Colors.white;

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

// Future<String> generateResponse(String prompt) async {
//   const apiKey = apiSecretKey;

//   var url = Uri.https("api.openai.com", "/v1/completions");
//   final response = await http.post(
//     url,
//     headers: {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer $apiKey'
//     },
//     body: jsonEncode({
//       "model": "text-davinci-003",
//       "prompt": prompt,
//       'temperature': 0.5,
//       'max_tokens': 700,
//       'top_p': 1.0,
//       'frequency_penalty': 0.5,
//       'presence_penalty': 0.0,
//     }),
//   );

//   // Do something with the response
//   String utf8body = utf8.decode(response.bodyBytes);
//   Map<String, dynamic> newresponse = jsonDecode(utf8body);
//   return newresponse['choices'][0]['text'];
// }

class _ChatPageState extends State<ChatPage> {
  final _textController = TextEditingController();
  final _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  late bool isLoading;
  late OpenAI openAI;

  @override
  void initState() {
    super.initState();
    isLoading = false;
    openAI = OpenAI.instance.build(
        token: apiSecretKey,
        baseOption: HttpSetup(
            receiveTimeout: const Duration(seconds: 50),
            connectTimeout: const Duration(seconds: 50)),
        isLogger: true);
  }

  @override
  void dispose() {
    ///close stream complete text
    openAI.close();
    super.dispose();
  }

  Future generateResponse(String prompt) async {
    final request = ChatCompleteText(messages: [
      Map.of({"role": "user", "content": prompt})
    ], maxToken: 700, model: kChatGptTurbo0301Model);

    final response = await openAI.onChatCompletion(request: request!);
    for (var element in response!.choices) {
      //print("data -> ${element.message.content}");
      return element.message.content;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        shadowColor: Colors.transparent,
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Chat",
            maxLines: 1,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Color(0xffaa1578),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: botBackgroundColor,
      ),
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _buildList(),
            ),
            Visibility(
              visible: isLoading,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(
                  color: Color(0xffaa1578),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  _buildInput(),
                  _buildSubmit(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmit() {
    return Visibility(
      visible: !isLoading,
      child: Container(
        color: Color.fromARGB(255, 216, 216, 216),
        child: IconButton(
          icon: const Icon(
            Icons.send_rounded,
            color: Color(0xffaa1578),
          ),
          onPressed: () async {
            setState(
              () {
                _messages.add(
                  ChatMessage(
                    text: _textController.text,
                    chatMessageType: ChatMessageType.user,
                  ),
                );
                isLoading = true;
              },
            );
            var input = _textController.text;
            _textController.clear();
            Future.delayed(const Duration(milliseconds: 50))
                .then((_) => _scrollDown());
            generateResponse(input).then((value) {
              setState(() {
                isLoading = false;
                _messages.add(
                  ChatMessage(
                    text: value,
                    chatMessageType: ChatMessageType.bot,
                  ),
                );
              });
            });
            _textController.clear();
            Future.delayed(const Duration(milliseconds: 50))
                .then((_) => _scrollDown());
          },
        ),
      ),
    );
  }

  Expanded _buildInput() {
    return Expanded(
      child: TextField(
        textCapitalization: TextCapitalization.sentences,
        style: const TextStyle(color: Colors.white),
        controller: _textController,
        decoration: const InputDecoration(
          fillColor: Color.fromARGB(255, 216, 216, 216),
          filled: true,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    );
  }

  ListView _buildList() {
    return ListView.builder(
      controller: _scrollController,
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        var message = _messages[index];
        return ChatMessageWidget(
          text: message.text,
          chatMessageType: message.chatMessageType,
        );
      },
    );
  }

  void _scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}

class ChatMessageWidget extends StatelessWidget {
  const ChatMessageWidget(
      {super.key, required this.text, required this.chatMessageType});

  final String text;
  final ChatMessageType chatMessageType;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.all(16),
      color: chatMessageType == ChatMessageType.bot
          ? Color.fromARGB(255, 216, 216, 216)
          : Color.fromARGB(255, 170, 21, 120),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          chatMessageType == ChatMessageType.bot
              ? Container(
                  margin: const EdgeInsets.only(right: 16.0),
                  child: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 9, 58, 113),
                    child: Image.asset(
                      'assets/avatar.png',
                      scale: 1.5,
                    ),
                  ),
                )
              : Container(
                  margin: const EdgeInsets.only(right: 16.0),
                  child: const CircleAvatar(
                    child: Icon(
                      Icons.person,
                    ),
                  ),
                ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: Text(
                    text,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
