import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import '../../views_model/notchpay_viewmodel.dart';

class PaiementView extends StatefulWidget {
  PaiementView({super.key});

  @override
  State<PaiementView> createState() => _PaiementViewState();
}

class _PaiementViewState extends State<PaiementView> {
  late FlutterSecureStorage storage;

  @override
  void initState() {
    super.initState();
    storage = const FlutterSecureStorage();
    // Tu peux ici faire un usage initial de storage si besoin,
    // par exemple lire une clé :
    // storage.read(key: 'some_key').then((value) => print(value));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NotchpayViewmodel>(
      builder: (context, notchpayViewmodel, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Effectuer un paiement"),
            backgroundColor: const Color(0xffD9AFA0),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: notchpayViewmodel.amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Montant",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: notchpayViewmodel.descriptionController,
                  decoration: const InputDecoration(
                    labelText: "Description",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await notchpayViewmodel.initierPaiement();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Paiement initié avec succès.")),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Erreur lors du paiement: $e")),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffD9AFA0),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Confirmer le paiement",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
