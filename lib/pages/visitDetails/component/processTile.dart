import 'package:flutter/material.dart';
import 'package:oro_task/theme.dart';

class ProcessTile extends StatelessWidget {
  final number;
  final head;
  final body;
  final Function onTap;
  final String ctaLable;
  ProcessTile(
      {Key key, this.number, this.head, this.body, this.onTap, this.ctaLable})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xFFE5E5E5),
          width: 1,
        ),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.topLeft,
              child: ClipOval(
                child: Container(
                  height: 25,
                  width: 25,
                  color: Color(0xFFEC4E4E),
                  child: Center(
                    child: Text(
                      number,
                      style: OroTheme.headTestStyle
                          .copyWith(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  head,
                  style: OroTheme.headTestStyle,
                ),
                Text(
                  body,
                  style: OroTheme.tileInfoHead400,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: InkWell(
              onTap: onTap,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Color(0xFFEC4E4E),
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                ),
                child: Center(
                  child: Text(
                    ctaLable,
                    style: OroTheme.visitTileInfoSubHead
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
