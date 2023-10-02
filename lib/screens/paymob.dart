import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:shakosh/components/loading.dart';
import 'package:shakosh/screens/home/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../controller/cart_wishlist.dart';
import '../controller/checkout.dart';
import '../controller/items.dart';
import '../helper/translation.dart';

class PaymobScreen extends StatefulWidget {
  static String routeName = "/paymob";
  final mytoken;
  final mynet;
  final myval;
  final myselected_payment;
  final mycoupon;
  final mydate;
  final myformat;
  PaymobScreen(
      {Key? key,
      this.title,
      this.mytoken,
      this.mycoupon,
      this.mydate,
      this.myformat,
      this.mynet,
      this.myselected_payment,
      this.myval})
      : super(key: key);

  final String? title;

  @override
  _PaymobScreenState createState() => _PaymobScreenState();
}

class _PaymobScreenState extends State<PaymobScreen> {
  String? currenturl;
  final format = DateFormat("yyyy-MM-dd HH:mm");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: InAppWebView(
      initialUrlRequest: URLRequest(
          url: Uri.parse(
              "https://accept.paymob.com/api/acceptance/iframes/681569?payment_token=${widget.mytoken}")),
      initialOptions: InAppWebViewGroupOptions(
          android: AndroidInAppWebViewOptions(
              mixedContentMode:
                  AndroidMixedContentMode.MIXED_CONTENT_ALWAYS_ALLOW)),
      onLoadStart: (e, l) async {
        if (l.toString().contains(
            'https://accept.paymobsolutions.com/api/acceptance/post_pay')) {
          debugPrint(l!.queryParameters['data.message']);
          if (l.queryParameters['data.message'] == 'Approved') {
            Loading().showloading(context);
            await Provider.of<CheckoutC>(context, listen: false).checkout(
                widget.mynet,
                widget.myval,
                widget.myselected_payment,
                widget.mycoupon,
                widget.mydate,
                format,
                context,
                '1',
                null);
            Provider.of<Cart>(context, listen: false).removeall(context);
            Provider.of<Getcategoryitems>(context, listen: false)
                .getitemscat(null, context, null, null, 0, null);
            final snackBar = SnackBar(
              content: Text(Translation.get('order-done')),
              backgroundColor: Colors.green,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Navigator.of(context).pushNamed(HomeScreen.routeName);
          } else {
            // AwesomeDialog(
            //     context: context,
            //     dismissOnTouchOutside: false,
            //     dismissOnBackKeyPress: false,
            //     dialogType: DialogType.ERROR,
            //     title: 'Error in Credit Card',
            //     btnOkColor: Colors.red,
            //     btnOkText: Translation.get('ok'),
            //     btnOkOnPress: () async {
            //       Navigator.of(context).pushNamed(HomeScreen.routeName);
            //     }).show();
          }
        }
      },
    ));
  }
}
