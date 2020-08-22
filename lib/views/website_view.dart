import 'dart:io';
import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter_paginator/flutter_paginator.dart';

import 'package:nepalupdate/constants.dart';
import 'package:nepalupdate/widgets/post_card.dart';

class WebsiteView extends StatefulWidget {
  final website;

  WebsiteView({
    Key key,
    @required this.website,
  }) : super(key: key);

  @override
  _WebsiteViewState createState() => _WebsiteViewState();
}

class _WebsiteViewState extends State<WebsiteView> {
  GlobalKey<PaginatorState> paginatorGlobalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Paginator.listView(
        key: paginatorGlobalKey,
        pageLoadFuture: sendPostsDataRequest,
        pageItemsGetter: listItemsGetter,
        listItemBuilder: listItemBuilder,
        loadingWidgetBuilder: loadingWidgetMaker,
        errorWidgetBuilder: errorWidgetMaker,
        emptyListWidgetBuilder: emptyListWidgetMaker,
        totalItemsGetter: totalPagesGetter,
        pageErrorChecker: pageErrorChecker,
        scrollPhysics: BouncingScrollPhysics(),
      ),
    );
  }

  Future<PostsData> sendPostsDataRequest(int page) async {
    try {
      String url = getPostsUrl(page);
      http.Response response = await http.get(url);
      return PostsData.fromResponse(response);
    } catch (e) {
      if (e is IOException) {
        return PostsData.withError('Please check your internet connection.');
      } else {
        print(e.toString());
        return PostsData.withError('Fetching posts failed! Please try again.');
      }
    }
  }

  String getPostsUrl(int page) {
    String id = widget.website['id'].toString();
    return Uri.encodeFull('$API_WEBSITE$id?page=$page');
  }

  List<dynamic> listItemsGetter(PostsData postsData) {
    return postsData.posts;
  }

  Widget listItemBuilder(post, int index) {
    return PostCard(post);
  }

  Widget loadingWidgetMaker() {
    return Container(
      alignment: Alignment.center,
      height: 160.0,
      child: CircularProgressIndicator(),
    );
  }

  Widget errorWidgetMaker(PostsData postsData, retryListener) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(postsData.errorMessage),
        ),
        FlatButton(
          onPressed: retryListener,
          child: Text('Retry'),
        )
      ],
    );
  }

  Widget emptyListWidgetMaker(PostsData postsData) {
    return Center(
      child: Text('No posts available'),
    );
  }

  int totalPagesGetter(PostsData postsData) {
    return postsData.total;
  }

  bool pageErrorChecker(PostsData postsData) {
    return postsData.statusCode != 200;
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: widget.website['image'],
            imageBuilder: (context, imageProvider) => Image(
              image: imageProvider,
              fit: BoxFit.contain,
              height: 32,
              width: 50,
            ),
          ),
          SizedBox(width: 8.0),
          Expanded(
            child: Text(
              widget.website['title'],
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
}

class PostsData {
  List<dynamic> posts;

  int statusCode;
  String errorMessage;
  int total;
  int nItems;

  PostsData.fromResponse(http.Response response) {
    this.statusCode = response.statusCode;
    Map<String, dynamic> data = json.decode(response.body);

    this.posts = data['data'];
    this.total = data['total'];
    this.nItems = posts.length;
  }

  PostsData.withError(String errorMessage) {
    this.errorMessage = errorMessage;
  }
}
