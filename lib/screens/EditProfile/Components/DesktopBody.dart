import 'package:flutter/material.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/Screens/EditProfile/Components/EditProfileForm.dart';

class DesktopBody extends StatelessWidget {
  const DesktopBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight * 0.73,
      child: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            Center(
              child: Container(
                  padding:
                      EdgeInsets.only(right: 15, left: 15, top: 30, bottom: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border:
                          Border.all(width: 1, color: colors(context).grey2!)),
                  width: 400,
                  child: EditProfileForm()),
            ),
          ],
        ),
      ),
    );
  }
}
