import 'package:flutter/material.dart';
import 'package:oro_task/bloc/bloc_base_provider.dart';
import 'package:oro_task/bloc/visitBloc.dart';
import 'package:oro_task/pages/home/component/CTAbutton_widget.dart';
import 'package:oro_task/pages/visitDetails/visitDetailsScreen.dart';
import 'package:oro_task/theme.dart';

import 'component/processTile.dart';
import 'component/subProcessTile.dart';

class NewVisit extends StatelessWidget {
  const NewVisit({Key key}) : super(key: key);

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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Loan",
                          style: OroTheme.headTextStyle28,
                        ),
                        Text(
                          Dummy.lorem2,
                          style: OroTheme.tileInfoHead400,
                        ),
                      ],
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
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Stack(
                    children: [
                      Center(
                        child: Column(
                            children: List.generate(
                          100,
                          (index) => Container(
                            height: 4,
                            width: 2,
                            margin: EdgeInsets.symmetric(vertical: 2),
                            color: Color(0xFFFFB631),
                          ),
                        )),
                      ),
                      Column(
                        children: [
                          ProcessTile(
                            number: "1",
                            head: Dummy.loremHead,
                            body: Dummy.lorem2,
                          ),
                          SizedBox(height: 40),
                          ProcessTile(
                            number: "2",
                            head: Dummy.loremHead,
                            body: Dummy.lorem2,
                          ),
                          SizedBox(height: 40),
                          SubProcessTile(
                            islarge: true,
                            head: Dummy.loremHead,
                          ),
                          SizedBox(height: 40),
                          ProcessTile(
                            number: "3",
                            head: Dummy.loremHead,
                            body: Dummy.lorem2,
                          ),
                          SizedBox(height: 40),
                          ProcessTile(
                            number: "4",
                            head: Dummy.loremHead,
                            body: Dummy.lorem2,
                          ),
                          SizedBox(height: 40),
                          SubProcessTile(
                            islarge: false,
                            head:
                                "Your gold is safely stored in our lending partner’s vault.",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) {
                        return BlocProvider<VisitBloc>(
                          bloc: BlocProvider.of<VisitBloc>(context),
                          child: VisitDetailsScreen(),
                        );
                      },
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                        "Apply Now",
                        style: OroTheme.headTestStyle
                            .copyWith(color: Colors.white),
                      ),
                      Text(
                        "Schedule  visit",
                        style: OroTheme.visitTileInfoSubHead
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
