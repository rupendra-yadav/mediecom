import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediecom/core/extentions/color_extensions.dart';
import 'package:mediecom/core/style/app_colors.dart';
import 'package:mediecom/features/explore/presentation/widgets/gradient_appBar.dart';
import 'package:mediecom/features/orders/domain/entities/order_entity.dart';

class OrderTrackingPage extends StatelessWidget {
  static const path = '/order-tracking';
  final OrderEntity order;
  const OrderTrackingPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
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

    String formatOrderDate(String dateStr) {
      try {
        final date = DateTime.parse(dateStr);
        return '${date.day} ${_getMonthName(date.month)} ${date.year}';
      } catch (e) {
        return dateStr;
      }
    }

    String getOrderStatus(String status) {
      return switch (status) {
        '1' => 'Pending',
        '2' => 'Confirmed',
        '3' => 'Dispatched',
        '4' => 'Delivered',
        '5' => 'Cancelled',
        _ => 'Processing',
      };
    }

    String getPaidStatus(String status) {
      return switch (status) {
        '0' => 'Unpaid',
        '1' => 'Paid',
        '2' => 'Advance Paid',

        _ => 'Processing',
      };
    }

    Color getPaidStatusColor(String status) {
      return switch (status) {
        '0' => Colors.red, // unpaid
        '1' => Colors.green, // paid
        '2' => Colors.blueAccent, // advance
        _ => Colors.grey,
      };
    }

    Color getStatusColor(String status) {
      return switch (status) {
        '1' => Colors.orangeAccent, // pending
        '2' => Colors.blue, // confirmed
        '3' => Colors.deepPurple, // dispatched / in-transit
        '4' => Colors.green, // delivered
        '5' => Colors.red, // cancelled
        _ => Colors.grey, // default
      };
    }

