import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Visits {
  Map<String, dynamic> addressMap;
  int id;
  Timestamp timestamp;
  int status;
  Visits({
    @required this.id,
    this.addressMap,
    @required this.timestamp,
    @required this.status,
  });
}
