import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/router/route.dart';

class DesignRouterScreen extends StatelessWidget {
  const DesignRouterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<GetPage<dynamic>> routes = AppRouter.pages;
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          const Center(
              child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text('Commonground Design Router'),
          )),
          ...List<Widget>.generate(
            routes.length,
            (int index) => ElevatedButton(
              onPressed: () => Get.toNamed(routes[index].name),
              child: Text(routes[index].name),
            ),
          ),
        ],
      ),
    );
  }
}
