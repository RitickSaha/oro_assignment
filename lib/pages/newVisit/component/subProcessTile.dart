import 'package:flutter/material.dart';
import 'package:oro_task/theme.dart';

class SubProcessTile extends StatelessWidget {
  final bool islarge;
  final head;
  const SubProcessTile({Key key, this.islarge, this.head}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xFFE5E5E5),
          width: 1,
        ),
        color: Colors.white,
      ),
      child: Text(
        head,
        style: !islarge ? OroTheme.tileInfoHead400 : OroTheme.headTextStyle28,
        textAlign: TextAlign.center,
      ),
    );
  }
}
