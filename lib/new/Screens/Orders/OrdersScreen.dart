import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Bloc/Orders/orders_bloc.dart';
import 'package:shakosh/new/Components/ScaffoldDesktop/ScaffoldDesktop.dart';
import 'package:shakosh/new/Components/ScaffoldMobile/ScaffoldMobile.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';
import 'package:shakosh/new/Screens/Orders/Components/DesktopBody.dart';
import 'package:shakosh/new/Screens/Orders/Components/MobileBody.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  static String routeName = "orders";

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> with RouteAware {
  @override
  void didPopNext() {
    BlocProvider.of<OrdersBloc>(context).add(FilterOrdersEvent());
    super.didPopNext();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    MyApp.routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void dispose() {
    MyApp.routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void initState() {
    BlocProvider.of<OrdersBloc>(context).add(GetOrdersEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (screenWidth > 768) {
      return ScaffoldDesktop(
        child: DesktopBody(),
      );
    } else {
      return ScaffoldMobile(
        screenName: "my-orders".tr,
        child: MobileBody(),
        index: -1,
      );
    }
  }
}
