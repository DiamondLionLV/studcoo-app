import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:studcoo/Pages/home_screen.dart';
import 'package:studcoo/components/button.dart';

class ConfirmEmailPage extends StatefulWidget {
  // final Function()? onTap;
  // const LoginPage({super.key, required this.onTap});
  const ConfirmEmailPage({super.key});

  @override
  State<ConfirmEmailPage> createState() => _ConfirmEmailPageState();
}

class _ConfirmEmailPageState extends State<ConfirmEmailPage> {
  void redirectUser(context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomeScreen()));
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
            "Confirm your email",
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
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.width / 10),

                const Center(
                  child: Text(
                    "We sent you an email with a link that will confirm\nyour email address.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xffb31c6e),
                    ),
                  ),
                ),

                SizedBox(height: MediaQuery.of(context).size.width / 3),

                Image.network(
                  "https://cdn.discordapp.com/attachments/1084961612970074212/1084967151162626128/envelope_with_arrow_illustration.png",
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.width / 2,
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                ),

                // sign in button
                MyButton(
                  onTap: () => redirectUser(context),
                  text: 'Return to profile page',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
