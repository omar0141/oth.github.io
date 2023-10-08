import 'package:flutter/material.dart';
import 'package:shakosh/main.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton(
      {Key? key,
      this.text,
      this.press,
      this.backcolor,
      this.forecolor,
      this.fontsize,
      this.submit})
      : super(key: key);
  final String? text;
  final VoidCallback? press;
  final backcolor;
  final forecolor;
  final fontsize;
  final submit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: MaterialButton(
        color: submit == true
            ? backcolor == null
                ? colors(context).kprimaryColor
                : backcolor.withAlpha(150)
            : backcolor ?? colors(context).kprimaryColor,
        padding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        onPressed: submit == true ? null : press,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            submit == true
                ? SizedBox(
                    width: 25,
                    height: 25,
                    child: CircularProgressIndicator(
                      color: forecolor ?? Colors.white,
                    ),
                  )
                : Text(
                    text!,
                    style: TextStyle(
                        fontSize: fontsize == null ? 14 : fontsize.toDouble(),
                        color: forecolor ?? Colors.white,
                        height: 2),
                  ),
          ],
        ),
      ),
    );
  }
}
