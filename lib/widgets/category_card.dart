import 'package:flutter/material.dart';

import 'package:nepalupdate/constants.dart';

class CategoryCard extends StatelessWidget {
  final Map<String, dynamic> category;
  final Function onClickCallback;

  CategoryCard({
    this.category,
    this.onClickCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () => this.onClickCallback(context, this.category),
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 6,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        this.category['title'],
                        style: kCategoryTitle,
                      ),
                      Text(
                        '${this.category['websites_count'].toString()} Websites',
                        style: kCategorySubtitle,
                      ),
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: kGrey2,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
