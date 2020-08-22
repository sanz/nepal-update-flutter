import 'package:flutter/material.dart';

import 'package:nepalupdate/constants.dart';
import 'package:nepalupdate/arguments/webview.dart';

class PostCard extends StatelessWidget {
  final Map<String, dynamic> post;
  PostCard(this.post);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          '/webview',
          arguments: WebViewArguments(
            this.post['website']['title'],
            this.post['url'],
            this.post['website']['image'],
          ),
        );
      },
      child: Container(
        width: double.infinity,
        height: 135.0,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Container(
          width: double.infinity,
          child: Row(
            children: [
              postImage(),
              SizedBox(width: 12.0),
              postContent(),
            ],
          ),
        ),
      ),
    );
  }

  Expanded postContent() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post['title'],
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: kTitleCard,
            ),
            SizedBox(height: 4.0),
            Text(
              post['description'],
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              style: kDetailContent,
            ),
            Spacer(),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 14.0,
                ),
                SizedBox(width: 5.0),
                Text(
                  this.post['date'],
                  style: kDetailContent,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  ClipRRect postImage() {
    String image = this.post['image'];

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: image == null
          ? Image(
              image: AssetImage(kFallbackImageSource),
              width: 100.0,
              height: 135.0,
              fit: BoxFit.cover,
            )
          : FadeInImage.assetNetwork(
              placeholder: kFallbackImageSource,
              image: image,
              width: 100.0,
              height: 135.0,
              fit: BoxFit.cover,
              fadeInDuration: const Duration(milliseconds: 200),
            ),
    );
  }
}
