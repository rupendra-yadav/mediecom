import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediecom/core/extentions/color_extensions.dart';
import 'package:mediecom/core/style/app_colors.dart';
import 'package:mediecom/features/orders/domain/entities/order_entity.dart';
import 'package:mediecom/features/orders/presentation/bloc/orders_bloc.dart';
import 'package:mediecom/features/orders/presentation/bloc/orders_event.dart';
import 'package:mediecom/features/orders/presentation/bloc/orders_state.dart';

class Orders extends StatefulWidget {
  static const path = '/order';
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  void initState() {
    super.initState();
    context.read<OrdersBloc>().add(const FetchOrderListEvent(userId: '2'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<OrdersBloc, OrdersState>(
        builder: (context, state) {
          return switch (state) {
            OrdersInitial() => const SizedBox(),
            OrdersLoading() => const Center(child: CircularProgressIndicator()),
            OrdersFailure(message: final message) => Center(
              child: Text(message, style: const TextStyle(color: Colors.red)),
            ),
            OrderListSuccess(orders: final orders) =>
              orders.isEmpty
                  ? const Center(
                      child: Text(
                        "No orders yet.",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  : SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: orders
                            .map((order) => _buildOrderId(order))
                            .toList(),
                      ),
                    ),
            _ => const SizedBox(), // Handle other states if needed
          };
        },
      ),
    );
    // Track Order Section
    // Text(
    //   'Track Order',
    //   style: TextStyle(
    //     fontWeight: FontWeight.bold,
    //     fontSize: 20,
    //     color: Colors.grey[800],
    //   ),
    // ),
    // const SizedBox(height: 16),
    // _buildTrackingTimeline(),
    //       ],
    //     ),
    //   ),
    // );
  }

  Widget _buildStarRating(int rating) {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: 18,
        );
      }),
    );
  }

  Widget _buildTrackingTimeline() {
    return Column(
      children: [
        _buildTimelineTile(
          icon: Icons.check_circle,
          title: 'Order Placed',
          subtitle: 'We have received your order on 20-Dec-2019',
          isFirst: true,
          isActive: true,
        ),
        _buildTimelineTile(
          icon: Icons.check_circle,
          title: 'Order Confirmed',
          subtitle: 'We have been confirmed on 20-Dec-2019',
          isActive: true,
        ),
        _buildTimelineTile(
          icon: Icons.refresh,
          title: 'Order Processed',
          subtitle: 'We are preparing your order',
          isActive: true, // Assuming this is the current active step
          color: Colors.green,
        ),
        _buildTimelineTile(
          icon: Icons.local_shipping,
          title: 'Ready to Ship',
          subtitle: 'Your order is ready for shipping',
          isActive: false,
        ),
        _buildTimelineTile(
          icon: Icons.delivery_dining,
          title: 'Out for Delivery',
          subtitle: 'Your order is out for delivery',
          isActive: false,
        ),
        _buildTimelineTile(
          icon: Icons.home,
          title: 'Delivered',
          subtitle: 'Your order has been delivered',
          isLast: true,
          isActive: false,
        ),
      ],
    );
  }

  String formatOrderDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return '${date.day} ${_getMonthName(date.month)} ${date.year}';
    } catch (e) {
      return dateStr;
    }
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }

  String getOrderStatus(String status) {
    return switch (status) {
      'P' => 'Pending',
      'C' => 'Confirmed',
      'D' => 'Delivered',
      'X' => 'Cancelled',
      _ => 'Processing',
    };
  }

  Color getStatusColor(String status) {
    return switch (status) {
      'P' => Colors.orange,
      'C' => Colors.blue,
      'D' => Colors.green,
      'X' => Colors.red,
      _ => Colors.grey,
    };
  }

  Widget _buildTimelineTile({
    required IconData icon,
    required String title,
    required String subtitle,
    bool isFirst = false,
    bool isLast = false,
    bool isActive = false,
    Color color = Colors.grey,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              if (!isFirst)
                Expanded(
                  child: Container(
                    width: 2.0,
                    color: isActive ? color : Colors.grey[300],
                  ),
                ),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: isActive ? color : Colors.grey[300],
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: Colors.white, size: 18),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2.0,
                    color: isActive ? color : Colors.grey[300],
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                top: isFirst ? 0 : 8.0,
                bottom: isLast ? 0 : 8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: isActive ? Colors.black : Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: isActive ? Colors.grey[700] : Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderId(OrderEntity order) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black38.o10),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Order#: ${order.f4No ?? ''}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colours.primaryColor,
                      ),
                    ),
                    SizedBox(width: 50),
                    Text(
                      formatOrderDate(order.f4Userdt ?? ''),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.grey[800],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Text(
                  getOrderStatus(order.f4Ps ?? ''),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: getStatusColor(order.f4Ps ?? ''),
                  ),
                ),
                const SizedBox(height: 8),
                if (order.f4Gtot != null)
                  Text(
                    'Total: ₹${order.f4Gtot}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Container(
                //       width: 80,
                //       height: 80,
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(8),
                //         image: const DecorationImage(
                //           image: AssetImage(
                //             'assets/kiwi_fruit.png',
                //           ), // Replace with your image asset
                //           fit: BoxFit.cover,
                //         ),
                //       ),
                //     ),
                //     const SizedBox(width: 16),
                //     Expanded(
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           const Text(
                //             'Kiwi Fruit',
                //             style: TextStyle(
                //               fontWeight: FontWeight.bold,
                //               fontSize: 16,
                //             ),
                //           ),
                //           const SizedBox(height: 4),
                //           Text(
                //             'Rs.180',
                //             style: TextStyle(color: Colors.grey[700], fontSize: 14),
                //           ),
                //           const SizedBox(height: 8),
                //           _buildStarRating(4), // Example rating
                //         ],
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
