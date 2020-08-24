import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:nepalupdate/constants.dart';
import 'package:nepalupdate/arguments/webview.dart';

class WebsiteSearch extends SearchDelegate {
  final List<dynamic> websites;

  WebsiteSearch(this.websites) : super(searchFieldLabel: "Search websites...");

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Searched'),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<dynamic> suggestions = [];

    if (query.isNotEmpty) {
      var filtered = this.websites.where((website) {
        return website['title'].contains(query) ||
            website['url'].contains(query);
      });

      suggestions.addAll(filtered);
    }

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                suggestions[index]['title'],
                style: kHeaderStyle,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                suggestions[index]['description'],
                style: kDetailContent,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          leading: CachedNetworkImage(
            imageUrl: suggestions[index]['image'],
            imageBuilder: (context, imageProvider) => Image(
              image: imageProvider,
              fit: BoxFit.contain,
              width: 50,
              height: 25,
            ),
          ),
          onTap: () {
            var website = suggestions[index];
            bool hasPosts = website['has_posts'];

            if (hasPosts) {
              Navigator.of(context).pushNamed('/website', arguments: website);
            } else {
              Navigator.of(context).pushNamed(
                '/webview',
                arguments: WebViewArguments(
                  title: website['title'],
                  url: website['url'],
                  image: website['image'],
                ),
              );
            }
          },
        );
      },
    );
  }
}
