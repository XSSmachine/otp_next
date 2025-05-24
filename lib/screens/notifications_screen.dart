import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<NotificationItem> notifications = [
    NotificationItem(
      id: '1',
      title: 'Payment Received',
      description: 'You received €2,450.00 from KOMPANIJA D.O.O.',
      time: '2 minutes ago',
      type: NotificationType.payment,
      isRead: false,
      amount: '€2,450.00',
      sender: 'KOMPANIJA D.O.O.',
    ),
    NotificationItem(
      id: '2', 
      title: 'OTP Premium Banking',
      description: 'Ekskluzivne pogodnosti za Premium klijente - do 5% kamata na oročavanje',
      time: '1 hour ago',
      type: NotificationType.promo,
      isRead: false,
    ),
    NotificationItem(
      id: '3',
      title: 'Payment Received', 
      description: 'You received €850.50 from Marko Petrović',
      time: '3 hours ago',
      type: NotificationType.payment,
      isRead: true,
      amount: '€850.50',
      sender: 'Marko Petrović',
    ),
    NotificationItem(
      id: '4',
      title: 'OTP Mastercard Cashback',
      description: 'Iskoristite 10% cashback u partnerskim trgovinama tokom aprila',
      time: '5 hours ago', 
      type: NotificationType.promo,
      isRead: true,
    ),
    NotificationItem(
      id: '5',
      title: 'Payment Received',
      description: 'You received €1,200.00 from FREELANCE CLIENT LLC',
      time: '1 day ago',
      type: NotificationType.payment,
      isRead: true,
      amount: '€1,200.00',
      sender: 'FREELANCE CLIENT LLC',
    ),
    NotificationItem(
      id: '6',
      title: 'OTP Housing Loan',
      description: 'Posebna ponuda stambenih kredita - kamata od 3.2% godišnje',
      time: '1 day ago',
      type: NotificationType.promo,
      isRead: true,
    ),
    NotificationItem(
      id: '7',
      title: 'Payment Received',
      description: 'You received €325.75 from Ana Jovanović',
      time: '2 days ago',
      type: NotificationType.payment, 
      isRead: true,
      amount: '€325.75',
      sender: 'Ana Jovanović',
    ),
    NotificationItem(
      id: '8',
      title: 'OTP Mobile Banking',
      description: 'Nova verzija aplikacije je dostupna - dodane su nove funkcionalnosti',
      time: '3 days ago',
      type: NotificationType.info,
      isRead: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                for (var notification in notifications) {
                  notification.isRead = true;
                }
              });
            },
            child: const Text(
              'Mark all read',
              style: TextStyle(color: Color(0xFF7ED957)),
            ),
          ),
        ],
      ),
      body: notifications.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_none,
                    size: 64,
                    color: Colors.white30,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No notifications',
                    style: TextStyle(
                      color: Colors.white30,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: notifications.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return _buildNotificationCard(notification);
              },
            ),
    );
  }

  Widget _buildNotificationCard(NotificationItem notification) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: notification.isRead 
            ? const Color(0xFF2A2A2A)
            : const Color(0xFF2A2A2A).withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: notification.isRead 
              ? Colors.transparent 
              : const Color(0xFF7ED957).withOpacity(0.3),
          width: notification.isRead ? 0 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _getNotificationColor(notification.type).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  _getNotificationIcon(notification.type),
                  color: _getNotificationColor(notification.type),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notification.title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: notification.isRead 
                                  ? FontWeight.w500 
                                  : FontWeight.bold,
                            ),
                          ),
                        ),
                        if (!notification.isRead)
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Color(0xFF7ED957),
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      notification.time,
                      style: const TextStyle(
                        color: Colors.white60,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            notification.description,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
              height: 1.4,
            ),
          ),
          if (notification.type == NotificationType.payment && notification.amount != null)
            Container(
              margin: const EdgeInsets.only(top: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF7ED957).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFF7ED957).withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.account_balance_wallet,
                    color: Color(0xFF7ED957),
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Amount: ${notification.amount}',
                    style: const TextStyle(
                      color: Color(0xFF7ED957),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'From: ${notification.sender}',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          if (notification.type == NotificationType.promo)
            Container(
              margin: const EdgeInsets.only(top: 12),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Promo details will be sent to your email'),
                            backgroundColor: Color(0xFF7ED957),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF7ED957),
                        side: const BorderSide(color: Color(0xFF7ED957)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Learn More'),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  IconData _getNotificationIcon(NotificationType type) {
    switch (type) {
      case NotificationType.payment:
        return Icons.payment;
      case NotificationType.promo:
        return Icons.local_offer;
      case NotificationType.info:
        return Icons.info_outline;
    }
  }

  Color _getNotificationColor(NotificationType type) {
    switch (type) {
      case NotificationType.payment:
        return const Color(0xFF7ED957);
      case NotificationType.promo:
        return Colors.orange;
      case NotificationType.info:
        return Colors.blue;
    }
  }
}

class NotificationItem {
  final String id;
  final String title;
  final String description;
  final String time;
  final NotificationType type;
  bool isRead;
  final String? amount;
  final String? sender;

  NotificationItem({
    required this.id,
    required this.title,
    required this.description,
    required this.time,
    required this.type,
    this.isRead = false,
    this.amount,
    this.sender,
  });
}

enum NotificationType {
  payment,
  promo,
  info,
} 