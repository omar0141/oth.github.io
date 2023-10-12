import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Bloc/Orders/orders_bloc.dart';
import 'package:shakosh/new/Components/ScaffoldDesktop/ScaffoldDesktop.dart';
import 'package:shakosh/new/Components/ScaffoldMobile/ScaffoldMobile.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';
import 'package:shakosh/new/Screens/OrderDetails/Components/Body.dart';

// ignore: must_be_immutable
class OrderDetailsScreen extends StatefulWidget {
  OrderDetailsScreen({super.key, required this.orderId});

  String orderId;
  static String routeName = "order/:Id";

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  void initState() {
    BlocProvider.of<OrdersBloc>(context)
        .add(GetOrderDetailsEvent(id: widget.orderId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (screenWidth > 768) {
      return ScaffoldDesktop(
        child: Body(
          orderId: widget.orderId,
        ),
      );
    } else {
      return ScaffoldMobile(
        screenName: "order-no".tr + ": " + widget.orderId,
        child: Body(
          orderId: widget.orderId,
        ),
        index: -1,
      );
    }
  }
}
