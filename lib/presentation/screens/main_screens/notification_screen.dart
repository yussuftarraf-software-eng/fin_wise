import 'package:fin_wise/constants/my_colors.dart';
import 'package:fin_wise/presentation/custom_widgets/custom_main_app_container.dart';
import 'package:fin_wise/presentation/custom_widgets/custom_nav_bar.dart';
import 'package:fin_wise/presentation/custom_widgets/custom_notification_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../data/model/notification.dart';
import '../../custom_widgets/custom_text_poppins.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});
  final List<NotificationModel> notifications = [
    NotificationModel(
      id: '1',
      type: NotificationType.reminder,
      title: 'Reminder!',
      description: 'Set up your automatic savings to meet your savings goal...',
      dateTime: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        17,
        0,
      ),
    ),
    NotificationModel(
      id: '2',
      type: NotificationType.update,
      title: 'New Update',
      description: 'Set up your automatic savings to meet your savings goal...',
      dateTime: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        17,
        0,
      ),
    ),
    NotificationModel(
      id: '3',
      type: NotificationType.transaction,
      title: 'Transactions',
      description: 'A new transaction has been registered',
      dateTime: DateTime.now().subtract(const Duration(days: 1)),
      tags: const ['Groceries', 'Pantry'],
      amount: -100.00,
    ),
    NotificationModel(
      id: '4',
      type: NotificationType.reminder,
      title: 'Reminder!',
      description: 'Set up your automatic savings to meet your savings goal...',
      dateTime: DateTime.now().subtract(const Duration(days: 1)),
    ),
    NotificationModel(
      id: '5',
      type: NotificationType.expense,
      title: 'Expense Record',
      description: 'We recommend that you be more attentive to your finances.',
      dateTime: DateTime.now().subtract(const Duration(days: 5)),
    ),
    NotificationModel(
      id: '6',
      type: NotificationType.transaction,
      title: 'Transactions',
      description: 'A new transaction has been registered',
      dateTime: DateTime.now().subtract(const Duration(days: 5)),
      tags: const ['Food', 'Dinner'],
      amount: -70.40,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: myColors.mainGreen,
        title: CustomTextPoppins(
          text: "Notifications",
          fontWeight: .w600,
          fontSize: 20,
          color: myColors.lettersAndIcons,
        ),
        actions: [CustomNotificationButton(), Gap(36)],
      ),
      backgroundColor: myColors.mainGreen,
      body: CustomMainAppContainer(
        EdgeRaduis: 100,
        backgroundColor: myColors.backgroundGreenWhite,
        child: Column(children: [Gap(35)]),
      ),
    );
  }
}
