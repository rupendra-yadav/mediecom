import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mediecom/core/style/app_text_styles.dart';
import 'package:mediecom/features/cart/presentation/pages/order_confirmation_page.dart';

class PaymentMethodPage extends StatefulWidget {
  static const path = '/payment-method';
  const PaymentMethodPage({super.key});

  @override
  State<PaymentMethodPage> createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  int selectedMethod = 0; // 0 = Online, 1 = COD

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0F4F6),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFE0F4F6),
        foregroundColor: Colors.black,
        title: Text("Payment Method", style: AppTextStyles.w600(16)),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),

      bottomNavigationBar: _buildBottomButton(),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Choose a payment method", style: AppTextStyles.w600(16)),

            const SizedBox(height: 16),

            _paymentCard(
              index: 0,
              icon: Icons.credit_card_rounded,
              title: "Online Payment",
              subtitle: "Credit/Debit Card, UPI, Net Banking",
            ),

            const SizedBox(height: 12),

            _paymentCard(
              index: 1,
              icon: Icons.wallet_rounded,
              title: "Cash on Delivery",
              subtitle: "Pay with cash upon delivery",
            ),

            const SizedBox(height: 16),

            _securePaymentBadge(),
            const SizedBox(height: 20),

            _priceDetails(),
          ],
        ),
      ),
    );
  }

  // ------------------------- PAYMENT CARD -------------------------

  Widget _paymentCard({
    required int index,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final isSelected = selectedMethod == index;

    return InkWell(
      onTap: () => setState(() => selectedMethod = index),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? Colors.teal : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 32, color: Colors.grey.shade700),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.w600(
                      16,
                    ).copyWith(color: Colors.grey.shade900),
                  ),
                  Text(
                    subtitle,
                    style: AppTextStyles.w500(
                      13,
                    ).copyWith(color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),

            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? Colors.teal : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  // ------------------------- SECURE PAYMENT -------------------------

  Widget _securePaymentBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.teal.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.verified_user, color: Colors.teal),
          const SizedBox(width: 8),
          Text(
            "100% Secure Payments",
            style: AppTextStyles.w600(15).copyWith(color: Colors.teal),
          ),
        ],
      ),
    );
  }

  // ------------------------- PRICE DETAILS -------------------------

  Widget _priceDetails() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Price Details", style: AppTextStyles.w700(17)),

          const SizedBox(height: 14),

          _priceRow("Subtotal", "₹450.00"),
          _priceRow("Delivery Fee", "₹50.00"),
          _priceRow("Discount", "-₹25.00", valueColor: Colors.green),

          const Divider(height: 28),

          _priceRow(
            "Total Amount",
            "₹475.00",
            isBold: true,
            valueColor: Colors.black,
          ),
        ],
      ),
    );
  }

  Widget _priceRow(
    String label,
    String value, {
    bool isBold = false,
    Color? valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyles.w500(14).copyWith(
              color: Colors.grey.shade700,
              fontWeight: isBold ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: (isBold ? AppTextStyles.w700(15) : AppTextStyles.w500(15))
                .copyWith(color: valueColor ?? Colors.black87),
          ),
        ],
      ),
    );
  }

  // ------------------------- BOTTOM BUTTON -------------------------

  Widget _buildBottomButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () => context.push(OrderConfirmationPage.path),
          child: Text(
            "Place Order (₹475.00)",
            style: AppTextStyles.w600(16).copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
