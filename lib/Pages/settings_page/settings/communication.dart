import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommunicationPage extends StatefulWidget {
  const CommunicationPage({super.key});

  @override
  State<CommunicationPage> createState() => _CommunicationPageState();
}

class _CommunicationPageState extends State<CommunicationPage> {
  bool? value = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
            "Communication preferences",
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
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.width / 10),
          const Text(
            "We occasionally send you the latest product news &\npromotional offers. In order to benefit, tick the box\nbelow. If you don't wish to recieve any newsletters or\noffers please untick this box. You can always adjust\nyour preference here.",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color(0xffb31c6e), fontWeight: FontWeight.w600),
          ),
          SizedBox(height: MediaQuery.of(context).size.width / 10),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "I want to recieve Studcoo news & offers",
                    style: TextStyle(
                      color: Color(0xffb31c6e),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Checkbox(
                    value: value,
                    onChanged: (bool? value) {
                      setState(
                        () {
                          this.value = value;
                        },
                      );
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    activeColor: const Color(0xffb31c6e),
                    checkColor: Colors.white,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
