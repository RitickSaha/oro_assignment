import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jiffy/jiffy.dart';
import 'package:oro_task/bloc/bloc_base_provider.dart';
import 'package:oro_task/bloc/visitBloc.dart';
import 'package:oro_task/model/visits.dart';
import 'package:oro_task/pages/home/component/CTAbutton_widget.dart';

import 'package:oro_task/theme.dart';

class VisitDetailsScreen extends StatefulWidget {
  final Visits data;
  VisitDetailsScreen({Key key, this.data}) : super(key: key);

  @override
  _VisitDetailsScreenState createState() => _VisitDetailsScreenState();
}

class _VisitDetailsScreenState extends State<VisitDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: CTAButton(
                lable: "Support",
              ),
            ),
          )
        ],
        iconTheme: ThemeData.light().iconTheme,
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (widget.data.status == 0)
                            Image.asset(
                              "illustrations/process.png",
                              height: 100,
                              width: 100,
                              fit: BoxFit.contain,
                            ),
                          if (widget.data.status == 2)
                            Container(
                              width: 100,
                              height: 100,
                              child: Stack(
                                children: [
                                  Icon(
                                    Icons.circle,
                                    size: 100,
                                    color: Colors.red.withOpacity(0.8),
                                  ),
                                  Center(
                                    child: Icon(
                                      Icons.close,
                                      size: 60,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (widget.data.status == 1)
                            Container(
                              width: 100,
                              height: 100,
                              child: Stack(
                                children: [
                                  Icon(
                                    Icons.circle,
                                    size: 100,
                                    color: Colors.green.withOpacity(0.8),
                                  ),
                                  Center(
                                    child: Icon(
                                      Icons.done,
                                      size: 60,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          Text(
                            "Loan Visit",
                            style: OroTheme.headTextStyle28.copyWith(
                              fontSize: 34,
                            ),
                          ),
                          Text(
                            "${(widget.data.status == 0 ? "Requested" : widget.data.status == 1 ? "Approved" : "Canceled") + " !"}",
                            style: OroTheme.headTextStyle28.copyWith(
                              fontSize: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40),
                    Text(
                      "VISIT DETAILS",
                      style: OroTheme.visitTileInfoSubHead.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFFE5E5E5),
                    width: 1,
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildAddress(),
                    SizedBox(height: 20),
                    Text(
                      Jiffy(DateTime.fromMillisecondsSinceEpoch(
                              widget.data.timestamp.millisecondsSinceEpoch))
                          .format("dd MMM, yyyy | h:mm a"),
                      style: OroTheme.visitTileInfoSubHead.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Visit Date and time",
                      style:
                          OroTheme.visitTileInfoSubHead.copyWith(fontSize: 20),
                    ),
                    SizedBox(height: 20),
                    Text(
                      widget.data.id.toString(),
                      style: OroTheme.visitTileInfoSubHead.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "visitID",
                      style:
                          OroTheme.visitTileInfoSubHead.copyWith(fontSize: 20),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(20),
                color: Color(0xFFFFF9EF),
                child: Center(
                  child: Text(
                    "You will get a call from  to confirm your Loan visit.",
                    style: OroTheme.visitTileInfoSubHead,
                  ),
                ),
              ),
              Expanded(
                child: Container(),
              ),
              if (widget.data.status < 2)
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(20),
                  color: Color(0xFFE5E5E5),
                  child: Center(
                    child: RichText(
                        text: TextSpan(
                            text: "Changed your mind?",
                            style: OroTheme.visitTileInfoSubHead
                                .copyWith(fontSize: 15),
                            children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                BlocProvider.of<VisitBloc>(context)
                                    .updateData(widget.data.id);
                                widget.data.status = 2;
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (ctx) {
                                  return BlocProvider<VisitBloc>(
                                    bloc: BlocProvider.of<VisitBloc>(context),
                                    child: VisitDetailsScreen(
                                      data: widget.data,
                                    ),
                                  );
                                }));
                              },
                            text: " Click here to cancel your visit",
                            style: OroTheme.visitTileInfoSubHead.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          )
                        ])),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Row buildAddress() {
    return Row(
      children: [
        InkWell(
          child: Align(
            alignment: Alignment.center,
            child: SvgPicture.asset(
              "illustrations/marker.svg",
              height: 40,
              width: 40,
            ),
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          flex: 6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${widget.data.addressMap["userDefined"]["type"]}",
                style: OroTheme.headTestStyle,
              ),
              Text(
                "${widget.data.addressMap["userDefined"]["pinPoint"] ?? ""}, ${widget.data.addressMap["address"]["streetAddress"] ?? ""}, ${widget.data.addressMap["address"]["city"] ?? ""},${widget.data.addressMap["address"]["region"] ?? ""}, ${widget.data.addressMap["address"]["countryName"] ?? ""}, ${widget.data.addressMap["address"]["countryCode"] ?? ""}}",
                style: OroTheme.tileInfoHead400,
              ),
            ],
          ),
        ),
        SizedBox(
          width: 100,
        )
      ],
    );
  }
}
