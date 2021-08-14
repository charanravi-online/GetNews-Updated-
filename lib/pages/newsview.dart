import 'dart:async';

import 'package:flutter/material.dart';
import 'package:getnews/pages/category.dart';
import 'package:getnews/pages/homepage.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsView extends StatefulWidget {
  String url;
  NewsView(this.url);
  @override
  _NewsViewState createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  late String finalUrl;
  final Completer<WebViewController> controller =
      Completer<WebViewController>();
  @override
  void initState() {
    if (widget.url.toString().contains("http://")) {
      finalUrl = widget.url.toString().replaceAll("http://", "https://");
    } else {
      finalUrl = widget.url;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff574b90),
        title: InkWell(
          child: Text('GetNews'),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () => share(finalUrl), icon: Icon(Icons.share))
        ],
      ),
      body: Container(
        child: WebView(
          initialUrl: finalUrl,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            setState(() {
              controller.complete(webViewController);
            });
          },
        ),
      ),
    );
  }
}
