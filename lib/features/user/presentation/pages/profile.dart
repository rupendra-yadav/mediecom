import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
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
  static const Color _iconColor = Color(0xFF616161); // Medium grey icon color

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _primaryLight, // Light primary background

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileImage(),

            SizedBox(height: 30),
            // Quick Info Cards
            Row(
              children: [
                Expanded(
                  child: _buildInfoCard(
                    context,
                    label: 'Total Orders',
                    value: '12',
                    icon: Icons.shopping_bag_outlined,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildInfoCard(
                    context,
                    label: 'Wishlist',
                    value: '8 items',
                    icon: Icons.favorite_border,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Profile Sections
            _buildSectionHeader('Account & Settings'),
            const SizedBox(height: 12),
            _buildProfileListItem(
              context,
              title: 'Personal Details',
              icon: Icons.account_circle_outlined,
              onTap: () => print('Personal Details tapped!'),
            ),
            _buildProfileListItem(
              context,
              title: 'Order History',
              icon: Icons.history,
              onTap: () => print('Order History tapped!'),
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
            const SizedBox(height: 32),

            _buildSectionHeader('App Preferences'),
            const SizedBox(height: 12),
            _buildProfileListItem(
              context,
              title: 'Notifications',
              icon: Icons.notifications_none,
              onTap: () => print('Notifications tapped!'),
            ),
            _buildProfileListItem(
              context,
              title: 'Language',
              icon: Icons.language,
              onTap: () => print('Language tapped!'),
              trailingText: 'English',
            ),
            _buildProfileListItem(
              context,
              title: 'Security',
              icon: Icons.security,
              onTap: () => print('Security tapped!'),
            ),
            const SizedBox(height: 32),

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
              onTap: () => print('Log Out tapped!'),
              isLogout: true,
            ),
            const SizedBox(height: 20),

            // App Version
            Align(
              alignment: Alignment.center,
              child: Text(
                'App Version 1.0.0',
                style: TextStyle(
                  color: _subtextColor.withOpacity(0.6),
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
        color: _cardBackground, // White card background
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
          Icon(icon, color: _accentColor, size: 24),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: _subtextColor),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: _textColor,
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
          color: _subtextColor, // Muted color for section headers
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          // User Avatar and Name
          Align(
            alignment: Alignment.centerLeft,
            child: CircleAvatar(
              radius: 40,
              backgroundColor: _accentColor.withOpacity(
                0.1,
              ), // Light accent background for avatar
              child: Icon(
                Icons.person,
                size: 40,
                color: _accentColor, // Accent color for the icon
              ),
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Sofia Maria',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: _textColor,
                ),
              ),
              const Text(
                '8th June, Alaska, USA',
                style: TextStyle(fontSize: 14, color: _subtextColor),
              ),
            ],
          ),
          const SizedBox(height: 32),
        ],
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
        color: _cardBackground, // White card background
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
        leading: Icon(icon, color: isLogout ? Colors.red.shade400 : _iconColor),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: isLogout ? Colors.red.shade400 : _textColor,
          ),
        ),
        trailing: trailingText != null
            ? Text(
                trailingText,
                style: const TextStyle(color: _subtextColor, fontSize: 14),
              )
            : const Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: _subtextColor,
              ),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),
    );
  }
}
