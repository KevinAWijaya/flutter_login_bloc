import 'package:flutter/material.dart';
import 'package:wisdom_pos_test/core/color.dart';
import 'package:wisdom_pos_test/core/constants/space.dart';
import 'package:wisdom_pos_test/ui/widgets/button.dart';
import 'package:wisdom_pos_test/ui/widgets/button_loading.dart';
import 'package:wisdom_pos_test/ui/widgets/check_box.dart';
import 'package:wisdom_pos_test/ui/widgets/date_picker.dart';
import 'package:wisdom_pos_test/ui/widgets/input_text_riple.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _body(),
      ),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          VButton(
            text: "Custom Button",
            onPressed: () {
              setState(() {
                isLoading = !isLoading;
              });
            },
          ),
          spaceVerticalLarge,
          VButtonLoading(
            text: "Custom Button",
            onPressed: () {},
            isLoading: isLoading,
          ),
          spaceVerticalLarge,
          VCheckbox(
            isChecked: isLoading,
            onChanged: (value) {},
          ),
          spaceVerticalLarge,
          const VInputTextRiple(
            obscureText: true,
          ),
          spaceVerticalLarge,
          const VInputTextRiple(
            hint: "Password",
            prefixIcon: Icon(
              Icons.lock,
              color: VColor.secondary,
            ),
            isUseRipleEffect: true,
          ),
          spaceVerticalLarge,
          VDatePicker(
            initialDate: DateTime(2025, 1, 1),
            onDateSelected: (date) {
              print("Picked date: $date");
            },
          ),
          spaceVerticalLarge,
          spaceVerticalLarge,
          spaceVerticalLarge,
        ],
      ),
    );
  }
}
