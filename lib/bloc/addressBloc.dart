import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocode/geocode.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oro_task/bloc/bloc_base_provider.dart' as base;

enum AddressEvents {
  Add,
  Remove,
}

class AddressBloc extends base.BlocBase {
  static Address _address;
  static String _type;
  static String _pinPoint;
  static LatLng _geoPoint;

  final StreamController<List<Map<String, dynamic>>> _addressBloc =
      StreamController<List<Map<String, dynamic>>>.broadcast();

  final StreamController<AddressEvents> _addressEventBloc =
      StreamController<AddressEvents>.broadcast();

  StreamSink<AddressEvents> get addressSink => _addressEventBloc.sink;

  Stream<List<Map<String, dynamic>>> get addressStream => _addressBloc.stream;

  void initialise(
      {Address address, String type, String pinPoint, LatLng geoPoint}) {
    _address = address;
    _pinPoint = pinPoint;
    _type = type;
    _geoPoint = geoPoint;
  }

  AddressBloc() {
    fetchData();
    _addressEventBloc.stream.listen((AddressEvents event) {
      switch (event) {
        case AddressEvents.Add:
          FirebaseFirestore.instance.collection("savedAddress").add({
            "address": {
              "countryCode": _address.countryCode,
              "elevation": null,
              "timezone": _address.timezone,
              "geoNumber": _address.geoNumber,
              "streetNumber": _address.streetNumber,
              "streetAddress": _address.streetAddress,
              "city": _address.city,
              "countryName": _address.countryName,
              "region": _address.region,
              "postal": _address.postal,
              "distance": _address.distance
            },
            "geoPoint": GeoPoint(_geoPoint.latitude, _geoPoint.longitude),
            "userDefined": {"pinPoint": _pinPoint, "type": _type}
          });
          break;
        default:
      }
    });
  }
  @override
  void dispose() {
    _addressBloc.close();
    _addressEventBloc.close();
  }

  void fetchData() {
    FirebaseFirestore.instance
        .collection("savedAddress")
        .snapshots()
        .listen((event) {
      _addressBloc.sink.add(event.docs.map((e) => e.data()).toList());
    });
  }
}
