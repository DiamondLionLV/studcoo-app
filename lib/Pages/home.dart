import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scalable_ocr/flutter_scalable_ocr.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:camera/camera.dart';
import 'package:studcoo/Pages/chat_page/result.dart';
import 'package:studcoo/Pages/chat_page/constant.dart';
import 'package:studcoo/Pages/variables.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  bool _isPermissionGranted = false;
  bool flashState = false;
  //String scannedText = "";

  InterstitialAd? _interstitialAd;

  late final Future<void> _future;
  CameraController? _cameraController;

  final textRecognizer = TextRecognizer();
  late OpenAI openAI;
  int _numInterstitialLoadAttempts = 0;

  final user = FirebaseAuth.instance.currentUser!;
  DatabaseReference ref = FirebaseDatabase.instance.ref();

  void saveData() async {
    final uid = user.uid;
    int timesScanned = 0;

    DataSnapshot snapshot = await ref.child('users/$uid/timesScanned').get();
    if (snapshot.value != null) {
      timesScanned = snapshot.value as int;
    }

    timesScanned++;
    final userEmail = user.email;

    ref.update({
      'users/$uid/email': userEmail,
      'users/$uid/timesScanned': timesScanned,
      'users/$uid/questions/$scannedText': scannedText,
    });
  }

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
    WidgetsBinding.instance.addObserver(this);
    _createInterstitialAd();

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
                                // IconButton(
                                //   iconSize: 50,
                                //   icon: const Icon(
                                //       Icons.picture_in_picture_alt_outlined),
                                //   color: Colors.white,
                                //   onPressed: () {
                                //     if (flashState == false) {
                                //       _cameraController!
                                //           .setFlashMode(FlashMode.torch);
                                //       setState(() {
                                //         flashState = true;
                                //       });
                                //     } else {
                                //       _cameraController!
                                //           .setFlashMode(FlashMode.off);
                                //       setState(() {
                                //         flashState = false;
                                //       });
                                //     }
                                //   },
                                // ),
                                GestureDetector(
                                  onTap: () => _scanImage(),
                                  child: Container(
                                    padding:
                                        const EdgeInsets.only(bottom: 50.0),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        "assets/icons/scan_button.svg",
                                        width:
                                            MediaQuery.of(context).size.height /
                                                10,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                10,
                                      ),
                                    ),
                                  ),
                                ),
                                // IconButton(
                                //   iconSize: 50,
                                //   icon: const Icon(Icons.flash_on_sharp),
                                //   color: Colors.white,
                                //   onPressed: () {
                                //     if (flashState == false) {
                                //       _cameraController!
                                //           .setFlashMode(FlashMode.torch);
                                //       flashState = true;
                                //     } else {
                                //       _cameraController!
                                //           .setFlashMode(FlashMode.off);
                                //       flashState = false;
                                //     }
                                //   },
                                // ),
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

  Future<void> _scanImage() async {
    final navigator = Navigator.of(context);

    try {
      inputText = texts + scannedText;

      // Show the loading dialog
      showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xffb31c6e),
            ),
          );
        },
      );

      //String answer = '';

      final request = ChatCompleteText(messages: [
        Map.of({"role": "user", "content": inputText})
      ], maxToken: 210, model: kChatGptTurbo0301Model);

      final response = await openAI.onChatCompletion(request: request);
      for (var element in response!.choices) {
        answer = element.message.content;
        textScanned = true;

        break;
      }

      saveData();

      // Hide the loading dialog
      Navigator.pop(context);

      // Show the interstitial ad
      _showInterstitialAd();

      await navigator.push(
        MaterialPageRoute(
          builder: (BuildContext context) => ResultPage(text: answer),
        ),
      );
    } catch (e) {
      // Hide the loading dialog
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred when scanning text'),
        ),
      );
    }
  }
}
