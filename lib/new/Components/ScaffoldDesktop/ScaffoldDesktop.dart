import 'package:flutter/material.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Components/ScaffoldDesktop/Components/Header1.dart';
import 'package:shakosh/new/Components/ScaffoldDesktop/Components/Header2.dart';

class ScaffoldDesktop extends StatelessWidget {
  const ScaffoldDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Header1(),
          Header2(),
          Expanded(
            child: ListView(children: [
              SizedBox(
                height: 1000,
              ),
              footer(context)
            ]),
          ),
        ],
      ),
    );
  }

  Widget footer(context) {
    return Container(
      height: 70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "© 2023 Bayt Aleadad",
                style: TextStyle(color: colors(context).grey1),
              ),
              SelectableText("Sales@originaltoolshome.com"),
              SelectableText(
                "جسر السويس القاهرة - مصر",
                style: TextStyle(height: 1),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
