

import 'package:flutter/material.dart';
import 'package:oro_task/bloc/addressBloc.dart';
import 'package:oro_task/bloc/bloc_base_provider.dart';
import 'package:oro_task/bloc/visitBloc.dart';
import 'package:oro_task/model/visits.dart';
import 'package:oro_task/pages/home/component/CTAbutton_widget.dart';
import 'package:oro_task/pages/home/component/visitTile_widget.dart';
import 'package:oro_task/pages/newVisit/newVisit.dart';
import 'package:oro_task/theme.dart';

class OroTaskHome extends StatefulWidget {
  OroTaskHome({Key key}) : super(key: key);

  @override
  _OroTaskHomeState createState() => _OroTaskHomeState();
}

class _OroTaskHomeState extends State<OroTaskHome> {
  @override
  void dispose() {
    BlocProvider.of<VisitBloc>(context).dispose();
    BlocProvider.of<AddressBloc>(context).dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Visits",
                    style: OroTheme.headTestStyle,
                  ),
                  Spacer(),
                  CTAButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) {
                            return BlocProvider<VisitBloc>(
                              bloc: VisitBloc(),
                              child: NewVisit(),
                            );
                          },
                        ),
                      );
                    },
                    lable: "New",
                  ),
                ],
              ),
              Expanded(
                child: StreamBuilder<List<Visits>>(
                    stream: BlocProvider.of<VisitBloc>(context).visitsStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData)
                        return SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            children: snapshot.data
                                .map((e) => VisitTile(
                                      data: e,
                                    ))
                                .toList(),
                          ),
                        );
                      return Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.not_listed_location_outlined,
                              size: 100,
                            ),
                            Text(
                              "You don’t have any visits. Add a new one to proceed.",
                              style: OroTheme.subHeadStyle,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
