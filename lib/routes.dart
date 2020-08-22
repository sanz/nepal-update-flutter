import 'package:flutter/material.dart';

import 'package:nepalupdate/views/home_view.dart';
import 'package:nepalupdate/views/no_internet_view.dart';
import 'package:nepalupdate/views/website_view.dart';
import 'package:nepalupdate/views/webview_view.dart';
import 'package:nepalupdate/views/websites_view.dart';

import 'package:nepalupdate/arguments/webview.dart';
import 'package:nepalupdate/arguments/websites.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeView());

      case '/website':
        return MaterialPageRoute(
          builder: (_) => WebsiteView(
            website: settings.arguments,
          ),
        );

      case '/websites':
        final WebsitesViewArugments args = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => WebsitesView(
            title: args.title,
            websites: args.websites,
          ),
        );

      case '/webview':
        final WebViewArguments args = settings.arguments;

        return MaterialPageRoute(
          builder: (_) => WebviewView(
            title: args.title,
            url: args.url,
            image: args.image,
          ),
        );

      case '/no_internet':
        return MaterialPageRoute(
          builder: (_) => NoInternetView(),
        );

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
