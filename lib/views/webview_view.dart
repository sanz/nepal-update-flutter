import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';

import 'package:nepalupdate/constants.dart';

class WebviewView extends StatefulWidget {
  final String url;
  final String title;
  final String image;

  WebviewView({
    Key key,
    @required this.url,
    @required this.title,
    this.image,
  }) : super(key: key);

  @override
  _WebviewViewState createState() => _WebviewViewState();
}

class _WebviewViewState extends State<WebviewView> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      // We're using a Builder here so we have a context that is below the Scaffold
      // to allow calling Scaffold.of(context) so we can show a snackbar.
      body: Builder(builder: (BuildContext context) {
        return Stack(
          children: <Widget>[
            mainWebView(context),
            isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Stack(),
          ],
        );
      }),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Image.network(
            this.widget.image,
            fit: BoxFit.contain,
            height: 32,
            width: 50,
          ),
          SizedBox(width: 8.0),
          Expanded(
            child: Text(
              this.widget.title,
              style: kHeaderStyle,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      iconTheme: new IconThemeData(
        color: Colors.black,
      ),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }

  WebView mainWebView(BuildContext context) {
    return WebView(
      initialUrl: this.widget.url,
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (WebViewController webViewController) {
        _controller.complete(webViewController);
      },
      // TODO(iskakaushik): Remove this when collection literals makes it to stable.
      // ignore: prefer_collection_literals
      javascriptChannels: <JavascriptChannel>[
        _toasterJavascriptChannel(context),
      ].toSet(),
      navigationDelegate: (NavigationRequest request) {
        if (request.url.startsWith('https://www.youtube.com/')) {
          print('blocking navigation to $request}');
          return NavigationDecision.prevent;
        }
        print('allowing navigation to $request');
        return NavigationDecision.navigate;
      },
      onPageStarted: (String url) {
        print('Page started loading: $url');
      },
      onPageFinished: (String url) {
        print('Page finished loading: $url');
        setState(() {
          isLoading = false;
        });
      },
      gestureNavigationEnabled: true,
    );
  }
}
