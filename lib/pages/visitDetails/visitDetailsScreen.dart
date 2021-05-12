import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:jiffy/jiffy.dart';
import 'package:oro_task/bloc/addressBloc.dart';
import 'package:oro_task/bloc/bloc_base_provider.dart';
import 'package:oro_task/bloc/visitBloc.dart';
import 'package:oro_task/model/visits.dart';
import 'package:oro_task/pages/chooseAddress/chooseAddressScreen.dart';
import 'package:oro_task/pages/home/component/CTAbutton_widget.dart';
import 'package:oro_task/pages/visitDetails/component/stepsTile.dart';
import 'package:oro_task/theme.dart';

class VisitDetailsScreen extends StatefulWidget {
  const VisitDetailsScreen({Key key}) : super(key: key);

  @override
  _VisitDetailsScreenState createState() => _VisitDetailsScreenState();
}

class _VisitDetailsScreenState extends State<VisitDetailsScreen> {
  DateTime selectedDateTime;
  bool selectedAddress = false;
  @override
  void initState() {
    super.initState();
  }

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
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Image.asset("illustrations/Bitmap.png"),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      "Loan Visit",
                      style: OroTheme.headTextStyle28,
                    ),
                  ),
                ],
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.all(20),
                  color: Color(0xFFFFF9EF),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            "₹ 0",
                            style: OroTheme.headTestStyle,
                          ),
                          Text(
                            "Minimum amount",
                            style: OroTheme.visitTileInfoSubHead,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "1.19 %",
                            style: OroTheme.headTestStyle,
                          ),
                          Text(
                            "Starting interest p.m",
                            style: OroTheme.visitTileInfoSubHead,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "3 months",
                            style: OroTheme.headTestStyle,
                          ),
                          Text(
                            "Minimum tenure",
                            style: OroTheme.visitTileInfoSubHead,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    StreamBuilder<Visits>(
                        stream:
                            BlocProvider.of<VisitBloc>(context).newVisitsStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            selectedAddress = true;
                            return StepsTile(
                              number: "1",
                              head: "Add your address",
                              body: snapshot.data.addressMap["userDefined"]
                                      ["type"] +
                                  " address Selected",
                              ctaLable: "Add a address",
                              isFilled: selectedAddress,
                            );
                          }
                          return StepsTile(
                            number: "1",
                            head: "Add your address",
                            body:
                                "Choose from saved addresses or add a new one",
                            ctaLable: "Add a address",
                            isFilled: false,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (ctx) {
                                    return BlocProvider<VisitBloc>(
                                      child: BlocProvider<AddressBloc>(
                                        bloc: AddressBloc(),
                                        child: ChooseAddressScreen(),
                                      ),
                                      bloc: BlocProvider.of<VisitBloc>(context),
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        }),
                    SizedBox(height: 40),
                    StepsTile(
                      number: "2",
                      head: "Select date and time",
                      isFilled: selectedDateTime != null,
                      body: selectedDateTime != null
                          ? Jiffy(selectedDateTime)
                                  .format("dd MMM, yyyy | h:mm a") +
                              " selected"
                          : "Choose a preferred date and time for the visit",
                      ctaLable: "Select",
                      onEdit: () {
                        selectDateTime(context);
                      },
                      onTap: () {
                        selectDateTime(context);
                      },
                    ),
                    SizedBox(height: 40),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                    color: Color(0xffFFF7EA),
                    child: Center(
                      child: Text(
                        "You will get a call from to confirm your Instant Gold Loan visit.",
                        style: OroTheme.visitTileInfoSubHead
                            .copyWith(color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: selectedAddress && selectedDateTime != null
                        ? () {
                            BlocProvider.of<VisitBloc>(context)
                                .initialiseMainData(
                              selectedDateTime,
                              0,
                              Random().nextInt(900000),
                            );
                            BlocProvider.of<VisitBloc>(context)
                                .visitsSink
                                .add(VisitEvents.Request);
                            Navigator.pop(context);
                          }
                        : null,
                    child: Container(
                      width: double.infinity,
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: selectedAddress && selectedDateTime != null
                            ? Color(0xFFEC4E4E)
                            : Color(0xFF9B9B9B),
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Request Visit",
                            style: OroTheme.headTestStyle
                                .copyWith(color: Colors.white),
                          ),
                          Text(
                            "Save details and proceed",
                            style: OroTheme.visitTileInfoSubHead
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      ),
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

  void selectDateTime(BuildContext context) {
    DatePicker.showDateTimePicker(
      context,
      showTitleActions: true,
      minTime: DateTime.now(),
      maxTime: DateTime(2022, 12, 31),
      onConfirm: (date) {
        setState(() {
          selectedDateTime = date;
        });
      },
      currentTime: DateTime.now(),
      locale: LocaleType.en,
    );
  }
}
