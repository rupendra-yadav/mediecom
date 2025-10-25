import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediecom/core/extentions/color_extensions.dart';

class Orders extends StatelessWidget {
  static const path = '/order';
  const Orders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOrderId(),
            // Track Order Section
            Text(
              'Track Order',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 16),
            _buildTrackingTimeline(),
          ],
        ),
      ),
    );
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

  Widget _buildOrderId() {
    return // Order Summary Card
    Container(
      margin: const EdgeInsets.only(bottom: 24.0),
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
                Text(
                  'Order#: 999012',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.grey[800],
                  ),
                ),
                Text(
                  '17 oct 2025 15:30',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'Delivery estimated at 21',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 16),
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
