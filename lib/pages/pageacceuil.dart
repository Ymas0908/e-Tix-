import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login/login.dart';

class Pageacceuil extends StatefulWidget {
  const Pageacceuil({Key? key}) : super(key: key);

  @override
  _PageacceuilState createState() => _PageacceuilState();
}

class _PageacceuilState extends State<Pageacceuil> {
  final PageController _pageController = PageController();
  final List<String> images = [
    'assets/images/image1.jpeg',
    'assets/images/image2.jpeg',
    'assets/images/image3.jpeg',
  ];
  int currentPage = 0;
  Timer? _pageTimer;
  Timer? _userInteractionTimer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _pageTimer?.cancel();
    _userInteractionTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _pageTimer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (currentPage < images.length - 1) {
        currentPage++;
      } else {
        currentPage = 0;
      }
      _pageController.animateToPage(
        currentPage,
        duration: const Duration(seconds: 2
        ),
        curve: Curves.easeInOut,
      );
    });
  }

  void _resetAutoScroll() {
    _pageTimer?.cancel();
    _startAutoScroll();
  }

  void _onPageChanged(int page) {
    setState(() {
      currentPage = page;
    });
    _resetAutoScroll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: PageView(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              children: images.map((image) {
                return Image.asset(
                  image,
                  fit: BoxFit.cover,
                );
              }).toList(),
            ),
          ),
          // Ajouter les boutons de connexion et inscription
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 500,
                  ),
                  _signin(context),
                  const SizedBox(
                    height: 51,
                  ),
                  // _signup(context)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _startUserInteractionTimer() {
    _userInteractionTimer?.cancel();
    _userInteractionTimer = Timer(const Duration(seconds: 5), () {
      _resetAutoScroll();
    });
  }

  Widget _signin(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff0D6EFD),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        minimumSize: const Size(double.infinity, 60),
        elevation: 0,
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const Login(),
          ),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.login,
            color: Colors.white,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            "Connexion",
            style: GoogleFonts.raleway(
              textStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

// Widget _signup(BuildContext context) {
//   return ElevatedButton(
//     style: ElevatedButton.styleFrom(
//       backgroundColor: const Color(0xff0D6EFD),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(14),
//       ),
//       minimumSize: const Size(double.infinity, 60),
//       elevation: 0,
//     ),
//     onPressed: () {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (BuildContext context) => const Signup(),
//         ),
//       );
//     },
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         const Icon(
//           Icons.login,
//           color: Colors.white,
//         ),
//         const SizedBox(
//           width: 10,
//         ),
//         Text(
//           "Inscription",
//           style: GoogleFonts.raleway(
//             textStyle: const TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.normal,
//               fontSize: 16,
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }
}
