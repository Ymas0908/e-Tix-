
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';
import 'package:my_app/views/splash_view.dart';
import 'package:my_app/views_model/authentification_viewmodel.dart';
import 'package:my_app/views_model/evenement_viewmodel.dart';
import 'package:my_app/views_model/network_status_view_model.dart';
import 'package:my_app/web_services/implementations/EvenementImpl.dart';
import 'package:my_app/web_services/implementations/Ticket_Impl.dart';
import 'package:my_app/web_services/services/auth_service.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          final model = NetworkStatusViewModel();
          model.initialize();
          return model;
        }),

        ChangeNotifierProvider<EvenementViewModel>(
          create: (context) => EvenementViewModel(
            evenementService: Evenementimpl(),
            ticketService: TicketImpl(),
          ),
        ),
        ChangeNotifierProvider<NetworkStatusViewModel>(
          create: (context) => NetworkStatusViewModel(),
        ),
        ChangeNotifierProvider<AuthViewModel>(
          create: (context) => AuthViewModel(
            authService: AuthService(),
          ),
        ),

        // ChangeNotifierProvider(
        // create: (_) => Dashboardviewmodel(),
        // ),
      ],
      child: SkeletonTheme(
        // themeMode: ThemeMode.light,
        shimmerGradient: LinearGradient(
          colors: [
            Color(0xFFD8E3E7),
            Color(0xFFC8D5DA),
            Color(0xFFD8E3E7),
          ],
          stops: [
            0.1,
            0.5,
            0.9,
          ],
        ),
        // themeMode: ThemeMode.dark,
        darkShimmerGradient: LinearGradient(
          colors: [
            Color(0xFF222222),
            Color(0xFF242424),
            Color(0xFF2B2B2B),
            Color(0xFF242424),
            Color(0xFF222222),
          ],
          stops: [
            0.0,
            0.2,
            0.5,
            0.8,
            1,
          ],
          begin: Alignment(-2.4, -0.2),
          end: Alignment(2.4, 0.2),
          tileMode: TileMode.clamp,
        ), child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashView(),
        ),
      ),
    );
  }
}
