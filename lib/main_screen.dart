import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late InAppWebViewController webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('메인 화면'),
        automaticallyImplyLeading: false, //뒤로 가기 버튼 제거
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
            url: Uri.parse('https://www.example.com')), // 표시할 URL을 입력합니다.
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            javaScriptEnabled: true,
          ),
        ),
        onWebViewCreated: (InAppWebViewController controller) {
          webViewController = controller;
        },
      ),
    );
  }
}
