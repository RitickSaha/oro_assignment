import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jiffy/jiffy.dart';
import 'package:oro_task/bloc/bloc_base_provider.dart';
import 'package:oro_task/bloc/visitBloc.dart';
import 'package:oro_task/model/visits.dart';
import 'package:oro_task/pages/visitTileDetailsScreen/visitTileDetailsScreen.dart';

import 'package:oro_task/theme.dart';

class VisitTile extends StatelessWidget {
  final Visits data;
  VisitTile({
    Key key,
    this.data,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xFFE5E5E5),
          width: 1,
        ),
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      "illustrations/jewelry.svg",
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Gold Visit",
                      style: OroTheme.visitTileHead,
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                      return BlocProvider<VisitBloc>(
                        bloc: BlocProvider.of<VisitBloc>(context),
                        child: VisitDetailsScreen(
                          data: data,
                        ),
                      );
                    }));
                  },
                  child: Row(
                    children: [
                      Text("View Details", style: OroTheme.visitTileAction),
                      SizedBox(width: 10),
                      ClipOval(
                        child: Container(
                          height: 20,
                          width: 20,
                          color: Color(0xFF16A085),
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Color(0xFF5A5A5A),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.id.toString(),
                      style: OroTheme.visitTileInfoHead,
                    ),
                    Text(
                      "Visit ID",
                      style: OroTheme.visitTileInfoSubHead,
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Jiffy(DateTime.fromMillisecondsSinceEpoch(
                              data.timestamp.millisecondsSinceEpoch))
                          .format("dd MMM, yyyy | h:mm a"),
                      style: OroTheme.visitTileInfoHead,
                    ),
                    Text(
                      "Date and time",
                      style: OroTheme.visitTileInfoSubHead,
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${data.status == 0 ? "Requested" : data.status == 1 ? "Approved" : "Canceled"}",
                      style: OroTheme.visitTileInfoHead,
                    ),
                    Text(
                      "Status",
                      style: OroTheme.visitTileInfoSubHead,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
