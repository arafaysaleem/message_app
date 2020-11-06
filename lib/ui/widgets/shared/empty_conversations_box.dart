import 'package:flutter/material.dart';

class EmptyConversationsBox extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        SizedBox(height: 200),

        //Skeleton row
        ...[Colors.black26, Colors.black12].map(
          (color) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Circle Shape
                Container(
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                  height: 44,
                  width: 44,
                ),

                SizedBox(width: 20),

                //Lines skeleton
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Container(
                      height: 11,
                      width: color == Colors.black26 ? 50 : 95,
                      color: color,
                    ),

                    SizedBox(height: 7),

                    Container(
                      height: 6,
                      width: 140,
                      color: color,
                    ),

                    SizedBox(height: 7),

                    Container(
                      height: 6,
                      width: 30,
                      color: color,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),

        SizedBox(height: 10),

        //Message
        Text(
          "This list contains no conversations",
          style: TextStyle(
            fontSize: 13,
            fontFamily: "Poppins",
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}
