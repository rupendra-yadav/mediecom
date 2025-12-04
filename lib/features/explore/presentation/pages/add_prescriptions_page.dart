import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mediecom/core/style/app_colors.dart';
import 'package:mediecom/core/utils/utils.dart';
import 'package:mediecom/features/explore/presentation/pages/process_request_page.dart';

class UploadPrescriptionPage extends StatefulWidget {
  static const path = '/upload-prescription';

  const UploadPrescriptionPage({super.key});

  @override
  State<UploadPrescriptionPage> createState() => _UploadPrescriptionPageState();
}

class _UploadPrescriptionPageState extends State<UploadPrescriptionPage> {
  XFile? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colours.primaryBackgroundColour,

      /// Back Button
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10.h),

            /// Title
            Text(
              "Upload Prescriptions",
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 6.h),

            /// Subtitle
            Text(
              "and let us arrange your medicines for you",
              style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade700),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 50.h),

            buildImageSection(),

            SizedBox(height: 40.h),

            /// Green Upload Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: SizedBox(
                width: double.infinity,
                height: 55.h,
                child: _selectedImage == null
                    ? ElevatedButton(
                        onPressed: () async {
                          final XFile? image = await showImagePickerSheet(
                            context,
                            'Upload Prescription',
                          );
                          if (image != null) {
                            setState(() => _selectedImage = image);
                          }
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colours.primaryBackgroundColour,
                          side: const BorderSide(
                            color: Colours.primaryColor,
                            width: 2,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),

                        child: Text(
                          "Upload Prescription",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: Colours.primaryColor,
                          ),
                        ),
                      )
                    : ElevatedButton(
                        // onPressed: () => context.push(ProcessRequestPage.path),
                        onPressed: () => context.push(
                          ProcessRequestPage.path,
                          extra: _selectedImage,
                        ),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colours.primaryBackgroundColour,
                          side: const BorderSide(
                            color: Colours.primaryColor,
                            width: 2,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),

                        child: Text(
                          "Continue",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: Colours.primaryColor,
                          ),
                        ),
                      ),
              ),
            ),

            SizedBox(height: 20.h),

            /// Description Text
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                "All uploads are encrypted & visible only to our pharmacists. "
                "Any prescription you upload is validated before processing the order.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.grey.shade700,
                  height: 1.4,
                ),
              ),
            ),

            SizedBox(height: 10.h),

            /// Valid Prescription Link
            Text(
              "What is a valid prescription?",
              style: TextStyle(
                fontSize: 14.sp,
                color: Colours.primaryColor,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,
              ),
            ),

            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }

  Widget buildImageSection() {
    return _selectedImage != null
        ? ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: Image.file(
              File(_selectedImage!.path),
              width: 180.w,
              height: 180.w,
              fit: BoxFit.cover,
            ),
          )
        : Container(
            width: 180.w,
            height: 180.w,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Image.asset("assets/images/document.png", height: 100),
            ),
          );
  }
}
