import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../consts/app_colors.dart';
import '../../../consts/app_text_styles/home_screen_text_style.dart';
import '../../../consts/app_text_styles/settings_text_style.dart';

import '../../../util/shared_pref_service.dart';

class StatisticScreen extends StatefulWidget {
  @override
  _StatisticScreenState createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  String selectedShop = '';
  int selectedDuration = 0;
  //List<CoffeeShop> coffeeShops = [];
  SharedPreferencesService sharedPrefs = SharedPreferencesService();

  @override
  void initState() {
    super.initState();
    // getCoffeeShopsFromSharedPrefs();
  }

  // void getCoffeeShopsFromSharedPrefs() async {
  //   List<CoffeeShop> shops = await sharedPrefs.getCoffeeShops();
  //   setState(() {
  //     coffeeShops = shops;
  //     if (coffeeShops.isNotEmpty) {
  //       selectedShop = coffeeShops[0].name;
  //     }
  //   });
  // }

  List<List<double>> _createBarChartData() {
    List<List<double>> data = List.generate(7, (index) => List.filled(3, 0.0));
    for (int i = 0; i < 7; i++) {
      for (int j = 0; j < 3; j++) {
        data[i][j] = Random().nextDouble() * 1000;
      }
    }

    return data;
  }
  //
  // double getSelectedShopIncome(String shopName) {
  //   CoffeeShop selectedShop =
  //       coffeeShops.firstWhere((shop) => shop.name == shopName);
  //   double income = selectedShop.calculateIncome();
  //   return income;
  // }

  @override
  Widget build(BuildContext context) {
    List<List<double>> barChartData = _createBarChartData();
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.height * 0.01),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Statistics',
                      style: SettingsTextStyle.title,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.height * 0.01),
                child: DropdownButton(
                  underline: Container(),
                  value: selectedShop,
                  // style: StatisticTextStyle.name,
                  items: []
                      .map((shop) => DropdownMenuItem(
                            key: Key(shop.name),
                            value: shop.name,
                            child: Text(shop.name),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      // selectedShop = value!;
                    });
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ToggleButtons(
                      borderRadius: BorderRadius.circular(10.0),
                      // selectedColor:
                      //     AppColors.darkGreyColor.withOpacity(0.06),
                      // color: AppColors.darkGreyColor.withOpacity(0.06),
                      // fillColor: AppColors.yellowColor,
                      onPressed: (int newIndex) {
                        setState(() {
                          selectedDuration = newIndex;
                        });
                      },
                      isSelected: List.generate(
                          3, (index) => index == selectedDuration),
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.08),
                          child: Text(
                            'Today',
                            // style: TextStyle(
                            //   fontWeight: FontWeight.w500,
                            //   color: selectedDuration == 0
                            //       ? AppColors.darkGreyColor
                            //       : AppColors.darkGreyColor
                            //           .withOpacity(0.4),
                            // ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.08),
                          child: Text(
                            'Week',
                            // style: TextStyle(
                            //   fontWeight: FontWeight.w500,
                            //   color: selectedDuration == 1
                            //       ? AppColors.darkGreyColor
                            //       : AppColors.darkGreyColor
                            //           .withOpacity(0.4),
                            // ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.08),
                          child: Text(
                            'Month',
                            // style: TextStyle(
                            //   fontWeight: FontWeight.w500,
                            //   color: selectedDuration == 2
                            //       ? AppColors.darkGreyColor
                            //       : AppColors.darkGreyColor
                            //           .withOpacity(0.4),
                            // ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Stack(
                    children: [
                      BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          maxY: barChartData.expand((list) => list).reduce(
                                  (value, element) =>
                                      value > element ? value : element) *
                              1.5,
                          barTouchData: BarTouchData(enabled: false),
                          titlesData: FlTitlesData(
                            bottomTitles: SideTitles(
                              showTitles: true,
                              // getTextStyles: (value) =>
                              // StatisticTextStyle.bottomTitle,
                              margin: 16,
                              getTitles: (double value) {
                                if (selectedDuration == 2) {
                                  // Month selected
                                  int monthValue = value.toInt() + 1;
                                  if (monthValue <= 4) {
                                    return 'W$monthValue';
                                  } else {
                                    return '';
                                  }
                                } else {
                                  return [
                                    'Mon',
                                    'Tue',
                                    'Wed',
                                    'Thu',
                                    'Fri',
                                    'Sat',
                                    'Sun'
                                  ][value.toInt()];
                                }
                              },
                            ),
                            leftTitles: SideTitles(
                              showTitles: false,
                            ),
                          ),
                          borderData: FlBorderData(show: false),
                          barGroups: List.generate(
                            selectedDuration == 2
                                ? 4
                                : 7, // Display 4 bars for Month
                            (index) => BarChartGroupData(
                              barsSpace: 0,
                              x: index,
                              barRods: [
                                BarChartRodData(
                                  y: barChartData[index].reduce(
                                      (value, element) =>
                                          value > element ? value : element),
                                  colors: [
                                    //  AppColors.yellowColor,
                                  ],
                                  width: 40,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.withOpacity(0.15),
                  ),
                  width: double.infinity,
                  height: size.height * 0.08,
                  // Color for the screen-wide container
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Text(
                        'Amount Balance',
                        //style: HomeScreenTextStyle.description,
                      ),
                      Spacer(),
                      Text(
                        '0.00\$',
                        //  style: HomeScreenTextStyle.descriptionAmount,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey.withOpacity(0.15),
                      ),
                      height: size.height * 0.08,
                      width: size.width * 0.44,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Income',
                              //  style: HomeScreenTextStyle.description,
                            ),
                            SizedBox(
                              width: size.width * 0.01,
                            ),
                            // Text(
                            //   '${getSelectedShopIncome(selectedShop).toStringAsFixed(2)}\$',
                            //   style: HomeScreenTextStyle.descriptionAmount,
                            // ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: size.width * 0.025),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey.withOpacity(0.15),
                      ),
                      height: size.height * 0.08,
                      width: size.width * 0.44,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Expenses',
                              //  style: HomeScreenTextStyle.description,
                            ),
                            SizedBox(
                              width: size.width * 0.01,
                            ),
                            Text(
                              '0.00\$',
                              // style: HomeScreenTextStyle.descriptionAmount,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
        // : Column(
        //     children: [
        //       Padding(
        //         padding:
        //             EdgeInsets.symmetric(horizontal: size.height * 0.018),
        //         child: const Row(
        //           mainAxisAlignment: MainAxisAlignment.start,
        //           children: [
        //             Text(
        //               'Statistics',
        //               style: SettingsTextStyle.title,
        //             ),
        //           ],
        //         ),
        //       ),
        //       SizedBox(
        //         height: size.height * 0.27,
        //       ),
        //       Center(child: Text('No coffee shop info yet')),
        //     ],
        //   ),
        );
  }
}
