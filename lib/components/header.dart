import 'package:flutter/material.dart';

class HeaderLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Center(
        child: Column(
          children: [
            Image.asset(
              'assets/images/halalify.png',
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.09,
              fit: BoxFit.contain,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: Image.asset(
                'assets/images/halalify_slogan.png',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.02,
                fit: BoxFit.contain,
              ),
            )
          ],
        ),
      ),
    ]);
  }
}
