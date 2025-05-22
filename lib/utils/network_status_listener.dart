import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../views/internet_not_available.dart';
import '../views_model/network_status_view_model.dart';


class NetworkStatusListener extends StatefulWidget {
  final Widget child;

  const NetworkStatusListener({super.key, required this.child});

  @override
  State<NetworkStatusListener> createState() => _NetworkStatusListenerState();
}

class _NetworkStatusListenerState extends State<NetworkStatusListener> {
  bool? _lastConnectionStatus;

  @override
  Widget build(BuildContext context) {
    return Consumer<NetworkStatusViewModel>(
      builder: (context, viewModel, _) {
        final isConnected = viewModel.isConnected;

        // On détecte un changement de statut
        if (_lastConnectionStatus != null &&
            _lastConnectionStatus != isConnected) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final messenger = ScaffoldMessenger.of(context);

            if (!isConnected) {
              // Affiche un message de perte de connexion
              messenger.showSnackBar(
                const SnackBar(
                  content: Text("Connexion Internet perdue"),
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 3),
                ),
              );
            } else {
              //Cacher le message précedent
              messenger.hideCurrentSnackBar();
              // Affiche un message de restauration de la connexion
              messenger.showSnackBar(
                const SnackBar(
                  content: Text("Connexion restaurée"),
                  backgroundColor: Colors.green,
                  duration: Duration(seconds: 3),
                ),
              );
            }
          });
        }

        _lastConnectionStatus = isConnected;

        // Affiche la bonne vue si la connexion est active. Sinon, afficher une vue pour l'erreur.
        return isConnected ? widget.child : const InternetNotAvailableView();
      },
    );
  }
}
