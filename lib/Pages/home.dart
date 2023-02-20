import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:camera/camera.dart';
import 'package:studcoo/Pages/chat_page/chat_page.dart';
import 'package:studcoo/Pages/result_screen.dart';
import 'package:http/http.dart' as http;
import 'package:studcoo/Pages/chat_page/constant.dart';
import 'package:studcoo/Pages/variables.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  bool _isPermissionGranted = false;
  int _question = 0;
  bool flashState = false;

  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  late final Future<void> _future;
  CameraController? _cameraController;

  final textRecognizer = TextRecognizer();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _future = _requestCameraPermission();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _stopCamera();
    textRecognizer.close();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      _stopCamera();
    } else if (state == AppLifecycleState.resumed &&
        _cameraController != null &&
        _cameraController!.value.isInitialized) {
      _startCamera();
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
              FutureBuilder<List<CameraDescription>>(
                future: availableCameras(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    _initCameraController(snapshot.data!);

                    return Positioned(
                      top: 0,
                      bottom: 0,
                      child: CameraPreview(_cameraController!),
                    );
                  } else {
                    return const LinearProgressIndicator();
                  }
                },
              ),
            Scaffold(
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

  void _startCamera() {
    if (_cameraController != null) {
      _cameraSelected(_cameraController!.description);
    }
  }

  void _stopCamera() {
    if (_cameraController != null) {
      _cameraController?.dispose();
    }
  }

  void _initCameraController(List<CameraDescription> cameras) {
    if (_cameraController != null) {
      return;
    }

    // Select the first rear camera.
    CameraDescription? camera;
    for (var i = 0; i < cameras.length; i++) {
      final CameraDescription current = cameras[i];
      if (current.lensDirection == CameraLensDirection.back) {
        camera = current;
        break;
      }
    }

    if (camera != null) {
      _cameraSelected(camera);
    }
  }

  Future<void> _cameraSelected(CameraDescription camera) async {
    _cameraController = CameraController(
      camera,
      ResolutionPreset.max,
      enableAudio: false,
    );

    await _cameraController!.initialize();
    await _cameraController!.setFlashMode(FlashMode.off);

    if (!mounted) {
      return;
    }
    setState(() {});
  }

  Future<void> _scanImage() async {
    if (_cameraController == null) return;

    final navigator = Navigator.of(context);

    try {
      final pictureFile = await _cameraController!.takePicture();

      final file = File(pictureFile.path);

      final inputImage = InputImage.fromFile(file);
      final recognizedText = await textRecognizer.processImage(inputImage);
      const apiKey = apiSecretKey;
      inputText = recognizedText.text;

      var url = Uri.https("api.openai.com", "/v1/completions");
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey'
        },
        body: jsonEncode({
          "model": "text-davinci-003",
          "prompt": recognizedText.text,
          'temperature': 0.0,
          'max_tokens': 100,
          'top_p': 1.0,
          'frequency_penalty': 0.5,
          'presence_penalty': 0.0,
        }),
      );
      String utf8body = utf8.decode(response.bodyBytes);
      Map<String, dynamic> newresponse = jsonDecode(utf8body);

      final answer = newresponse['choices'][0]['text'];

      await navigator.push(
        MaterialPageRoute(
          builder: (BuildContext context) => ResultScreen(text: answer),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred when scanning text'),
        ),
      );
    }
  }
}