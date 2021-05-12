import 'package:flutter/material.dart';
import 'package:oro_task/theme.dart';

class CTAButton extends StatelessWidget {
  final Function onTap;
  final String lable;
  const CTAButton({
    Key key,
    this.onTap,
    this.lable,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 0.5,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        child: Text(
          lable,
          style: OroTheme.ctaTestStyle,
        ),
      ),
    );
  }
}
