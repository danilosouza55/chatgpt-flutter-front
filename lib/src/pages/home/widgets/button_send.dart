import 'package:flutter/material.dart';

class ButtonSend extends StatelessWidget {
  final TextEditingController inputCtrl;
  final FocusNode inputFN;
  final VoidCallback onPress;

  const ButtonSend({
    Key? key,
    required this.inputCtrl,
    required this.inputFN,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: inputFN,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.normal,
        letterSpacing: 1.2,
      ),
      onSubmitted: (value) {
        onPress();
      },
      controller: inputCtrl,
      decoration: InputDecoration(
        hintText: 'Digite aqui ...',
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        suffixIcon: IconButton(
          onPressed: onPress,
          icon: const Icon(Icons.send),
        ),
      ),
    );
  }
}
