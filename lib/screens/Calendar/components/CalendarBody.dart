import 'dart:convert';

import 'package:calendar/models/user.dart';
import 'package:calendar/screens/Settings/Settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CalendarBody extends StatefulWidget {
  const CalendarBody({super.key});

  @override
  State<CalendarBody> createState() => _CalendarBodyState();
}

class _CalendarBodyState extends State<CalendarBody> {
  late final WebViewController controller;
  var url = '';
  var user = '';
  var password = '';
  var loadingPercentage = 0;

  @override
  void initState() {
    super.initState();

    getUser();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          setState(() {
            loadingPercentage = 0;
          });
        },
        onProgress: (progress) {
          setState(() {
            loadingPercentage = progress;
          });
        },
        onPageFinished: (url) {
          setState(() {
            loadingPercentage = 100;
          });
        },
      ))
      ..loadRequest(
        Uri.parse('https://$url/apps/calendar/'),
        method: LoadRequestMethod.get,
        headers: <String, String>{
          'authorization':
              'Basic ${base64.encode(utf8.encode('$user:$password'))}'
        },
      );
  }

  getUser() async {
    final prefs = await SharedPreferences.getInstance();
    User authUser = User.fromJson(jsonDecode(prefs.getString('creds')!));
    url = authUser.url!;
    user = authUser.username!;
    password = authUser.password!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Row(
            children: [
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.replay_outlined))
            ],
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, Settings.route);
            },
            radius: 24,
            child: const Icon(Icons.more_vert),
          )
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: controller),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: 1000,
              height: 50,
              color: Colors.white,
              child: const Padding(
                padding: EdgeInsets.only(left: 170.0, top: 20),
                child: Text('Your Calendar'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
