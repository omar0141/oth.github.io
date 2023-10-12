import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Bloc/Orders/orders_bloc.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';
import 'package:shakosh/new/Data/Models/OrderModel.dart';

class MobileBody extends StatelessWidget {
  const MobileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersBloc, OrdersState>(
      builder: (context, state) {
        List<OrderModel> orders = state.orders;
        List<String> statusTypes =
            BlocProvider.of<OrdersBloc>(context).statusTypes;
        String selectedStatus = state.selectedStatus;
        return Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 60,
              child: Center(
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    for (var status in statusTypes)
                      statusWidget(context, status, selectedStatus)
                  ],
                ),
              ),
            ),
            SizedBox(
              width: screenWidth * 0.95,
              height: screenHeight * 0.8,
              child: ListView(
                children: [
                  for (var order in orders) orderWidget(context, order)
                ],
              ),
            )
          ],
        );
      },
    );
  }

  Widget orderWidget(BuildContext context, OrderModel order) {
    return InkWell(
      borderRadius: BorderRadius.circular(5),
      onTap: () {
        Navigator.of(context).pushNamed("order/${order.id}");
      },
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border:
                Border.all(width: 1, color: colors(context).kprimaryColor!)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'order-id'.tr,
                    maxLines: 1,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Text(
                    'address'.tr,
                    maxLines: 1,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Text(
                    'total'.tr,
                    maxLines: 1,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    order.id ?? "",
                    maxLines: 1,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Text(
                    order.addressAddress1 ?? "",
                    maxLines: 1,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Text(
                    order.subAmount ?? "0.00",
                    maxLines: 1,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'total-tax'.tr,
                    maxLines: 1,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Text(
                    'delivery-fees'.tr,
                    maxLines: 1,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Text(
                    'net'.tr,
                    maxLines: 1,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    order.taxAmount ?? "0.00",
                    maxLines: 1,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Text(
                    order.shippingAmount ?? "0.00",
                    maxLines: 1,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Text(
                    order.totalAmount ?? "0.00",
                    maxLines: 1,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'date'.tr,
                    maxLines: 1,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    order.addstamp ?? "",
                    maxLines: 1,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  InkWell statusWidget(
      BuildContext context, String status, String selectedStatus) {
    return InkWell(
      hoverColor: Colors.transparent,
      borderRadius: BorderRadius.circular(5),
      onTap: () {
        BlocProvider.of<OrdersBloc>(context).selectedStatus = status;
        BlocProvider.of<OrdersBloc>(context).add(FilterOrdersEvent());
      },
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsetsDirectional.only(top: 10, bottom: 10, end: 10),
        decoration: BoxDecoration(
            color:
                selectedStatus == status ? colors(context).kprimaryColor : null,
            borderRadius: BorderRadius.circular(5),
            border:
                Border.all(width: 1, color: colors(context).kprimaryColor!)),
        child: Text(
          status.tr,
          style: TextStyle(
              color: selectedStatus == status
                  ? colors(context).whiteColor
                  : colors(context).normalTextColor),
        ),
      ),
    );
  }
}
