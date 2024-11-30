import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utilities {
  static Widget loadAssetImage(String imageName,
      {double? width, double? height, BoxFit? fit}) {
    return Image.asset(
      "assets/images/$imageName.png",
      width: width,
      height: height,
      fit: fit,
    );
  }

  static String formatTimestamp(Timestamp? timestamp) {
    DateTime now = DateTime.now();
    DateTime time = timestamp!.toDate();

    Duration difference = now.difference(time);

    if (difference.inDays == 1) {
      return 'yesterday'; // If it was yesterday
    } else if (difference.inDays > 1) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays == 0 && difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays == 0 && difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    }
    var format = new DateFormat('HH.mm'); // <- use skeleton here
    return format.format(timestamp.toDate());
  }

  static String formatTimestampRealTime(int? timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp!);
    var format = new DateFormat('HH.mm'); // <- use skeleton here
    return format.format(date);
  }
}
