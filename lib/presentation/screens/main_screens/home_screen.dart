import 'dart:ffi';

import 'package:fin_wise/presentation/custom_widgets/custom_main_app_container.dart';
import 'package:fin_wise/presentation/custom_widgets/custom_nav_bar.dart';
import 'package:fin_wise/presentation/custom_widgets/custom_text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/my_colors.dart';
import '../../../data/model/transaction.dart';
import '../../custom_widgets/custom_notification_button.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double totalBalance = 1000;

  double totalExpense = 1000;

  List<String> timeFrames = ['Daily', 'Weekly', 'Monthly', 'Yearly'];

  int isTimeFrameSelected = 2;
  final List<Transaction> transactions = [
    Transaction(
      title: 'Salary',
      category: 'Monthly',
      dateTime: DateTime(2026, 4, 30, 18, 27),
      amount: 4000.00,
      icon: Icons.layers_outlined,
      iconBackgroundColor: const Color(0xFF7EB2F5),
    ),
    Transaction(
      title: 'Groceries',
      category: 'Pantry',
      dateTime: DateTime(2026, 4, 24, 17, 0),
      amount: -100.00,
      icon: Icons.shopping_bag_outlined,
      iconBackgroundColor: const Color(0xFF3A7BD5),
    ),
    Transaction(
      title: 'Rent',
      category: 'Rent',
      dateTime: DateTime(2026, 4, 15, 8, 30),
      amount: -674.40,
      icon: Icons.vpn_key_outlined,
      iconBackgroundColor: const Color(0xFF1E5FD9),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myColors().mainGreen,
      body: Column(
        children: [
          Gap(60),
          //welcome message and notification button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: .start,
                  children: [
                    CustomTextPoppins(
                      text: 'Hi,Welcome Back',
                      fontWeight: .w600,
                      fontSize: 20,
                      color: myColors().lettersAndIcons,
                    ),
                    Text(
                      "Good Morning",
                      style: GoogleFonts.leagueSpartan(
                        fontSize: 14,
                        color: myColors().lettersAndIcons,
                      ),
                    ),
                  ],
                ),
                Spacer(),

                //notification button
                CustomNotificationButton(),
              ],
            ),
          ),
          Gap(41),
          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 60),
            child: Column(
              children: [
                //total balance and total expense row
                Row(
                  children: [
                    //total balance
                    Column(
                      children: [
                        Row(
                          children: [
                            // arrow up svg
                            SvgPicture.asset("assets/svgs/arrowup.svg"),
                            Gap(6),
                            CustomTextPoppins(
                              text: 'Total Balance',
                              fontWeight: .normal,
                              fontSize: 12,
                              color: myColors().lettersAndIcons,
                            ),
                          ],
                        ),
                        CustomTextPoppins(
                          text: "\$ ${totalBalance}",
                          fontWeight: .bold,
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    // divider
                    Gap(39),
                    Container(width: 1, height: 42, color: Colors.white),
                    Gap(39),
                    //total Expense
                    Column(
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset("assets/svgs/arrowdown.svg"),
                            Gap(6),
                            CustomTextPoppins(
                              text: "Total Expense",
                              fontWeight: .normal,
                              fontSize: 12,
                              color: myColors().lettersAndIcons,
                            ),
                          ],
                        ),
                        CustomTextPoppins(
                          text: "\$ ${totalExpense}",
                          fontWeight: .bold,
                          fontSize: 24,
                          color: Color(0xff0068FF),
                        ),
                      ],
                    ),
                  ],
                ),
                //should be the circular container in design
                Gap(49),
                // your expenses message
                Row(
                  children: [
                    SvgPicture.asset("assets/svgs/check.svg"),
                    Gap(10),
                    CustomTextPoppins(
                      text: "30% of your expenses, looks good.",
                      fontWeight: .normal,
                      fontSize: 15,
                      color: myColors().lettersAndIcons,
                    ),
                  ],
                ),
                Gap(32),
              ],
            ),
          ),
          CustomMainAppContainer(
            EdgeRaduis: 100,
            backgroundColor: myColors().backgroundGreenWhite,
            child: Column(
              children: [
                Gap(33),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 37),
                  child: Column(
                    children: [
                      //mini dashboard container
                      Container(
                        width: 357,
                        height: 152,
                        decoration: BoxDecoration(
                          color: myColors().mainGreen,
                          borderRadius: BorderRadius.circular(31),
                        ),
                        child: Row(
                          children: [
                            Gap(36),
                            Column(children: []),
                            Gap(33),
                            //divider
                            Container(
                              height: 108,
                              width: 1,
                              color: Colors.white,
                            ),

                            Column(children: []),
                          ],
                        ),
                      ),
                      Gap(26),

                      // select time frame day,week and month
                      Container(
                        clipBehavior: Clip.antiAlias,
                        width: 358,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Color(0xffDFF7E2),
                          borderRadius: BorderRadius.circular(31),
                        ),
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics(),
                          ),
                          scrollDirection: .horizontal,
                          child: Row(
                            children: [
                              ...List.generate(timeFrames.length, (index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12.5,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isTimeFrameSelected = index;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(19),
                                        color: isTimeFrameSelected == index
                                            ? myColors().mainGreen
                                            : Color(0xffDFF7E2),
                                      ),
                                      width: 95,
                                      height: 50,
                                      child: Center(
                                        child: CustomTextPoppins(
                                          text: timeFrames[index],
                                          fontWeight: .normal,
                                          fontSize: 15,
                                          color: myColors().lettersAndIcons,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                      Gap(24),
                      //transaction list
                      ...List.generate(transactions.length, (index) {
                        final transaction = transactions[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Row(
                            children: [
                              //icon and background color
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(22),
                                  color: transaction.iconBackgroundColor,
                                ),
                                width: 57,
                                height: 53,
                                child: Center(
                                  child: Icon(transaction.icon, size: 25),
                                ),
                              ),
                              Gap(16),
                              //title and date
                              Column(
                                crossAxisAlignment: .start,
                                children: [
                                  CustomTextPoppins(
                                    text: transaction.title,
                                    fontWeight: .w600,
                                    fontSize: 15,
                                    color: myColors().lettersAndIcons,
                                  ),
                                  Gap(2.5),
                                  CustomTextPoppins(
                                    text: transaction.formattedDateTime,
                                    fontWeight: .w600,
                                    fontSize: 12,
                                    color: Color(0xff0068FF),
                                  ),
                                ],
                              ),
                              Gap(10),
                              //divider
                              Container(
                                width: 1,
                                height: 35,
                                color: Color(0xff00D09E),
                              ),
                              Gap(10),
                              //category
                              Container(
                                width: 65,
                                child: CustomTextPoppins(
                                  text: transaction.category,
                                  fontWeight: .w400,
                                  fontSize: 13,
                                  color: myColors().lettersAndIcons,
                                ),
                              ),
                              //divider
                              Container(
                                width: 1,
                                height: 35,
                                color: Color(0xff00D09E),
                              ),
                              Gap(10),
                              CustomTextPoppins(
                                text: transaction.formattedAmount,
                                fontWeight: .w600,
                                fontSize: 15,
                                color: transaction.amount > 0
                                    ? Color(0xff052224)
                                    : myColors().oceanBlueButton,
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                Spacer(),
                CustomNavBar(isPageSelected: 0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
