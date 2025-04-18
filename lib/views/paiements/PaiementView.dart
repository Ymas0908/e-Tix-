import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Paiementview extends StatefulWidget {
  final String paymentUrl;

  const Paiementview({Key? key, required this.paymentUrl}) : super(key: key);

  @override
  _PaiementviewState createState() => _PaiementviewState();
}

class _PaiementviewState extends State<Paiementview> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Paiement CinetPay")),
      body: WebViewWidget(controller: _controller),
    );
  }
}
