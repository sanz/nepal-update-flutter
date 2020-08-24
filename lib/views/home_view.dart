import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

import 'package:nepalupdate/constants.dart';
import 'package:nepalupdate/widgets/featured_items.dart';
import 'package:nepalupdate/search/websites.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  DioCacheManager cacheManager;
  Future<List<dynamic>> items;

  Future<List<dynamic>> fetchItems() async {
    cacheManager = DioCacheManager(CacheConfig());
    Options options = buildCacheOptions(Duration(days: 1));

    Dio dio = Dio();
    dio.interceptors.add(cacheManager.interceptor);
    Response response = await dio.get(API_HOME, options: options);

    return response.data;
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
            Function onSearchPressed = () {};

            if (snapshot.hasData) {
              onSearchPressed = () {
                List<dynamic> websites = List();

                snapshot.data.forEach(
                  (item) => websites.addAll(item['websites']),
                );

                showSearch(
                  context: context,
                  delegate: WebsiteSearch(websites),
                );
              };
            }

            return IconButton(
              icon: Icon(Icons.search),
              onPressed: onSearchPressed,
            );
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
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                var item = snapshot.data[index];
                return FeaturedItems(item);
              },
            );
          }

          print(snapshot.error);
          return buildRetry();
        },
      ),
    );
  }

  Center buildRetry() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Fetching contents failed! Please try again."),
          SizedBox(height: 10.0),
          OutlineButton(
            onPressed: () {
              setState(() {
                this.items = this.fetchItems();
              });
            },
            child: Text("Retry"),
          ),
        ],
      ),
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
