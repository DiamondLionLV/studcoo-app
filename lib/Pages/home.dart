import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scalable_ocr/flutter_scalable_ocr.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:camera/camera.dart';
import 'package:studcoo/Pages/result_screen.dart';
import 'package:studcoo/Pages/chat_page/constant.dart';
import 'package:studcoo/Pages/variables.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  bool _isPermissionGranted = false;
  bool flashState = false;
  String scannedText = "";

  late final Future<void> _future;
  CameraController? _cameraController;

  final textRecognizer = TextRecognizer();
  late OpenAI openAI;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _future = _requestCameraPermission();

    openAI = OpenAI.instance.build(
        token: apiSecretKey,
        baseOption: HttpSetup(
            receiveTimeout: const Duration(seconds: 50),
            connectTimeout: const Duration(seconds: 50)),
        isLogger: true);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    textRecognizer.close();
    openAI.close();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        return Stack(
          children: [
            if (_isPermissionGranted)
              ScalableOCR(
                  paintboxCustom: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 4.0
                    ..color = const Color(0xffaa1578),
                  boxLeftOff: 5,
                  boxBottomOff: 2.2,
                  boxRightOff: 5,
                  boxTopOff: 2.2,
                  boxHeight: MediaQuery.of(context).size.height, //n
                  // getRawData: (value) {
                  //   inspect(value);
                  // },
                  getScannedText: (value) {
                    scannedText = value;
                  }),
            Scaffold(
              appBar: AppBar(
                toolbarHeight: 28.5,
                shadowColor: Colors.transparent,
                iconTheme: const IconThemeData(
                  color: Colors.transparent,
                ),
                backgroundColor: Colors.black,
              ),
              backgroundColor: _isPermissionGranted
                  ? const Color.fromARGB(0, 247, 120, 251)
                  : null,
              body: _isPermissionGranted
                  ? Column(
                      children: [
                        Expanded(
                          child: Container(),
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IconButton(
                                  iconSize: 50,
                                  icon: const Icon(
                                      Icons.picture_in_picture_alt_outlined),
                                  color: Colors.white,
                                  onPressed: () {
                                    if (flashState == false) {
                                      _cameraController!
                                          .setFlashMode(FlashMode.torch);
                                      flashState = true;
                                    } else {
                                      _cameraController!
                                          .setFlashMode(FlashMode.off);
                                      flashState = false;
                                    }
                                  },
                                ),
                                Container(
                                  padding: const EdgeInsets.only(bottom: 50.0),
                                  child: Center(
                                    child: ElevatedButton(
                                      onPressed: _scanImage,
                                      style: ElevatedButton.styleFrom(
                                        fixedSize: const Size(70, 70),
                                        shape: const CircleBorder(),
                                        primary: const Color(0xffc22466),
                                        onPrimary: const Color(0xffaa1578),
                                        side: const BorderSide(
                                            color: Color(0xffaa1578), width: 5),
                                      ),
                                      child: const Text(' '),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  iconSize: 50,
                                  icon: const Icon(Icons.flash_on_sharp),
                                  color: Colors.white,
                                  onPressed: () {
                                    if (flashState == false) {
                                      _cameraController!
                                          .setFlashMode(FlashMode.torch);
                                      flashState = true;
                                    } else {
                                      _cameraController!
                                          .setFlashMode(FlashMode.off);
                                      flashState = false;
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    )
                  : Center(
                      child: Container(
                        padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                        child: const Text(
                          'Camera permission denied. Go to Settings and allow access to Camera.',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    _isPermissionGranted = status == PermissionStatus.granted;
  }

  Future<String?> _scanImage() async {
    final navigator = Navigator.of(context);

    try {
      inputText = scannedText;

      final request = ChatCompleteText(messages: [
        Map.of({"role": "user", "content": scannedText})
      ], maxToken: 700, model: kChatGptTurbo0301Model);

      final response = await openAI.onChatCompletion(request: request);
      var answer;
      for (var element in response!.choices) {
        answer = element.message.content;
        break;
      }

      await navigator.push(
        MaterialPageRoute(
          builder: (BuildContext context) => ResultScreen(text: answer),
        ),
      );

      return answer;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred when scanning text'),
        ),
      );
    }
  }
}
