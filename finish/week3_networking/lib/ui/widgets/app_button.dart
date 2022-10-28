import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.onClick,
    required this.caption,
  }) : super(key: key);
  final String caption;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      child: ElevatedButton(
        onPressed: onClick,
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.resolveWith(
            (states) => Size(double.infinity, 52),
          ),
        ),
        child: Text(caption),
      ),
    );
  }
}
