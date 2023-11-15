import 'dart:async';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:shakosh/Config/Translations/Translation.dart';

class MySnackBar {
  successSnack(context, text) {
    bool dismiss = false;
    double _progress = 0;
    double progress = 0;
    AnimatedSnackBar(
      desktopSnackBarPosition: DesktopSnackBarPosition.topCenter,
      mobileSnackBarPosition: MobileSnackBarPosition.top,
      snackBarStrategy: RemoveSnackBarStrategy(),
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          Timer.periodic(
            const Duration(milliseconds: 100),
            (Timer timer) {
              if (_progress >= 1 || dismiss == true) {
                timer.cancel();
              } else {
                _progress += 0.0001;
                progress += 1;
                try {
                  setState(() {});
                } catch (e) {}
              }
            },
          );

          return AnimatedScale(
            scale: dismiss ? 0 : 1,
            duration: Duration(milliseconds: 100),
            child: Container(
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 116, 209, 119),
                  borderRadius: BorderRadius.circular(5)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(children: [
                      Row(
                        children: [
                          CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 10,
                              child: Icon(
                                Icons.done_rounded,
                                color: Colors.green,
                                size: 15,
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              text.toString().tr,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          InkWell(
                            onTap: (() {
                              dismiss = true;
                              setState(() {});
                            }),
                            child: Icon(
                              Icons.close,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ]),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    child: LinearProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Color.fromARGB(255, 116, 209, 119)),
                      backgroundColor: Colors.white,
                      minHeight: 4,
                      value: _progress,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    ).show(
      context,
    );
  }

  errorSnack(context, text, serverError) {
    bool dismiss = false;
    double _progress = 0;
    double progress = 0;
    AnimatedSnackBar(
      duration: Duration(seconds: 8),
      desktopSnackBarPosition: DesktopSnackBarPosition.topCenter,
      mobileSnackBarPosition: MobileSnackBarPosition.top,
      snackBarStrategy: RemoveSnackBarStrategy(),
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          Timer.periodic(
            const Duration(milliseconds: 100),
            (Timer timer) {
              if (_progress >= 1 || dismiss == true) {
                timer.cancel();
              } else {
                _progress += 0.0001;
                progress += 1;
                try {
                  setState(() {});
                } catch (e) {}
              }
            },
          );
          return AnimatedScale(
            scale: dismiss ? 0 : 1,
            duration: Duration(milliseconds: 100),
            child: Container(
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 118, 118),
                  borderRadius: BorderRadius.circular(5)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 10,
                            child: Icon(
                              Icons.close,
                              color: Colors.redAccent,
                              size: 15,
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            text.toString().tr,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        InkWell(
                          onTap: (() {
                            dismiss = true;
                            setState(() {});
                          }),
                          child: Icon(
                            Icons.close,
                            size: 20,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    child: LinearProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Color.fromARGB(255, 255, 118, 118)),
                      backgroundColor: Colors.white,
                      minHeight: 4,
                      value: _progress,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    ).show(
      context,
    );
  }

  infoSnack(context, text) {
    bool dismiss = false;
    double _progress = 0;
    double progress = 0;
    AnimatedSnackBar(
      desktopSnackBarPosition: DesktopSnackBarPosition.topCenter,
      mobileSnackBarPosition: MobileSnackBarPosition.top,
      snackBarStrategy: RemoveSnackBarStrategy(),
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          Timer.periodic(
            const Duration(milliseconds: 100),
            (Timer timer) {
              if (_progress >= 1 || dismiss == true) {
                timer.cancel();
              } else {
                _progress += 0.00011;
                progress += 1;
                try {
                  setState(() {});
                } catch (e) {}
              }
            },
          );
          return AnimatedScale(
            scale: dismiss ? 0 : 1,
            duration: Duration(milliseconds: 100),
            child: Container(
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 112, 191, 255),
                  borderRadius: BorderRadius.circular(5)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            text.toString().tr,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        InkWell(
                          onTap: (() {
                            dismiss = true;
                            setState(() {});
                          }),
                          child: Icon(
                            Icons.close,
                            size: 20,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    child: LinearProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Color.fromARGB(255, 112, 191, 255)),
                      backgroundColor: Colors.white,
                      minHeight: 4,
                      value: _progress,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    ).show(
      context,
    );
  }

  warningSnack(context, text) {
    bool dismiss = false;
    double _progress = 0;
    double progress = 0;
    AnimatedSnackBar(
      desktopSnackBarPosition: DesktopSnackBarPosition.topCenter,
      mobileSnackBarPosition: MobileSnackBarPosition.top,
      snackBarStrategy: RemoveSnackBarStrategy(),
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          Timer.periodic(
            const Duration(milliseconds: 100),
            (Timer timer) {
              if (_progress >= 1 || dismiss == true) {
                timer.cancel();
              } else {
                _progress += 0.00011;
                progress += 1;
                try {
                  setState(() {});
                } catch (e) {}
              }
            },
          );
          return AnimatedScale(
            scale: dismiss ? 0 : 1,
            duration: Duration(milliseconds: 100),
            child: Container(
              decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 187, 0, 1),
                  borderRadius: BorderRadius.circular(5)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.warning_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            text.toString().tr,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        InkWell(
                          onTap: (() {
                            dismiss = true;
                            setState(() {});
                          }),
                          child: Icon(
                            Icons.close,
                            size: 20,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    child: LinearProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Color.fromRGBO(255, 187, 0, 1)),
                      backgroundColor: Colors.white,
                      minHeight: 4,
                      value: _progress,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    ).show(
      context,
    );
  }
}