    return Scaffold(
      appBar: GradientAppBar(
        name: "Order Tracking",
        address: "",
        isUserName: false,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width * 0.92,
        child: FloatingActionButton.extended(
          onPressed: () {},
          backgroundColor: Colours.primaryColor,
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          label: const Padding(
            padding: EdgeInsets.symmetric(vertical: 14),
            child: Text(
              "Contact Support",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 12.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black38.o10),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
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
                            color: Colours.dark,
                          ),
                        ),
                        SizedBox(width: 90),

                        // Spacer(),
                        if (order.f4Pm != null)
                          Text(
                            ' ${order.f4Pm}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Placed on ${formatOrderDate(order.f4Userdt ?? '')}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.grey[500],
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: getStatusColor(order.f4Bt ?? '').o10,
                            borderRadius: BorderRadius.circular(12),
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Colors.grey.withOpacity(
                            //       0.1,
                            //     ), // Subtle shadow for light theme
                            //     spreadRadius: 1,
                            //     blurRadius: 5,
                            //     offset: const Offset(0, 3),
                            //   ),
                            // ],
                          ),
                          child: Text(
                            getOrderStatus(order.f4Bt ?? ''),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: getStatusColor(order.f4Bt ?? ''),
                            ),
                          ),
                        ),

                        SizedBox(width: 10.w),

                        if (order.f4Ps != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: getPaidStatusColor(order.f4Ps ?? '').o10,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              getPaidStatus(order.f4Ps ?? ''),
                              // ' ${order.f4Ps}',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: getPaidStatusColor(order.f4Ps ?? ''),
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                      ],
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
              ),
            ),

            const SizedBox(height: 24),

            // ORDER STATUS TIMELINE
            _StatusTile(
              icon: Icons.check_circle,
              iconColor: Colors.blue,
              title: "Order Placed",
              subtitle: "Today, 2:10 PM",
              isActive: true,
              drawLine: true,
            ),
            _StatusTile(
              icon: Icons.check_circle,
              iconColor: Colors.blue,
              title: "Processing",
              subtitle: "Today, 2:12 PM",
              isActive: true,
              drawLine: true,
            ),
            _StatusTile(
              icon: Icons.check_circle,
              iconColor: Colors.blue,
              title: "Shipped",
              subtitle: "Today, 2:45 PM",
              isActive: true,
              drawLine: true,
            ),
            _StatusTile(
              icon: Icons.local_shipping_rounded,
              iconColor: Colors.blue,
              title: "Out for Delivery",
              subtitle: "Your order is on its way",
              isActive: true,
              drawLine: true,
              highlight: true,
            ),
            _StatusTile(
              icon: Icons.location_pin,
              iconColor: Colors.grey,
              title: "Delivered",
              subtitle: "",
              isActive: false,
              drawLine: false,
            ),

            const SizedBox(height: 24),

            // Text(
            //   "Live Location",
            //   style: textTheme.titleMedium?.copyWith(
            //     fontWeight: FontWeight.w600,
            //   ),
            // ),

            // const SizedBox(height: 12),

            // // LIVE LOCATION MOCK
            // Container(
            //   height: 220,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(16),
            //     color: Colors.grey.shade200,
            //     image: const DecorationImage(
            //       image: AssetImage("assets/map_sample.png"), // your map img
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            //   child: Stack(
            //     alignment: Alignment.bottomCenter,
            //     children: [
            //       Container(
            //         margin: const EdgeInsets.all(16),
            //         padding: const EdgeInsets.all(12),
            //         decoration: BoxDecoration(
            //           color: Colors.black.withOpacity(0.6),
            //           borderRadius: BorderRadius.circular(16),
            //         ),
            //         child: Row(
            //           children: [
            //             CircleAvatar(
            //               radius: 20,
            //               backgroundColor: Colors.white,
            //               child: Icon(Icons.person, color: Colors.blue),
            //             ),
            //             const SizedBox(width: 12),
            //             Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               mainAxisSize: MainAxisSize.min,
            //               children: [
            //                 Text(
            //                   "David R.",
            //                   style: textTheme.bodyMedium?.copyWith(
            //                     color: Colors.white,
            //                   ),
            //                 ),
            //                 Text(
            //                   "Your delivery partner",
            //                   style: textTheme.bodySmall?.copyWith(
            //                     color: Colors.white70,
            //                   ),
            //                 ),
            //               ],
            //             ),
            //             const Spacer(),
            //             CircleAvatar(
            //               backgroundColor: Colors.blue,
            //               child: Icon(Icons.phone, color: Colors.white),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),

            // const SizedBox(height: 32),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _StatusTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final bool isActive;
  final bool drawLine;
  final bool highlight;

  const _StatusTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.isActive,
    required this.drawLine,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            CircleAvatar(
              radius: highlight ? 20 : 16,
              backgroundColor: isActive
                  ? Colors.blue.shade100
                  : Colors.grey.shade300,
              child: Icon(icon, color: iconColor, size: highlight ? 22 : 18),
            ),
            if (drawLine)
              Container(width: 2, height: 50, color: Colors.grey.shade400),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme.titleMedium?.copyWith(
                    color: highlight ? Colors.blue : Colors.black,
                    fontWeight: highlight ? FontWeight.bold : FontWeight.w500,
                  ),
                ),
                if (subtitle.isNotEmpty)
                  Text(
                    subtitle,
                    style: textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:mediecom/core/style/app_colors.dart';

// class OrderTrackingPage extends StatefulWidget {
//   static const path = '/order-tracking';
//   const OrderTrackingPage({super.key});

//   @override
//   State<OrderTrackingPage> createState() => _OrderTrackingPageState();
// }

// class _OrderTrackingPageState extends State<OrderTrackingPage>
//     with TickerProviderStateMixin {
//   int currentStatusIndex = 3; // Example: 3 = out for delivery

//   late List<AnimationController> controllers;
//   late List<Animation<double>> fadeAnimations;
//   late List<Animation<double>> scaleAnimations;
//   late List<Animation<double>> lineAnimations;

//   final int totalSteps = 5;

//   @override
//   void initState() {
//     super.initState();

//     controllers = List.generate(
//       totalSteps,
//       (i) => AnimationController(
//         vsync: this,
//         duration: const Duration(milliseconds: 600),
//       ),
//     );

//     fadeAnimations = controllers
//         .map((c) => CurvedAnimation(parent: c, curve: Curves.easeOut))
//         .toList();

//     scaleAnimations = controllers
//         .map(
//           (c) => Tween<double>(
//             begin: 0.5,
//             end: 1.0,
//           ).animate(CurvedAnimation(parent: c, curve: Curves.easeOutBack)),
//         )
//         .toList();

//     lineAnimations = controllers
//         .map(
//           (c) => Tween<double>(
//             begin: 0,
//             end: 50,
//           ).animate(CurvedAnimation(parent: c, curve: Curves.easeInOut)),
//         )
//         .toList();

//     _playAnimations();
//   }

//   void _playAnimations() async {
//     for (int i = 0; i <= currentStatusIndex; i++) {
//       await controllers[i].forward();
//       await Future.delayed(const Duration(milliseconds: 150));
//     }
//   }

//   @override
//   void dispose() {
//     for (var c in controllers) {
//       c.dispose();
//     }
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final steps = [
//       "Order Placed",
//       "Processing",
//       "Shipped",
//       "Out for Delivery",
//       "Delivered",
//     ];

//     final subtitles = [
//       "Today, 2:10 PM",
//       "Today, 2:12 PM",
//       "Today, 2:45 PM",
//       "Your order is on the way",
//       "",
//     ];

//     final icons = [
//       Icons.check_circle,
//       Icons.check_circle,
//       Icons.check_circle,
//       Icons.local_shipping_rounded,
//       Icons.location_pin,
//     ];

//     return Scaffold(
//       appBar: AppBar(title: const Text("Order Tracking")),

//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       floatingActionButton: _buildSupportButton(context),

//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: List.generate(
//             steps.length,
//             (i) => _AnimatedStatusTile(
//               index: i,
//               icon: icons[i],
//               title: steps[i],
//               subtitle: subtitles[i],
//               controller: controllers[i],
//               fade: fadeAnimations[i],
//               scale: scaleAnimations[i],
//               lineHeight: lineAnimations[i],
//               isActive: i <= currentStatusIndex,
//               isCurrent: i == currentStatusIndex,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSupportButton(BuildContext context) {
//     return SizedBox(
//       width: MediaQuery.of(context).size.width * 0.92,
//       child: FloatingActionButton.extended(
//         onPressed: () {},
//         backgroundColor: Colours.primaryColor,
//         elevation: 6,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         label: const Padding(
//           padding: EdgeInsets.symmetric(vertical: 14),
//           child: Text(
//             "Contact Support",
//             style: TextStyle(
//               fontSize: 16,
//               color: Colors.white,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _AnimatedStatusTile extends StatelessWidget {
//   final int index;
//   final IconData icon;
//   final String title;
//   final String subtitle;
//   final AnimationController controller;
//   final Animation<double> fade;
//   final Animation<double> scale;
//   final Animation<double> lineHeight;
//   final bool isActive;
//   final bool isCurrent;

//   const _AnimatedStatusTile({
//     required this.index,
//     required this.icon,
//     required this.title,
//     required this.subtitle,
//     required this.controller,
//     required this.fade,
//     required this.scale,
//     required this.lineHeight,
//     required this.isActive,
//     required this.isCurrent,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Column(
//           children: [
//             ScaleTransition(
//               scale: scale,
//               child: CircleAvatar(
//                 radius: isCurrent ? 20 : 16,
//                 backgroundColor: isActive
//                     ? Colors.blue.shade100
//                     : Colors.grey.shade300,
//                 child: Icon(
//                   icon,
//                   size: isCurrent ? 22 : 18,
//                   color: isActive ? Colors.blue : Colors.grey,
//                 ),
//               ),
//             ),

//             /// Animated line
//             SizeTransition(
//               sizeFactor: fade,
//               axisAlignment: -1,
//               child: Container(
//                 width: 2,
//                 height: lineHeight.value,
//                 color: Colors.grey.shade400,
//               ),
//             ),
//           ],
//         ),

//         const SizedBox(width: 16),

//         Expanded(
//           child: FadeTransition(
//             opacity: fade,
//             child: Padding(
//               padding: const EdgeInsets.only(top: 4),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: TextStyle(
//                       color: isCurrent ? Colors.blue : Colors.black,
//                       fontWeight: isCurrent ? FontWeight.bold : FontWeight.w500,
//                     ),
//                   ),
//                   if (subtitle.isNotEmpty)
//                     Text(
//                       subtitle,
//                       style: TextStyle(color: Colors.grey.shade600),
//                     ),
//                   const SizedBox(height: 16),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
