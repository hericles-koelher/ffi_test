import 'package:flutter/material.dart';

import 'src/pages/home_page.dart';

void main() {
  runApp(const FFITest());
}

class FFITest extends StatelessWidget {
  const FFITest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}
