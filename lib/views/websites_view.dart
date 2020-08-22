import 'package:flutter/material.dart';

import 'package:nepalupdate/constants.dart';
import 'package:nepalupdate/widgets/website_card.dart';

class WebsitesView extends StatelessWidget {
  final String title;
  final List<dynamic> websites;

  WebsitesView({
    Key key,
    @required this.title,
    this.websites,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          this.title,
          style: kHeaderStyle,
        ),
        backgroundColor: Colors.white,
        iconTheme: new IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 15,
        ),
        child: GridView.builder(
          physics: BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: this.websites.length,
          itemBuilder: (context, index) {
            var item = this.websites[index];

            return WebsiteCard(item);
          },
        ),
      ),
    );
  }
}
