import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_link_preview/flutter_link_preview.dart';

import '../../helper/utils.dart';

class CustomLinkPreview extends StatefulWidget {
  final String previewPath;

  const CustomLinkPreview({Key key, @required this.previewPath})
      : super(key: key);

  @override
  _CustomLinkPreviewState createState() => _CustomLinkPreviewState();
}

class _CustomLinkPreviewState extends State<CustomLinkPreview> {
  bool isFetched;

  @override
  void initState() {
    isFetched = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isFetched
        ? InkWell(
          onTap: () {
            Utils.launchURL(widget.previewPath);
          },
          splashColor: Colors.grey[100],
          highlightColor: Colors.grey[100],
          child: FlutterLinkPreview(
              url: widget.previewPath,
              builder: (info) {
                if (info is WebImageInfo) {
                  return CachedNetworkImage(
                    imageUrl: info.image,
                    fit: BoxFit.contain,
                  );
                }
                final WebInfo webInfo = info;
                if (info == null || (!WebAnalyzer.isNotEmpty(webInfo.title)))
                  return buildPreviewReload();
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildPreviewIcon(webInfo.icon),
                    SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          buildPreviewTitle(webInfo.title),
                          const SizedBox(height: 2),
                          if (WebAnalyzer.isNotEmpty(webInfo.description))
                            buildPreviewDescription(webInfo.description),
                          if (WebAnalyzer.isNotEmpty(webInfo.image))
                            ...buildPreviewImage(webInfo.image)
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
        )
        : InkWell(
            child: buildPreviewReload(),
            onTap: () {
              setState(() {
                isFetched = true;
              });
            },
          );
  }

  List<Widget> buildPreviewImage(String image) {
    return [
      const SizedBox(height: 8),
      CachedNetworkImage(
        imageUrl: image,
        fit: BoxFit.contain,
      ),
    ];
  }

  Widget buildPreviewDescription(String description) {
    return Row(
      children: [
        Expanded(
          child: Text(
            description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 12, letterSpacing: 0.2),
          ),
        ),
      ],
    );
  }

  Widget buildPreviewReload() {
    return Column(
      children: [
        Icon(Icons.refresh),
        SizedBox(height: 5),
        Text(
          "Tap to load preview",
        )
      ],
    );
  }

  Widget buildPreviewTitle(String title) {
    return Text(
      title,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins',
      ),
    );
  }

  Widget buildPreviewIcon(String icon) {
    return Column(
      children: [
        Image.network(
          icon ?? "",
          fit: BoxFit.contain,
          width: 25,
          height: 25,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.link);
          },
        ),
        SizedBox(height: 5),
        Container(
          margin: const EdgeInsets.only(left: 1),
          color: Colors.grey[400],
          height: 32,
          width: 2,
        )
      ],
    );
  }
}
