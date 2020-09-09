import 'package:flutter/material.dart';

class DefaultAppBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          splashColor: Colors.grey,
          icon: Icon(
            Icons.search,
            color: Colors.grey[600],
          ),
          onPressed: () {},
        ),
        Expanded(
          child: TextField(
            cursorColor: Colors.black,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.go,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 15),
              hintText: "Search images and video",
            ),
          ),
        ),
        IconButton(
          splashColor: Colors.grey,
          onPressed: () {
            //TODO: Add pop up menu with options:-
            // to view spam/archive
            // mark all read
            // delete all etc
            // change theme
            // mute all
            // labels: P1, feature, upcoming
          },
          icon: Icon(
            Icons.more_vert,
            color: Colors.grey[600],
          ),
        )
      ],
    );
  }
}
