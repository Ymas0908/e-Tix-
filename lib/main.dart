import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_app/views/internet_not_available.dart';
import 'package:my_app/views/login/login.dart';
import 'package:my_app/views/pageacceuil.dart';
import 'package:my_app/views/signup/signup.dart';
import 'package:my_app/views_model/network_status_view_model.dart';
import 'package:my_app/web_services/implementations/EvenementImpl.dart';
import '../../views_model/evenement_viewmodel.dart';
import '../views/home/home.dart';

import 'package:provider/provider.dart';

import 'firebase_options.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<EvenementViewModel>(
          create: (context) => EvenementViewModel(
            evenementService: Evenementimpl(),
          ),
        ),
        ChangeNotifierProvider<NetworkStatusViewModel>(
          create: (context) => NetworkStatusViewModel(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home()
    );
  }
}
