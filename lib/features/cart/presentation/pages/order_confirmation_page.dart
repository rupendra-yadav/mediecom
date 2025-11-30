import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mediecom/core/style/app_colors.dart';
import 'package:mediecom/core/style/app_text_styles.dart';
import 'package:mediecom/features/explore/presentation/pages/home_screen.dart';
import 'package:mediecom/features/orders/presentation/pages/orders.dart';

class OrderConfirmationPage extends StatelessWidget {
  static const path = "/order-confirmation";

  const OrderConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0F4F6),

      body: SafeArea(
        child: Stack(
          children: [
            // MAIN CONTENT
            SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),

                  Text("Order Confirmation", style: AppTextStyles.w600(16)),

                  const SizedBox(height: 20),

                  CircleAvatar(
                    radius: 36,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.check,
                      size: 40,
                      color: Colors.green.shade600,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    "Order Placed\nSuccessfully!",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.w700(
                      22,
                    ).copyWith(color: Colors.black87),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "We've sent a confirmation and receipt to your email.",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.w500(
                      14,
                    ).copyWith(color: Colors.grey.shade700),
                  ),

                  const SizedBox(height: 25),

                  _detailTile(
                    icon: Icons.receipt_long,
                    title: "Order ID",
                    value: "112-3581321-9569019",
                    showCopy: true,
                  ),

                  const SizedBox(height: 16),

                  _detailTile(
                    icon: Icons.local_shipping_outlined,
                    title: "Estimated Delivery",
                    value: "Tomorrow, 25 July",
                    valueColor: Colors.green.shade700,
                    subtitle: "Shipping to 123 Health St, Wellness City",
                  ),

                  const SizedBox(height: 20),

                  _orderSummary(),

                  const SizedBox(height: 100),
                ],
              ),
            ),

            // CLOSE BUTTON
            Positioned(
              top: 10,
              right: 16,
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.close, size: 26),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: _bottomButtons(context),
    );
  }

  // ------------------------- ORDER SUMMARY -------------------------

  Widget _orderSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Order Summary", style: AppTextStyles.w600(17)),
          const SizedBox(height: 16),

          _itemRow(
            image: "https://i.imgur.com/TzWcihb.png", // replace with asset
            title: "Paracetamol 500mg Tablets",
          ),

          const SizedBox(height: 12),

          _itemRow(
            image: "https://i.imgur.com/w1XbjQ2.png", // replace with asset
            title: "Vitamin D3 Supplement",
          ),
        ],
      ),
    );
  }

  Widget _itemRow({required String image, required String title}) {
    return Row(
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: NetworkImage(image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(child: Text(title, style: AppTextStyles.w500(15))),
        Text(
          "x1",
          style: AppTextStyles.w500(15).copyWith(color: Colors.grey.shade600),
        ),
      ],
    );
  }

  // ------------------------- DETAIL TILES -------------------------

  Widget _detailTile({
    required IconData icon,
    required String title,
    required String value,
    String? subtitle,
    bool showCopy = false,
    Color? valueColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 32, color: Colors.grey.shade700),
          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.w500(
                    14,
                  ).copyWith(color: Colors.grey.shade700),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: AppTextStyles.w600(
                    15,
                  ).copyWith(color: valueColor ?? Colors.black),
                ),
                if (subtitle != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      subtitle,
                      style: AppTextStyles.w500(
                        13,
                      ).copyWith(color: Colors.grey.shade600),
                    ),
                  ),
              ],
            ),
          ),

          if (showCopy) Icon(Icons.copy, color: Colors.grey.shade600, size: 22),
        ],
      ),
    );
  }

  // ------------------------- BOTTOM BUTTONS -------------------------

  Widget _bottomButtons(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: const Color(0xFFE0F4F6),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // View Order Button
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () => context.go(Orders.path),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colours.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              child: Text(
                "View Order Details",
                style: AppTextStyles.w600(16).copyWith(color: Colors.white),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Continue Shopping Button
          SizedBox(
            width: double.infinity,
            height: 52,
            child: OutlinedButton(
              onPressed: () => context.go(HomeScreen.path),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colours.primaryColor, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              child: Text(
                "Continue Shopping",
                style: AppTextStyles.w600(
                  16,
                ).copyWith(color: Colours.primaryColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
