import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oro_task/bloc/addressBloc.dart';
import 'package:oro_task/bloc/bloc_base_provider.dart';
import 'package:oro_task/theme.dart';

class SetAddressScreen extends StatefulWidget {
  SetAddressScreen({Key key}) : super(key: key);

  @override
  _SetAddressScreenState createState() => _SetAddressScreenState();
}

class _SetAddressScreenState extends State<SetAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  Address currentAddress = Address(
    streetAddress: "7/4, Venus Colony",
    countryCode: "IN",
    countryName: "India",
    region: "Chennai",
    city: "Teynampet",
    postal: "600018",
  );
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  BitmapDescriptor defaultMapPin;
  Address confirmedAddress;
  AddressBloc addressBloc;
  String confirmedPinPoint, confirmedType;

  void _onMapCreated(GoogleMapController controller) {
    var marker = Marker(
      markerId: MarkerId("default"),
      draggable: true,
      onDragEnd: _updatePosition,
      icon: defaultMapPin,
      position: LatLng(13.044403, 80.251648),
      infoWindow: InfoWindow(
        title: "7/4, Venus Colony, Teynampet, Chennai",
        snippet: "Tamil Nadu,600018, India\n 13.044403, 80.251648",
      ),
    );
    setState(() {
      markers[MarkerId("default")] = marker;
    });
  }

  @override
  void initState() {
    super.initState();
    addressBloc = BlocProvider.of<AddressBloc>(context);
    setSourceAndDestinationIcons();
  }

  void setSourceAndDestinationIcons() async {
    defaultMapPin = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.5),
      "assets/map_pin.png",
    );
  }

  Future<void> _updatePosition(LatLng position) async {
    Marker marker = markers[MarkerId("default")];
    setState(() {
      markers[MarkerId("default")] = marker.copyWith(
        positionParam: LatLng(
          position.latitude,
          position.longitude,
        ),
      );
    });
    currentAddress = await GeoCode().reverseGeocoding(
        latitude: position.latitude, longitude: position.longitude);
    setState(() {
      markers[MarkerId("default")] = marker.copyWith(
        positionParam: LatLng(
          position.latitude,
          position.longitude,
        ),
        infoWindowParam: InfoWindow(
          title:
              "${currentAddress.streetAddress ?? " "}, ${currentAddress.city ?? " "}",
          snippet:
              "${currentAddress.region ?? " "},${currentAddress.countryName ?? " "},${currentAddress.postal ?? " "}",
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: Text(
            "Set location",
            style: OroTheme.headTestStyle,
          ),
        ),
        actions: [
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.search),
              ),
            ),
          )
        ],
        iconTheme: ThemeData.light().iconTheme,
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: GoogleMap(
                  mapType: MapType.hybrid,
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(13.044403, 80.251648),
                    zoom: 11.0,
                  ),
                  compassEnabled: true,
                  onCameraMove: (CameraPosition camPos) {},
                  mapToolbarEnabled: true,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  onMapCreated: _onMapCreated,
                  onLongPress: _updatePosition,
                  markers: Set<Marker>.of(markers.values),
                ),
              ),
              confirmedAddress == null
                  ? Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.only(
                              right: 80, top: 10, bottom: 10, left: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Location",
                                style: OroTheme.headTestStyle
                                    .copyWith(color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "${currentAddress.streetAddress ?? " "}, ${currentAddress.city ?? " "}, ${currentAddress.region ?? " "},${currentAddress.countryName ?? " "},${currentAddress.postal ?? " "}",
                                style: OroTheme.visitTileInfoSubHead
                                    .copyWith(color: Colors.black),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              confirmedAddress = currentAddress;
                            });
                          },
                          child: Container(
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            padding: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: Color(0xFFEC4E4E),
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "Confirm location",
                                  style: OroTheme.headTestStyle
                                      .copyWith(color: Colors.white),
                                ),
                                Text(
                                  "Double check pinned location",
                                  style: OroTheme.visitTileInfoSubHead
                                      .copyWith(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.only(
                              right: 20, top: 10, bottom: 10, left: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Enter address type",
                                      style: OroTheme.headTestStyle
                                          .copyWith(color: Colors.black),
                                      textAlign: TextAlign.center,
                                    ),
                                    TextFormField(
                                      decoration: const InputDecoration(
                                        hintText: 'Home/Office',
                                      ),
                                      onChanged: (value) {
                                        confirmedType = value;
                                      },
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please enter the name of residance';
                                        }
                                        return null;
                                      },
                                    ),
                                    Text(
                                      "Enter House number/Apartment name",
                                      style: OroTheme.headTestStyle
                                          .copyWith(color: Colors.black),
                                      textAlign: TextAlign.center,
                                    ),
                                    TextFormField(
                                      decoration: const InputDecoration(
                                        hintText: 'No. 5, Alsa apartments',
                                      ),
                                      onChanged: (value) {
                                        confirmedPinPoint = value;
                                      },
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please any discription about the address.';
                                        }
                                        return null;
                                      },
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        if (_formKey.currentState.validate()) {
                                          addressBloc.initialise(
                                            address: confirmedAddress,
                                            pinPoint: confirmedPinPoint,
                                            type: confirmedType,
                                            geoPoint:
                                                markers[MarkerId("default")]
                                                    .position,
                                          );

                                          addressBloc.addressSink
                                              .add(AddressEvents.Add);
                                          Navigator.pop(context);
                                        }
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        margin:
                                            EdgeInsets.symmetric(vertical: 10),
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        decoration: BoxDecoration(
                                          color: Color(0xFFEC4E4E),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(4),
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Text(
                                              "Save Address",
                                              style: OroTheme.headTestStyle
                                                  .copyWith(
                                                      color: Colors.white),
                                            ),
                                            Text(
                                              "Confirm and proceed",
                                              style: OroTheme
                                                  .visitTileInfoSubHead
                                                  .copyWith(
                                                      color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
