import 'package:flutter/material.dart';
import 'package:wisdom_pos_test/core/constants/space.dart';
import 'package:wisdom_pos_test/ui/widgets/button.dart';
import 'package:wisdom_pos_test/ui/widgets/check_box.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _body()),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const VButton(text: "Custom Button"),
          spaceVerticalLarge,
          VCheckbox(
            onChanged: (value) {},
          )
        ],
      ),
    );
  }
}
