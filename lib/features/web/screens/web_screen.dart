import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  final initialUrl = 'https://vortal.unicesar.edu.co/unicesar/hermesoft/vortal/iniciarSesion.jsp';
  late final InAppWebViewController webViewController;

  @override
  void dispose() {
    webViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Vortal',
          style: TextStyle(
              color: Colors.black
          ),
        ),
        backgroundColor: Color(0xFFF0F0F0),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.blue,),
          onPressed: () async {
            if (context.mounted) {
              Navigator.of(context).pop();
            }
          },
        ),
      ),
      body: Container(
        color: Colors.white,
        child: InAppWebView(
          initialUrlRequest: URLRequest(
            url: WebUri(initialUrl),
          ),
          initialSettings: InAppWebViewSettings(
            useHybridComposition: true,
            disableDefaultErrorPage: true,
            hardwareAcceleration: false,
            userAgent: "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36",
            preferredContentMode: UserPreferredContentMode.DESKTOP,
          ),
          onWebViewCreated: (controller) {
            webViewController = controller;
          },
          onLoadStop: (controller, url) async {
            await controller.evaluateJavascript(
              source: "document.body.style.zoom = '1.0';",
            );
          },
        ),
      ),
    );
  }
}