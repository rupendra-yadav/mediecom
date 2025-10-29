import 'package:flutter/material.dart';
import 'package:mediecom/features/explore/presentation/widgets/gradient_appBar.dart';
import 'package:mediecom/features/notification/data/models/notification_model.dart';
import 'package:mediecom/features/notification/domain/entities/notif_entity.dart';

class NotificationPage extends StatefulWidget {
  static const path = '/notif-page';
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  // Sample notification list (replace with backend data later)
  List<NotifEntity> notifications = [
    // AppNotification(
    //   title: "Order Shipped 🚚",
    //   message: "Your order #1234 has been shipped!",
    //   time: DateTime.now().subtract(const Duration(minutes: 10)),
    //   imgUrl:
    //       "https://media.istockphoto.com/id/1388253782/photo/positive-successful-millennial-business-professional-man-head-shot-portrait.jpg?s=612x612&w=0&k=20&c=uS4knmZ88zNA_OjNaE_JCRuq9qn3ycgtHKDKdJSnGdY=",
    // ),
    // AppNotification(
    //   title: "Welcome 👋",
    //   message: "Thanks for joining our app!",
    //   time: DateTime.now().subtract(const Duration(hours: 2)),
    //   imgUrl:
    //       "https://media.istockphoto.com/id/1388253782/photo/positive-successful-millennial-business-professional-man-head-shot-portrait.jpg?s=612x612&w=0&k=20&c=uS4knmZ88zNA_OjNaE_JCRuq9qn3ycgtHKDKdJSnGdY=",
    // ),
    // AppNotification(
    //   title: "Discount Alert 💥",
    //   message: "Get 25% off on your next purchase.",
    //   time: DateTime.now().subtract(const Duration(days: 1)),
    //   imgUrl:
    //       "https://media.istockphoto.com/id/1388253782/photo/positive-successful-millennial-business-professional-man-head-shot-portrait.jpg?s=612x612&w=0&k=20&c=uS4knmZ88zNA_OjNaE_JCRuq9qn3ycgtHKDKdJSnGdY=",
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        isUserName: false,
        name: 'Notification',
        address: '',
      ),
      body: notifications.isEmpty
          ? const Center(
              child: Text(
                "No notifications yet.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.separated(
              itemCount: notifications.length,
              padding: const EdgeInsets.all(12),
              itemBuilder: (context, index) {
                final notif = notifications[index];
                return _buildNotificationTile(notif);
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider();
              },
            ),
    );
  }

  Widget _buildNotificationTile(NotifEntity notif) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      leading: CircleAvatar(
        backgroundColor: true ? Colors.grey.shade200 : Colors.blue.shade100,
        backgroundImage: NetworkImage(
          "https://media.istockphoto.com/id/1388253782/photo/positive-successful-millennial-business-professional-man-head-shot-portrait.jpg?s=612x612&w=0&k=20&c=uS4knmZ88zNA_OjNaE_JCRuq9qn3ycgtHKDKdJSnGdY=",
        ),
        // child: Image.network(notif.imgUrl),
      ),
      title: Text(
        notif.f4Txt1 ?? "Title",
        style: TextStyle(fontWeight: true ? FontWeight.w400 : FontWeight.w600),
      ),
      subtitle: Text(
        notif.f4Des1 ?? "Desc",
        style: const TextStyle(color: Colors.black54),
      ),
      trailing: Text(
        {notif.f4Userdt}.toString(),
        style: const TextStyle(fontSize: 12, color: Colors.grey),
      ),
      onTap: () {
        setState(() {
          // notif.isRead = true;
        });
      },
    );
  }
}
