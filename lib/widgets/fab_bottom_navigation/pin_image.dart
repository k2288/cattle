
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cattle/utils/PinConfig.dart';
import 'package:flutter/material.dart';

class PinImage extends StatelessWidget {

  final String url;

  PinImage({this.url});
  @override
  Widget build(BuildContext context) {
    
    return Container(
      child: CachedNetworkImage(
        placeholder: (context, url) => CircularProgressIndicator(),
        imageUrl: 'http://${PinConfig.IP}:${PinConfig.PORT}$url',
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }
}