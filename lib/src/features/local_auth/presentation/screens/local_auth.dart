import 'package:flutter/material.dart';
import 'package:todo_test/src/features/local_auth/utils/local_auth_service.dart';
import 'package:todo_test/src/routes/route_names.dart';

class LocalAuth extends StatelessWidget {
  const LocalAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    asyncMethod(context) async {
      final auth = await LocalAuthService.authenticate();
      if (auth) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          homeRoute,
          (route) => false,
        );
      }
    }

    asyncMethod(context);

    return Scaffold(
      body: Container(),
    );
  }
}
