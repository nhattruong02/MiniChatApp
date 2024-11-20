import 'package:flutter/material.dart';

class AssetImageLoader {
  static Widget loadAssetImage(String imageName,
      {double? width, double? height, BoxFit? fit}) {
    return Image.asset(
      "assets/images/$imageName.png",
      width: width,
      height: height,
      fit: fit,
    );
  }
}
