import 'package:flutter/material.dart';
import 'package:nepalupdate/arguments/websites.dart';

import 'package:nepalupdate/constants.dart';
import 'package:nepalupdate/widgets/website_card.dart';
import 'package:nepalupdate/widgets/category_card.dart';

class FeaturedItems extends StatelessWidget {
  final Map<String, dynamic> item;
  FeaturedItems(this.item);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        buildHeader(context),
        if (this.hasCategories()) buildCategories(context),
        if (this.hasWebsites()) buildWebsites(),
      ],
    );
  }

  Container buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Text(
              this.item['title'],
              style: kHeaderStyle,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          FlatButton(
            onPressed: () => navigateToWebsites(context),
            child: Text(
              'View All',
              style: kHeaderButton,
            ),
          ),
        ],
      ),
    );
  }

  Container buildCategories(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          for (var category in this.item['children'])
            CategoryCard(
              category: category,
              onClickCallback: this.navigateToCategoryWebsites,
            )
        ],
      ),
    );
  }

  Container buildWebsites() {
    int nitems = this.getWebsitesCount();
    int itemcount = nitems > 4 ? 4 : nitems;

    return Container(
      width: double.infinity,
      height: 200.0,
      padding: EdgeInsets.only(
        left: 18.0,
        bottom: 20.0,
      ),
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: itemcount,
        scrollDirection: Axis.horizontal,
        shrinkWrap: false,
        itemBuilder: (context, index) {
          var website = this.item['websites'][index];

          return Container(
            margin: EdgeInsets.only(right: 10.0),
            child: WebsiteCard(website),
          );
        },
      ),
    );
  }

  void navigateToWebsites(BuildContext context) {
    Navigator.of(context).pushNamed('/websites',
        arguments: WebsitesViewArugments(
          title: this.item['title'],
          websites: this.item['websites'],
        ));
  }

  void navigateToCategoryWebsites(
      BuildContext context, Map<String, dynamic> category) {
    String title = category['title'];

    var websites = this
        .item['websites']
        .where((website) => website['category'] == title)
        .toList();

    Navigator.of(context).pushNamed('/websites',
        arguments: WebsitesViewArugments(
          title: title,
          websites: websites,
        ));
  }

  int getWebsitesCount() {
    return this.item['websites'].length;
  }

  int getCategoriesCount() {
    return this.item['children'].length;
  }

  bool hasCategories() {
    return this.getCategoriesCount() > 0;
  }

  bool hasWebsites() {
    return this.getWebsitesCount() > 0;
  }
}
