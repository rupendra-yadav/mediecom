import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mediecom/core/common/app/cache_helper.dart';
import 'package:mediecom/core/common/singletons/cache.dart';
import 'package:mediecom/core/common/widgets/full_screen_loader.dart';
import 'package:mediecom/core/constants/api_constants.dart';
import 'package:mediecom/core/extentions/color_extensions.dart';
import 'package:mediecom/core/style/app_colors.dart';
import 'package:mediecom/features/auth/presentation/pages/splash_screen.dart';
import 'package:mediecom/features/orders/orders_injection.dart';
import 'package:mediecom/features/orders/presentation/pages/orders.dart';
import 'package:mediecom/features/user/data/models/user_model.dart';
import 'package:mediecom/features/user/domain/entities/user_entity.dart';
import 'package:mediecom/features/user/presentation/blocs/profile/profile_bloc.dart';
import 'package:mediecom/features/user/presentation/pages/update_profile.dart';
import 'package:mediecom/features/user/presentation/widgets/profile_shimmer.dart';

class ProfilePage extends StatefulWidget {
  static const path = '/profile';
  const ProfilePage({super.key});

  // Light theme colors inspired by common light modes
  static const Color _primaryLight = Color(0xFFF0F2F5); // Light grey background
  static const Color _cardBackground = Color(
    0xFFFFFFFF,
  ); // White card background
  static const Color _textColor = Color(0xFF212121); // Dark grey text
  static const Color _subtextColor = Color(0xFF757575); // Medium grey text
  static const Color _accentColor = Color(
    0xFF1E88E5,
  ); // A blue accent for active elements
  static const Color _iconColor = Color(0xFF616161);
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final cacheHelper = sl<CacheHelper>();
  @override
  void initState() {
    super.initState();
    final userId = cacheHelper.getUserId();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    context.read<ProfileBloc>().add(GetProfileEvent(userId: userId ?? ""));
    // });
  }

