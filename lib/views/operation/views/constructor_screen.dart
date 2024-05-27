import 'package:financ/consts/app_text_styles/home_screen_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../../../consts/app_colors.dart';
import '../../../consts/app_text_styles/settings_text_style.dart';
import '../../app/widgets/chosen_action_button_widget.dart';
import '../../app/widgets/input_widget.dart';
import '../widgets/dropdown_widget.dart';

class ConstructorScreen extends StatefulWidget {
  @override
  _ConstructorScreenState createState() => _ConstructorScreenState();
}

class _ConstructorScreenState extends State<ConstructorScreen> {
  final _amountController = TextEditingController();
  final _nameController = TextEditingController();
  String _operationType = 'Income';
  List<bool> _isSelected = [true, false];
  String _selectedCategory = '';
  final List<Map<String, dynamic>> _incomeCategories = [
    {'name': 'Salary', 'icon': 'assets/icons/salary.svg'},
    {'name': 'Dividends', 'icon': 'assets/icons/dividends.svg'},
    {'name': 'Investment', 'icon': 'assets/icons/investmentI.svg'},
    {'name': 'Rent', 'icon': 'assets/icons/rent.svg'},
    {'name': 'Freelance', 'icon': 'assets/icons/freelance.svg'},
    {'name': 'Business', 'icon': 'assets/icons/business.svg'},
  ];

  final List<Map<String, dynamic>> _spendingCategories = [
    {'name': 'Procurement', 'icon': 'assets/icons/procurement.svg'},
    {'name': 'Food', 'icon': 'assets/icons/food.svg'},
    {'name': 'Transport', 'icon': 'assets/icons/transport.svg'},
    {'name': 'Rest', 'icon': 'assets/icons/rest.svg'},
    {'name': 'Investment', 'icon': 'assets/icons/investmentE.svg'},
  ];

  void _toggleOperationType(int index) {
    setState(() {
      if (index == 0) {
        _operationType = 'Income';
        _isSelected = [true, false];
      } else {
        _operationType = 'Spendings';
        _isSelected = [false, true];
      }
    });
  }

  void _selectCategory(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  void _saveOperation() {
    try {
      final amount = double.tryParse(_amountController.text);

      if (_selectedCategory.isEmpty ||
          amount == null ||
          _nameController.text.isEmpty) {
        _showErrorSnackBar('Make sure you filled all the fields');
        debugPrint(
            'Validation failed: category, amount, or name of the operation is missing.');
        return;
      }

      final operation = {
        'name': _nameController.text,
        'description': _selectedCategory,
        'amount': amount,
        'type': _operationType,
      };

      Navigator.of(context).pop(operation);
    } catch (e) {
      _showErrorSnackBar('Make sure you filled all the fields');
      debugPrint('Error in _saveOperation: $e');
    }
  }

  void _showErrorSnackBar(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: AppColors.redColor),
      ),
      backgroundColor: AppColors.lightGreyColor,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void dispose() {
    _amountController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: -5,
        title: const Text(
          'Back',
          style: SettingsTextStyle.back,
        ),
        actions: [
          Text(
            'Add your info',
            style: SettingsTextStyle.title,
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: SvgPicture.asset(
            'assets/icons/leading.svg',
            width: size.width * 0.06,
            height: size.width * 0.06,
          ),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ToggleButtons(
                  isSelected: _isSelected,
                  onPressed: _toggleOperationType,
                  borderRadius: BorderRadius.circular(5.0),
                  selectedColor: AppColors.lightGreyColor,
                  fillColor: AppColors.lightGreyColor,
                  renderBorder: false,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.14,
                          vertical: size.height * 0.012),
                      decoration: BoxDecoration(
                          color: _isSelected[0]
                              ? AppColors.purpleColor
                              : AppColors.lightGreyColor,
                          borderRadius: _isSelected[0]
                              ? BorderRadius.only(
                                  topRight: Radius.circular(10.0),
                                  bottomRight: Radius.circular(10.0),
                                  topLeft: Radius.circular(10.0),
                                  bottomLeft: Radius.circular(10.0),
                                )
                              : BorderRadius.only(
                                  topRight: Radius.circular(0.0),
                                  bottomRight: Radius.circular(0.0),
                                  topLeft: Radius.circular(10.0),
                                  bottomLeft: Radius.circular(10.0),
                                )),
                      child: Text(
                        'Income',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: _isSelected[0]
                              ? Colors.white.withOpacity(0.35)
                              : Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.125,
                          vertical: size.height * 0.012),
                      decoration: BoxDecoration(
                          color: _isSelected[1]
                              ? AppColors.purpleColor
                              : AppColors.lightGreyColor,
                          borderRadius: _isSelected[1]
                              ? BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  bottomLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0),
                                  bottomRight: Radius.circular(10.0),
                                )
                              : BorderRadius.only(
                                  topLeft: Radius.circular(0.0),
                                  bottomLeft: Radius.circular(0.0),
                                  topRight: Radius.circular(10.0),
                                  bottomRight: Radius.circular(10.0),
                                )),
                      child: Text(
                        'Spendings',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: _isSelected[1]
                              ? Colors.white.withOpacity(0.35)
                              : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Container(
                height: size.height * 0.8,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    children: [
                      InputWidget(
                        controller: _nameController,
                        label: 'Enter operation name',
                      ),
                      SizedBox(height: 5),
                      InputWidget(
                        controller: _amountController,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        label: 'Enter amount',
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Wrap(
                          spacing: 8.0,
                          runSpacing: 2.0,
                          children: _operationType == 'Income'
                              ? _incomeCategories.map((category) {
                                  return GestureDetector(
                                    onTap: () =>
                                        _selectCategory(category['name']),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: size.width * 0.05,
                                        vertical: size.height * 0.015,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _selectedCategory ==
                                                category['name']
                                            ? AppColors.blueColor
                                            : AppColors.lightGreyColor,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          // mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SvgPicture.asset(
                                              category['icon'],
                                              color: _selectedCategory ==
                                                      category['name']
                                                  ? Colors.white
                                                  : AppColors.blackColor,
                                              width: size.width * 0.06,
                                              height: size.width * 0.06,
                                            ),
                                            SizedBox(width: size.width * 0.03),
                                            Text(
                                              category['name'],
                                              style: TextStyle(
                                                color: _selectedCategory ==
                                                        category['name']
                                                    ? Colors.white
                                                    : AppColors.blackColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList()
                              : _spendingCategories.map((category) {
                                  return GestureDetector(
                                    onTap: () =>
                                        _selectCategory(category['name']),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: size.width * 0.05,
                                        vertical: size.height * 0.015,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _selectedCategory ==
                                                category['name']
                                            ? AppColors.blueColor
                                            : AppColors.lightGreyColor,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                              category['icon'],
                                              color: _selectedCategory ==
                                                      category['name']
                                                  ? Colors.white
                                                  : AppColors.blackColor,
                                              width: size.width * 0.06,
                                              height: size.width * 0.06,
                                            ),
                                            SizedBox(width: size.width * 0.03),
                                            Text(category['name'],
                                                style: HomeScreenTextStyle
                                                    .bannerIncome),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      ChosenActionButton(
                        text: 'Make an entry',
                        onTap: _saveOperation,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
