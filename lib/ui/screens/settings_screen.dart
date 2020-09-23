import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SettingsScreen extends StatefulWidget {
  static const routeName = "SettingsScreen";

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notifications = true;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 3,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          splashRadius: 21,
          onPressed: () => Navigator.of(context).popAndPushNamed("/"),
          icon: Icon(Icons.arrow_back),
        ),
        iconTheme: IconThemeData(color: Colors.grey[800]),
        title: Text(
          "Settings",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 22, 15, 16),
              child: SizedBox(
                width: width,
                child: Text(
                  "Chat features",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          Divider(
            height: 1,
            thickness: 0.9,
          ),
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 15),
              child: SizedBox(
                width: width,
                child: Text(
                  "Notifications",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          Divider(
            height: 1,
            thickness: 0.9,
          ),
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 15),
              child: SizedBox(
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Hear outgoing message sounds",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Switch(
                      value: notifications,
                      activeColor: Theme.of(context).primaryColor,
                      activeTrackColor:
                          Theme.of(context).primaryColor.withOpacity(0.5),
                      onChanged: (val) => setState(() {
                        return notifications = !notifications;
                      }),
                      inactiveThumbColor: Colors.grey[300],
                      inactiveTrackColor: Colors.grey[500],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Divider(
            height: 1,
            thickness: 0.9,
          ),
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 15),
              child: SizedBox(
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your current country",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 1),
                    Text(
                      "Automatically detected (Pakistan)",
                      //change from msgmanager country
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        color: Colors.grey[600],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Divider(
            height: 1,
            thickness: 0.9,
          ),
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 15),
              child: SizedBox(
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Suggestions in chat",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 1),
                    Text(
                      "Google Assistant, smart reply & more",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        color: Colors.grey[600],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Divider(
            height: 1,
            thickness: 0.9,
          ),
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 15),
              child: SizedBox(
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Automatic previews",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 1),
                    Text(
                      "Google Assistant, smart reply & more",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Divider(
            height: 1,
            thickness: 0.9,
          ),
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 15),
              child: SizedBox(
                width: width,
                child: Text(
                  "Spam protection",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          Divider(
            height: 1,
            thickness: 0.9,
          ),
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 15),
              child: SizedBox(
                width: width,
                child: Text(
                  "Advanced",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          Divider(
            height: 1,
            thickness: 0.9,
          ),
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 15),
              child: SizedBox(
                width: width,
                child: Text(
                  "About, terms & privacy",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
