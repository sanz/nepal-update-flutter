import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:nepalupdate/constants.dart';
import 'package:nepalupdate/widgets/featured_items.dart';
import 'package:nepalupdate/search/websites.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Future<List<dynamic>> items;

  Future<List<dynamic>> fetchItems() async {
    final response = await http.get(API_HOME);
    return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();
    this.items = fetchItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildContainer(context),
      drawer: buildDrawer(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text(
        'Nepal Update',
        style: kHeaderStyle,
      ),
      backgroundColor: Colors.white,
      iconTheme: new IconThemeData(
        color: Colors.black,
      ),
      actions: <Widget>[
        FutureBuilder<List<dynamic>>(
          future: this.items,
          builder: (context, snapshot) {
            var onSearchPressed = () {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("Contents are loading! Please wait..."),
              ));
            };

            if (snapshot.hasData) {
              onSearchPressed = () {
                List<dynamic> websites = List();

                snapshot.data
                    .forEach((item) => websites.addAll(item['websites']));

                showSearch(context: context, delegate: WebsiteSearch(websites));
              };
            }

            return IconButton(
                icon: Icon(Icons.search), onPressed: onSearchPressed);
          },
        ),
      ],
    );
  }

  Container buildContainer(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: FutureBuilder<List<dynamic>>(
        future: this.items,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return homeListItemBuilder(snapshot);
          }

          if (snapshot.hasError) {
            if (snapshot.error is IOException) {
              Navigator.of(context).pushNamed('/no_internet');
            }

            print(snapshot.error);
            return Text("Something went wrong.");
          }

          // By default, show a loading spinner.
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  ListView homeListItemBuilder(AsyncSnapshot<List> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data.length,
      itemBuilder: (context, index) {
        var item = snapshot.data[index];
        return FeaturedItems(item);
      },
    );
  }

  Drawer buildDrawer() {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Nepal Update',
              style: kDrawerkHeaderStyle,
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                image: AssetImage(kDrawerImageSource),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text(
              'Share',
              style: kNonActiveTabStyle,
            ),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: Icon(Icons.star),
            title: Text(
              'Rate us',
              style: kNonActiveTabStyle,
            ),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
        ],
      ),
    );
  }
}
