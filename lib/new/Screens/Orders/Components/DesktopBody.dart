import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Bloc/Orders/orders_bloc.dart';
import 'package:shakosh/new/Config/Colors/ColorPalette.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';
import 'package:shakosh/new/Data/Models/OrderModel.dart';
import 'package:shimmer/shimmer.dart';

class DesktopBody extends StatelessWidget {
  const DesktopBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersBloc, OrdersState>(
      builder: (context, state) {
        List<OrderModel> orders = state.orders;
        List<String> statusTypes =
            BlocProvider.of<OrdersBloc>(context).statusTypes;
        String selectedStatus = state.selectedStatus;
        return Container(
          height: screenHeight * 0.74,
          padding: const EdgeInsets.only(top: 20, bottom: 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 1,
                  child: Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (var status in statusTypes)
                          InkWell(
                            hoverColor: Colors.transparent,
                            borderRadius: BorderRadius.circular(5),
                            onTap: () {
                              BlocProvider.of<OrdersBloc>(context)
                                  .selectedStatus = status;
                              BlocProvider.of<OrdersBloc>(context)
                                  .add(FilterOrdersEvent());
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: selectedStatus == status
                                    ? colors(context).kprimaryColor
                                    : null,
                              ),
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        status.tr,
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: selectedStatus == status
                                                ? colors(context).whiteColor
                                                : colors(context)
                                                    .normalTextColor),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                      ],
                    ),
                  )),
              Expanded(
                  flex: 4,
                  child: ListView(
                    children: [
                      Card(
                        child: DataTable(
                            showCheckboxColumn: false,
                            columnSpacing:
                                (state is OrdersLoading || orders.isEmpty)
                                    ? screenWidth * 0.04
                                    : screenWidth * 0.024,
                            columns: ordersTableColumns,
                            rows: [
                              if (state is OrdersLoading)
                                for (var i = 0; i < 10; i++)
                                  ordersTableShimmer()
                              else
                                for (var order in orders)
                                  ordersTableRow(order, context),
                            ]),
                      ),
                    ],
                  )),
            ],
          ),
        );
      },
    );
  }

  List<DataColumn> get ordersTableColumns {
    return [
      DataColumn(
        label: Text(
          'order-id'.tr,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      DataColumn(
        label: Text(
          'date'.tr,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      DataColumn(
        label: Text(
          'total'.tr,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      DataColumn(
        label: Text(
          'total-tax'.tr,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      DataColumn(
        label: Text(
          'delivery-fees'.tr,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      DataColumn(
        label: Text(
          'net'.tr,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      DataColumn(
        label: Text(
          'address'.tr,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      DataColumn(
        label: Text(
          'status'.tr,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    ];
  }

  DataRow ordersTableRow(OrderModel order, context) {
    return DataRow(
        onSelectChanged: (value) {
          Navigator.of(context).pushNamed("order/${order.id}");
        },
        cells: [
          DataCell(
            Text(
              order.id ?? "",
            ),
          ),
          DataCell(Text(order.addstamp ?? "")),
          DataCell(Text(order.subAmount ?? "0.00")),
          DataCell(Text(order.taxAmount ?? "0.00")),
          DataCell(Text(order.shippingAmount ?? "0.00")),
          DataCell(Text(order.totalAmount ?? "0.00")),
          DataCell(Text(order.addressAddress1 ?? "")),
          DataCell(Text((order.status ?? "").tr)),
        ]);
  }

  DataRow ordersTableShimmer() {
    return DataRow(
        onSelectChanged: (value) {
          print(value);
        },
        cells: [
          for (var i = 0; i < 8; i++)
            DataCell(
              Shimmer(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 5,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2.5),
                              color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  gradient: shimmerGradientColor),
            ),
        ]);
  }
}
