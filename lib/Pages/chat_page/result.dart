import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:studcoo/Pages/chat_page/constant.dart';
import 'package:studcoo/Pages/variables.dart';
import 'model.dart';

class ResultPage extends StatefulWidget {
  final String text;

  const ResultPage({super.key, required this.text});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

const backgroundColor = Colors.white;
const botBackgroundColor = Colors.white;

class _ResultPageState extends State<ResultPage> {
  final _textController = TextEditingController();
  final _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  late bool isLoading;
  late OpenAI openAI;

  InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;
  dynamic timesScanned;
  final user = FirebaseAuth.instance.currentUser!;
  DatabaseReference ref = FirebaseDatabase.instance.ref();

  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: "ca-app-pub-3940256099942544/4411468910",
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            _interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
            _interstitialAd!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            _numInterstitialLoadAttempts += 1;
            _interstitialAd = null;
            if (_numInterstitialLoadAttempts < 10) {
              _createInterstitialAd();
            }
          },
        ));
  }

  void _showInterstitialAd() {
    if (_interstitialAd == null) {
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        ad.dispose();
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        ad.dispose();
        _createInterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }

  @override
  void initState() {
    super.initState();
    isLoading = false;
    _createInterstitialAd();
    openAI = OpenAI.instance.build(
        token: apiSecretKey,
        baseOption: HttpSetup(
            receiveTimeout: const Duration(seconds: 50),
            connectTimeout: const Duration(seconds: 50)),
        isLogger: true);

    setState(() {
      _messages.addAll([
        ChatMessage(
          text: scannedText,
          chatMessageType: ChatMessageType.user,
        ),
      ]);
      _messages.addAll([
        ChatMessage(
          text: answer,
          chatMessageType: ChatMessageType.bot,
        ),
      ]);
    });
  }

  @override
  void dispose() {
    ///close stream complete text
    openAI.close();
    super.dispose();
  }

  Future generateResponse(String prompt) async {
    String input = texts + prompt;
    final request = ChatCompleteText(messages: [
      Map.of({"role": "user", "content": input})
    ], maxToken: 700, model: kChatGptTurbo0301Model);

    final uid = user.uid;
    final userEmail = user.email;

    ref.update({'users/$uid/email': userEmail});

    ref.update({
      'users/$uid/questions/$prompt': prompt,
    });

    final response = await openAI.onChatCompletion(request: request);
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
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            "assets/icons/back_icon.svg",
            width: 18,
            height: 18,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Color(0xffb31c6e),
        ),
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Answer",
            maxLines: 1,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xffb31c6e),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        backgroundColor: Colors.white,
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
        color: const Color.fromARGB(255, 241, 239, 239),
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
                _showInterstitialAd();
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
        style: const TextStyle(color: Color(0xffaa1578)),
        controller: _textController,
        decoration: const InputDecoration(
          fillColor: Color.fromARGB(255, 241, 239, 239),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(10),
            topRight: chatMessageType == ChatMessageType.bot
                ? const Radius.circular(10)
                : const Radius.circular(10),
            bottomLeft: const Radius.circular(10),
            bottomRight: chatMessageType == ChatMessageType.bot
                ? const Radius.circular(10)
                : const Radius.circular(10),
          ),
          gradient: chatMessageType == ChatMessageType.bot
              ? const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 241, 239, 239),
                    Color.fromARGB(255, 241, 239, 239),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : const LinearGradient(
                  colors: [
                    Color(0xffc22466),
                    Color(0xffaa1578),
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: chatMessageType == ChatMessageType.bot
                ? MainAxisAlignment.start
                : MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: chatMessageType == ChatMessageType.bot
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      child: Text(
                        text,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: chatMessageType == ChatMessageType.bot
                                ? const Color(0xffaa1578)
                                : Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
