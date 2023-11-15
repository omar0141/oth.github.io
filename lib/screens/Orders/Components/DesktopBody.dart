import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakosh/Components/default_button.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/Bloc/Orders/orders_bloc.dart';
import 'package:shakosh/Config/Colors/ColorPalette.dart';
import 'package:shakosh/Config/Translations/Translation.dart';
import 'package:shakosh/Data/Models/OrderModel.dart';
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
                                    : screenWidth * 0.022,
                            columns:
                                ordersTableColumns(selectedStatus, statusTypes),
                            rows: [
                              if (state is OrdersLoading)
                                for (var i = 0; i < 10; i++)
                                  ordersTableShimmer()
                              else
                                for (var order in orders)
                                  ordersTableRow(order, context, statusTypes),
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

  List<DataColumn> ordersTableColumns(selectedStatus, statusTypes) {
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
      if (selectedStatus == statusTypes[0])
        DataColumn(
          label: Text(
            ''.tr,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
    ];
  }

  DataRow ordersTableRow(OrderModel order, context, statusTypes) {
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
          if (order.status == statusTypes[0])
            DataCell(Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              width: 60,
              height: 50,
              child: DefaultButton(
                backcolor: const Color.fromARGB(255, 224, 89, 79),
                text: "cancel".tr,
                press: () {
                  BlocProvider.of<OrdersBloc>(context)
                      .add(DeleteOrderEvent(id: order.id!));
                },
              ),
            )),
        ]);
  }

  DataRow ordersTableShimmer() {
    return DataRow(
        onSelectChanged: (value) {
          print(value);
        },
        cells: [
          for (var i = 0; i < 9; i++)
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
