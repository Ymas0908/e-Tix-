import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/views/pageacceuil.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    // var sharedState = context.read<SharedState>();
    // sharedState.initState();
    // var deviceInfos = sharedState.deviceData;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(seconds: 3), () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>  Pageacceuil()),
        );
        // Navigator.pushAndRemoveUntil(
        //   context,
        //   MaterialPageRoute(builder: (context) => const LoginScreen()),
        //   (route) => false,
        // );
        // var terminal = await sharedState.getTerminalByNumeroSerie(sharedState.deviceData['id'] ?? "");
        // if(terminal.id == null || terminal.statutTerminal == StatutTerminal.ACTIF){
        //   Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(builder: (context) => const OnboardingView()),
        //   );
        // }else {
        //   Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(builder: (context) =>  TerminalWarringView(terminalName: deviceData['model'],)),
        //   );
        // }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xffD9AFA0), Color(0xFF052A6E)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'e-Tix',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: const Divider(
                          color: Colors.white,
                          thickness: 3,
                        ),
                      ),
                      Text(
                        "Acheter les tickets de vos évènements \n en un clique !",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