  // Medium grey icon color
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colours.primaryBackgroundColour, // Light primary background

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is ProfileLoaded) {
                  final UserEntity user = state.user;
                  cacheHelper.setIsLoggedIn(true);
                  cacheHelper.cacheUserId(state.user.m2Id ?? "");

                  cacheHelper.cacheUser(user as UserModel);
                  return _buildProfileImage(
                    user.m2Chk1 ?? "name",
                    user.m2Chk2 ?? "email",
                    user.m2Chk20 ?? "",
                  );
                } else if (state is ProfileLoading) {
                  // WidgetsBinding.instance.addPostFrameCallback((_) {
                  //   showDialog(
                  //     context: context,
                  //     barrierDismissible: false,
                  //     builder: (_) => const FullScreenLoader(),
                  //   );
                  // });

                  return ProfileShimmer();
                }
                return SizedBox.shrink();
              },
            ),

            SizedBox(height: 30),
            // Quick Info Cards
            // Row(
            //   children: [
            //     Expanded(
            //       child: _buildInfoCard(
            //         context,
            //         label: 'Total Orders',
            //         value: '12',
            //         icon: Icons.shopping_bag_outlined,
            //       ),
            //     ),
            //     const SizedBox(width: 16),
            //     Expanded(
            //       child: _buildInfoCard(
            //         context,
            //         label: 'Wishlist',
            //         value: '8 items',
            //         icon: Icons.favorite_border,
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(height: 32),

            // Profile Sections
            _buildSectionHeader('Account & Settings'),
            const SizedBox(height: 12),
            _buildProfileListItem(
              context,
              title: 'Personal Details',
              icon: Icons.account_circle_outlined,
              onTap: () => context.push(UpdateProfileScreen.path),
            ),
            _buildProfileListItem(
              context,
              title: 'Order History',
              icon: Icons.history,
              onTap: () => context.go(Orders.path),
            ),
            _buildProfileListItem(
              context,
              title: 'Delivery Addresses',
              icon: Icons.location_on_outlined,
              onTap: () => print('Delivery Addresses tapped!'),
            ),
            _buildProfileListItem(
              context,
              title: 'Payment Methods',
              icon: Icons.credit_card_outlined,
              onTap: () => print('Payment Methods tapped!'),
            ),
            const SizedBox(height: 22),

            // _buildSectionHeader('App Preferences'),
            // const SizedBox(height: 12),
            // _buildProfileListItem(
            //   context,
            //   title: 'Notifications',
            //   icon: Icons.notifications_none,
            //   onTap: () => print('Notifications tapped!'),
            // ),
            // _buildProfileListItem(
            //   context,
            //   title: 'Language',
            //   icon: Icons.language,
            //   onTap: () => print('Language tapped!'),
            //   trailingText: 'English',
            // ),
            // _buildProfileListItem(
            //   context,
            //   title: 'Security',
            //   icon: Icons.security,
            //   onTap: () => print('Security tapped!'),
            // ),
            // const SizedBox(height: 32),
            _buildSectionHeader('Support & Legal'),
            const SizedBox(height: 12),
            _buildProfileListItem(
              context,
              title: 'Help Center',
              icon: Icons.help_outline,
              onTap: () => print('Help Center tapped!'),
            ),
            _buildProfileListItem(
              context,
              title: 'Privacy Policy',
              icon: Icons.privacy_tip_outlined,
              onTap: () => print('Privacy Policy tapped!'),
            ),
            _buildProfileListItem(
              context,
              title: 'Terms of Service',
              icon: Icons.description_outlined,
              onTap: () => print('Terms of Service tapped!'),
            ),
            const SizedBox(height: 32),

            // Logout Button
            _buildProfileListItem(
              context,
              title: 'Log Out',
              icon: Icons.logout,
              onTap: () {
                cacheHelper.setIsLoggedIn(false);
                context.go('/');
              },
              isLogout: true,
            ),
            const SizedBox(height: 20),

            // App Version
            Align(
              alignment: Alignment.center,
              child: Text(
                'App Version 1.0.0',
                style: TextStyle(
                  color: ProfilePage._subtextColor.withOpacity(0.6),
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: ProfilePage._cardBackground, // White card background
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(
              0.1,
            ), // Subtle shadow for light theme
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: ProfilePage._accentColor, size: 24),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: ProfilePage._subtextColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: ProfilePage._textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colours.dark, // Muted color for section headers
        ),
      ),
    );
  }

  Widget _buildProfileImage(String name, String email, String imageUrl) {
    return Container(
      decoration: BoxDecoration(
        color: ProfilePage._cardBackground, // White card background
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(
              0.1,
            ), // Subtle shadow for light theme
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          children: [
            // User Avatar and Name
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.all(3), // thickness of the border
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colours.primaryColor, // border color
                    width: 4, // border width
                  ),
                ),
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colours.accentCoral.withOpacity(0.1),
                  backgroundImage: NetworkImage(
                    ApiConstants.profileBase + imageUrl,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: ProfilePage._textColor,
                  ),
                ),
                Text(
                  email,
                  style: TextStyle(
                    fontSize: 14,
                    color: ProfilePage._subtextColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileListItem(
    BuildContext context, {
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    String? trailingText,
    bool isLogout = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      decoration: BoxDecoration(
        color: ProfilePage._cardBackground, // White card background
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(
              0.1,
            ), // Subtle shadow for light theme
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: !isLogout
                ? Colours.primaryBackgroundColour
                : Colours.error.o10,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: isLogout ? Colors.red.shade400 : Colours.primaryColor,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: isLogout ? Colors.red.shade400 : ProfilePage._textColor,
          ),
        ),
        trailing: trailingText != null
            ? Text(
                trailingText,
                style: const TextStyle(
                  color: ProfilePage._subtextColor,
                  fontSize: 14,
                ),
              )
            : Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: !isLogout ? ProfilePage._subtextColor : Colours.white,
              ),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),
    );
  }
}
