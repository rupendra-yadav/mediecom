import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mediecom/core/extentions/color_extensions.dart';
import 'package:mediecom/core/style/app_colors.dart';
import 'package:mediecom/core/utils/utils.dart';
import 'package:mediecom/features/explore/presentation/widgets/gradient_appBar.dart';
import 'package:mediecom/features/orders/domain/entities/order_entity.dart';

class OrderTrackingPage extends StatefulWidget {
  static const path = '/order-tracking';
  final OrderEntity order;
  const OrderTrackingPage({super.key, required this.order});

  @override
  State<OrderTrackingPage> createState() => _OrderTrackingPageState();
}

class _OrderTrackingPageState extends State<OrderTrackingPage> {
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
      '0' => const Color(0xFFEF4444),
      '1' => const Color(0xFF10B981),
      '2' => const Color(0xFF3B82F6),
      _ => Colors.grey,
    };
  }

  Color getStatusColor(String status) {
    return switch (status) {
      '1' => const Color(0xFFF59E0B),
      '2' => const Color(0xFF3B82F6),
      '3' => const Color(0xFF8B5CF6),
      '4' => const Color(0xFF10B981),
      '5' => const Color(0xFFEF4444),
      _ => Colors.grey,
    };
  }

  int _getStatusStep(String? status) {
    return switch (status) {
      '1' => 0, // Pending
      '2' => 1, // Confirmed
      '3' => 2, // Dispatched
      '4' => 3, // Delivered
      '5' => -1, // Cancelled
      _ => 0,
    };
  }

  @override
  Widget build(BuildContext context) {
    final currentStep = _getStatusStep(widget.order.f4Bt);
    final isCancelled = widget.order.f4Bt == '5';

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: GradientAppBar(
        name: "Track Order",
        address: "address",
        isUserName: false,
        leading: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Order Summary Card
                  _buildOrderSummaryCard(),

                  SizedBox(height: 16.h),

                  // Tracking Timeline
                  if (!isCancelled) _buildTrackingTimeline(currentStep),

                  // Cancelled Message
                  if (isCancelled) _buildCancelledMessage(),

                  SizedBox(height: 100.h),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _buildSupportButton(context),
    );
  }

  Widget _buildOrderSummaryCard() {
    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order #${widget.order.f4No ?? 'N/A'}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      formatOrderDate(widget.order.f4Userdt ?? ''),
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              if (widget.order.f4Pm != null && widget.order.f4Pm!.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colours.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    widget.order.f4Pm!,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colours.primaryColor,
                    ),
                  ),
                ),
            ],
          ),

          SizedBox(height: 16.h),

          Divider(color: Colors.grey[200], thickness: 1),

          SizedBox(height: 16.h),

          // Amount Details
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Grand Total',
                    style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '₹${widget.order.f4Gtot ?? '0'}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                ],
              ),
              if (widget.order.f4Amt2 != null && widget.order.f4Amt2 != '0')
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Paid Amount',
                      style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '₹${widget.order.f4Amt2}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF10B981),
                      ),
                    ),
                  ],
                ),
            ],
          ),

          SizedBox(height: 16.h),

          Divider(color: Colors.grey[200], thickness: 1),

          SizedBox(height: 16.h),

          Row(
            children: [
              Expanded(
                child: _buildStatusBadge(
                  getOrderStatus(widget.order.f4Bt ?? ''),
                  getStatusColor(widget.order.f4Bt ?? ''),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildStatusBadge(
                  getPaidStatus(widget.order.f4Ps ?? ''),
                  getPaidStatusColor(widget.order.f4Ps ?? ''),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: color,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrackingTimeline(int currentStep) {
    final steps = [
      _TrackingStep(
        icon: Iconsax.tick_circle5,
        title: 'Order Placed',
        subtitle: formatOrderDate(widget.order.f4Userdt ?? ''),
        isCompleted: currentStep >= 0,
        isCurrent: currentStep == 0,
      ),
      _TrackingStep(
        icon: Iconsax.box_tick5,
        title: 'Order Confirmed',
        subtitle: 'Processing your order',
        isCompleted: currentStep >= 1,
        isCurrent: currentStep == 1,
      ),
      _TrackingStep(
        icon: Iconsax.truck_fast,
        title: 'Out for Delivery',
        subtitle: 'On the way to you',
        isCompleted: currentStep >= 2,
        isCurrent: currentStep == 2,
      ),
      _TrackingStep(
        icon: Iconsax.home_25,
        title: 'Delivered',
        subtitle: 'Order completed',
        isCompleted: currentStep >= 3,
        isCurrent: currentStep == 3,
      ),
    ];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Order Status',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A1A),
            ),
          ),
          SizedBox(height: 24.h),
          ...steps.asMap().entries.map((entry) {
            final index = entry.key;
            final step = entry.value;
            final isLast = index == steps.length - 1;
            return _buildTimelineItem(step, isLast);
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(_TrackingStep step, bool isLast) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: step.isCompleted
                    ? Colours.primaryColor
                    : Colors.grey[200],
                shape: BoxShape.circle,
                boxShadow: step.isCurrent
                    ? [
                        BoxShadow(
                          color: Colours.primaryColor.withOpacity(0.4),
                          blurRadius: 12,
                          spreadRadius: 2,
                        ),
                      ]
                    : null,
              ),
              child: Icon(
                step.icon,
                color: step.isCompleted ? Colors.white : Colors.grey[400],
                size: 24,
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 60.h,
                margin: EdgeInsets.symmetric(vertical: 4.h),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: step.isCompleted
                        ? [Colours.primaryColor, Colours.primaryColor]
                        : [Colors.grey[300]!, Colors.grey[200]!],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: 8.h, bottom: isLast ? 0 : 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: step.isCurrent
                        ? FontWeight.bold
                        : FontWeight.w600,
                    color: step.isCompleted
                        ? const Color(0xFF1A1A1A)
                        : Colors.grey[600],
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  step.subtitle,
                  style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCancelledMessage() {
    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFEF4444).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Iconsax.close_circle5,
              size: 64,
              color: Color(0xFFEF4444),
            ),
          ),
          SizedBox(height: 20.h),
          const Text(
            'Order Cancelled',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A1A),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'This order has been cancelled. If you have any questions, please contact our support team.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSupportButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      width: double.infinity,
      height: 56.h,
      child: ElevatedButton(
        onPressed: () => launchDialer("7000980233"),
        style: OutlinedButton.styleFrom(
          backgroundColor: Colours.primaryBackgroundColour,
          side: const BorderSide(color: Colours.primaryColor, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),

        child: Text(
          "Contact Support",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: Colours.primaryColor,
          ),
        ),
      ),
    );
  }
}

class _TrackingStep {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isCompleted;
  final bool isCurrent;

  _TrackingStep({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isCompleted,
    required this.isCurrent,
  });
}
