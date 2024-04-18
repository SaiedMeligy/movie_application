import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_app/models/category_image.dart';

import '../../../core/constants.dart';
import '../../../models/CategoryFilm.dart';

class CategoryView extends StatelessWidget {
  final String title;
  final  String image;

  const CategoryView({super.key,required this.title,required this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            height: Constants.mediaQuery.height*0.2,
            decoration:  BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Color(0xffFFA90A).withOpacity(0.8),
                width: 2
              ),
              color: Colors.blue,
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                  //color: Color(0xffDADADA).withOpacity(0.6),
                  borderRadius: BorderRadius.circular(10)
              ), child: Text(
              "$title",style: Constants.theme.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            ),
          ],
        ),
      ],
    );
  }
}
