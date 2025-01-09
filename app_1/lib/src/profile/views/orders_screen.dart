import 'package:app_1/common/utils/kcolors.dart';
import 'package:app_1/common/utils/kstrings.dart';
import 'package:app_1/common/widgets/app_style.dart';
import 'package:app_1/common/widgets/back_button.dart';
import 'package:app_1/common/widgets/reusable_text.dart';
import 'package:app_1/common/widgets/tab_widget.dart';
import 'package:app_1/src/orders/hooks/fetch_orders.dart';
import 'package:app_1/src/orders/widgets/orders_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersState();
}

class _OrdersState extends State<OrdersPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> orders = ["Đang chờ xử lý", "Đang giao hàng", "Đã giao"];
  final List<String> orderStatuses = ["pending", "shipping", "delivered"];
  final Set<int> reviewedOrders = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: orders.length, vsync: this);
    _tabController.addListener(() {
      setState(() {}); // Force rebuild to refresh OrdersList
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _markAsReviewed(int orderId) {
    setState(() {
      reviewedOrders.add(orderId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: ReusableText(
            text: AppText.kOrder,
            style: appStyle(15, Kolors.kPrimary, FontWeight.bold)),
      ),
      body: SizedBox.expand(
        child: Container(
          color: Kolors.kWhite,
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  dividerColor: Colors.transparent,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(28.r),
                      color: Kolors.kPrimary),
                  labelColor: Colors.white,
                  labelStyle: appStyle(12, Kolors.kWhite, FontWeight.normal),
                  unselectedLabelColor: Kolors.kGrayLight,
                  tabAlignment: TabAlignment.center,
                  tabs: List.generate(
                    orders.length,
                    (i) => TabWidget(text: orders[i]),
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: List.generate(orders.length, (index) {
                    return OrdersList(
                      status: orderStatuses[index],
                      key: ValueKey(orderStatuses[index]),
                      markAsReviewed: _markAsReviewed,
                      reviewedOrders: reviewedOrders,
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrdersList extends HookWidget {
  final String status;
  final Function(int) markAsReviewed;
  final Set<int> reviewedOrders;

  const OrdersList(
      {required this.reviewedOrders,
      Key? key,
      required this.status,
      required this.markAsReviewed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final results = fetchOrders(status);

    if (results.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (results.order == null || results.order!.isEmpty) {
      return const Center(
          child: Text('Không có đơn hàng nào ở trạng thái này.'));
    }

    return ListView.builder(
      itemCount: results.order!.length,
      itemBuilder: (context, index) {
        final order = results.order![index];
        //if (order == null) return const SizedBox.shrink();
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: OrdersTile(
            order: order,
            buttonType: "review",
            markAsReviewed: () => markAsReviewed(order.id),
            isReviewed: reviewedOrders.contains(order.id),
          ),
        );
      },
    );
  }
}
