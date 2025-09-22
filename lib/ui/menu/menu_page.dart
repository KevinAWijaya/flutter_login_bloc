import 'package:flutter/material.dart';
import 'package:wisdom_pos_test/core/constants/space.dart';
import 'package:wisdom_pos_test/ui/widgets/button.dart';
import 'package:wisdom_pos_test/ui/widgets/button_loading.dart';
import 'package:wisdom_pos_test/ui/widgets/check_box.dart';
import 'package:wisdom_pos_test/ui/widgets/input_text.dart';

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
          const VInputText(
            obscureText: true,
          ),
          spaceVerticalLarge,
          VInputText(
            hint: "Password",
            prefixIcon: const Icon(Icons.lock),
            suffixIcon: const Icon(Icons.visibility),
            onSuffixTap: () {},
            isUseRipleEffect: true,
          )
        ],
      ),
    );
  }
}
