import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:nepalupdate/constants.dart';
import 'package:nepalupdate/arguments/webview.dart';

class WebsiteCard extends StatelessWidget {
  final Map<String, dynamic> website;
  WebsiteCard(this.website);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        bool hasPosts = this.website['has_posts'];

        if (hasPosts) {
          Navigator.of(context).pushNamed('/website', arguments: this.website);
        } else {
          Navigator.of(context).pushNamed(
            '/webview',
            arguments: WebViewArguments(
              this.website['title'],
              this.website['url'],
              this.website['image'],
            ),
          );
        }
      },
      child: HeroContent(website: website),
    );
  }
}

class HeroContent extends StatelessWidget {
  const HeroContent({
    Key key,
    @required this.website,
  }) : super(key: key);

  final Map<String, dynamic> website;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(
          color: kGrey3,
          width: 2.0,
        ),
      ),
      padding: EdgeInsets.all(10.0),
      child: Stack(
        children: <Widget>[
          buildContents(),
          if (this.website['has_posts']) buildBadge(),
        ],
      ),
    );
  }

  Positioned buildBadge() {
    return Positioned(
      right: 0,
      child: new Container(
        padding: EdgeInsets.all(4),
        decoration: new BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          Icons.assignment,
          color: Colors.white,
          size: 18,
        ),
      ),
    );
  }

  Container buildContents() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildHero(),
          SizedBox(height: 5.0),
          Text(
            this.website['title'],
            overflow: TextOverflow.ellipsis,
            style: kTitleCard,
          ),
          SizedBox(height: 5.0),
          Text(
            this.website['description'],
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: kDetailContent,
          ),
        ],
      ),
    );
  }

  Expanded buildHero() {
    String image = this.website['image'];

    return Expanded(
      child: Hero(
        tag: this.website['id'],
        child: CachedNetworkImage(
          imageUrl: image,
          imageBuilder: (context, imageProvider) => Container(
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.contain,
                )),
          ),
          placeholder: (context, url) => Image(
            image: AssetImage(kFallbackImageSource),
            fit: BoxFit.contain,
            width: double.infinity,
          ),
        ),
      ),
    );
  }
}
