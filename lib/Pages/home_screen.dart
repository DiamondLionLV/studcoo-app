import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studcoo/Pages/chat_page/chat_page.dart';
import 'package:studcoo/Pages/home.dart';
import 'package:studcoo/Pages/profile_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadLastSelectedIndex();
  }

  void _onTabChange(int index) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('lastSelectedIndex', index);
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _loadLastSelectedIndex() async {
    final prefs = await SharedPreferences.getInstance();
    final index = prefs.getInt('lastSelectedIndex') ?? 0;
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const ChatPage(),
    const HomePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        color: const Color.fromARGB(255, 0, 0, 0),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
          child: GNav(
            haptic: true,
            backgroundColor: const Color.fromARGB(255, 0, 0, 0),
            color: const Color(0xffaa1578),
            activeColor: const Color(0xffaa1578),
            tabBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
            padding: const EdgeInsets.all(15),
            iconSize: 30,
            gap: 8,
            tabs: const [
              GButton(
                icon: Icons.chat_bubble_outline_sharp,
                text: 'Chat',
              ),
              GButton(
                icon: Icons.camera_alt_outlined,
                text: 'Scan',
              ),
              GButton(
                icon: Icons.people_outline_sharp,
                text: 'Profile',
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: _onTabChange,
          ),
        ),
      ),
    );
  }
}
