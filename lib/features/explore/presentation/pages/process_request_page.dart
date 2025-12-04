import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mediecom/core/style/app_colors.dart';
import 'package:mediecom/core/style/app_text_styles.dart';
import 'package:mediecom/features/explore/presentation/widgets/confirmation_popup.dart';
import 'package:mediecom/features/user/presentation/blocs/profile/profile_bloc.dart';

class ProcessRequestPage extends StatefulWidget {
  static const path = '/process_request';
  final XFile prescriptionImage;
  const ProcessRequestPage({super.key, required this.prescriptionImage});

  @override
  State<ProcessRequestPage> createState() => _ProcessRequestPageState();
}

class _ProcessRequestPageState extends State<ProcessRequestPage> {
  int selectedOption = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colours.white,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_2),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is PrescriptionSuccess) {
            Navigator.of(context).push(
              PageRouteBuilder(
                opaque: false,
                barrierDismissible: true,
                pageBuilder: (_, __, ___) => PrescriptionUploadedPopup(),
              ),
            );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 22.h),

                Text(
                  "How would you like us to process your request?",
                  style: AppTextStyles.w600(16),
                ),

                SizedBox(height: 12.h),

                _optionTile(
                  index: 0,
                  title: "Order everything from the prescription",
                  subtitle:
                      "Our pharmacist will arrange medicines as per your prescription(s)",
                  icon: Icons.receipt_long_outlined,
                ),

                SizedBox(height: 12.h),

                _optionTile(
                  index: 1,
                  title: "Request pharmacist to call",
                  subtitle:
                      "Our pharmacist will call you to confirm the medicines you need",
                  icon: Iconsax.call,
                ),

                SizedBox(height: 40.h),

                Row(
                  children: [
                    Icon(Icons.bolt, color: Colors.orange, size: 22.sp),
                    SizedBox(width: 6.w),

                    RichText(
                      text: TextSpan(
                        style: AppTextStyles.w500(
                          14,
                        ).copyWith(color: Colors.black),
                        children: [
                          const TextSpan(text: "We will take about "),

                          TextSpan(
                            text: "4 minutes",
                            style: AppTextStyles.w600(
                              14,
                            ).copyWith(color: Colors.green),
                          ),

                          const TextSpan(text: " to \nprocess your request"),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 40.h),
                SizedBox(height: 22.h),

                Text(
                  "Your assigned pharmacist will make the following selections:",
                  style: AppTextStyles.w600(15).copyWith(color: Colors.black87),
                ),
                SizedBox(height: 12.h),

                _tickItem("Add medicines"),
                _tickItem("Apply best coupon"),
                _tickItem("Choose earliest delivery date"),

                SizedBox(height: 26.h),

                SizedBox(height: 150.h),
              ],
            ),
          ),
        ),
      ),

      bottomSheet: Container(
        color: Colours.primaryBackgroundColour,
        padding: EdgeInsets.all(18),
        height: 150.h,
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Icon(Icons.location_on_outlined, size: 22.sp),
                  SizedBox(width: 8.w),
                  Text("Delivering to", style: AppTextStyles.w500(15)),
                  SizedBox(width: 6.w),
                  Text(
                    "Bhilai",
                    style: AppTextStyles.w600(15).copyWith(color: Colors.black),
                  ),
                  const Spacer(),
                  Text(
                    "Add Address",
                    style: AppTextStyles.w600(
                      15,
                    ).copyWith(color: Colours.primaryColor),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.all(16.w),
              child: SizedBox(
                height: 48.h,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => context.read<ProfileBloc>().add(
                    UploadPrescriptionEvent(
                      file: File(widget.prescriptionImage.path),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colours.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    "Continue",
                    style: AppTextStyles.w600(
                      16,
                    ).copyWith(color: Colours.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // -----------------------------------------------------------------
  // WIDGETS
  // -----------------------------------------------------------------

  Widget _optionTile({
    required int index,
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    final selected = index == selectedOption;

    return GestureDetector(
      onTap: () => setState(() => selectedOption = index),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: selected ? Colours.primaryColor : Colors.grey.shade300,
            width: 1.4,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 20.w,
              height: 20.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? Colours.primaryColor : Colors.grey,
                  width: 2,
                ),
              ),
              child: selected
                  ? Center(
                      child: Container(
                        width: 10.w,
                        height: 10.h,
                        decoration: const BoxDecoration(
                          color: Colours.primaryColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  : null,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.w600(15)),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: AppTextStyles.w500(
                      13,
                    ).copyWith(color: Colors.black54),
                  ),
                ],
              ),
            ),
            Icon(
              icon,
              size: 26.sp,
              color: selected ? Colours.primaryColor : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _tickItem(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.green, size: 20.sp),
          SizedBox(width: 8.w),
          Text(text, style: AppTextStyles.w500(14)),
        ],
      ),
    );
  }
}
