import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

Timer _timer;
String greeting = '';

class CallApiTimerScreen extends StatefulWidget {
  CallApiTimerScreen({Key key}) : super(key: key);

  @override
  NameState createState() => NameState();
}

class NameState extends State<CallApiTimerScreen> {
  ticketDetailRowLayout(var title, var val) {
    var objDetailBaselineTitle = {
      "type": "text",
      "text": title,
      "size": "sm",
      "color": "#AAAAAA",
      "weight": "bold",
      "flex": 2,
      "wrap": true,
      "contents": [],
    };

    var objDetailBaselineValue = {
      "type": "text",
      "text": val,
      "size": "sm",
      "color": "#666666",
      "flex": 4,
      "wrap": true,
      "align": "end",
      "contents": [],
    };

    var contentsList = [objDetailBaselineTitle, objDetailBaselineValue];

    var objDetailRow = {
      "type": "box",
      "layout": "baseline",
      "spacing": "sm",
      "contents": contentsList,
    };

    return objDetailRow;
  }

  selectTicketDetail() {
    var data = [];
    var title = [
      "Ticket No.",
      "Ticket Date",
      "Order No.",
      "Order Date",
      "Ship To",
      "Product Name",
      "Plant Name",
      "Order Qty.",
      "Ticket Qty.",
      "Driver Name",
      "Truck No.",
      "License Plate",
      "Leave Time",
      "Ship Condition",
      "Ticket Status"
    ];
    var arrVal = [
      "1011808270007",
      "24/10/2018",
      "S01P901-00000331",
      "27/08/2018",
      "320000106 SH_Name 105",
      "997525133500 WPROOF PMP 25MPa 25mm S120 25@7DWPC1",
      "cV101 RMX Plant 101",
      "78",
      "2",
      "Theary Theary_",
      "FS22",
      "51E00491",
      "16:54:43",
      "Delivery",
      "5"
    ];

    for (var i = 0; i < title.length; i++) {
      data.add(ticketDetailRowLayout(title[i], arrVal[i]));
    }

    var selectTicketDetailJson = data;
    return selectTicketDetailJson;
  }

  void callApi(var apiType) async {
    var url = "https://api.line.me/v2/bot/message/" + apiType;
    var accessToken2 =
        "s2l19GfGgdDnsbO9cidJGvlkKDvlT9MRiQla/SKo63c3Us7Tv/xKjLnkLnafX15C3U9N9AT5FiL/ARZHWhicfAqm7bSmB1TJWFAzYkBxgSdZbHVKMag6WdTUtnsb56UmvcwbxVq5WUiRzRfTcLTv9QdB04t89/1O/w1cDnyilFU=";
    var accessToken =
        "6DOzScAqBRwD/oRPwvMFua/SBvgLtXciCay4cwK10oTPA88R60mjeGdeW8NDL61dCJX2EtyHINFcj1DvY0mboZntH38a/fhTRI3rCaN4vDI/zWBCl0ze5K/AV2JoxoCwR9OZXj2Y7rHn6nABPwZMVwdB04t89/1O/w1cDnyilFU=";

    var userPushJson = jsonEncode({
      "to": "Uc1dd5c7730988280c6c7731980655f7a",
      "messages": [
        {
          "type": "flex",
          "altText": "Ticket Detail",
          "contents": {
            "type": "bubble",
            "body": {
              "type": "box",
              "layout": "vertical",
              "spacing": "sm",
              "contents": [
                {
                  "type": "text",
                  "text": "Ticket Detail",
                  "size": "xl",
                  "weight": "bold",
                  "color": "#B6961EFF",
                  "wrap": true,
                  "contents": [],
                },
                {"type": "separator"},
                {
                  "type": "box",
                  "layout": "vertical",
                  "spacing": "md",
                  "margin": "lg",
                  "contents": [
                    ticketDetailRowLayout('Ticket No.', '1011808270007'),
                    ticketDetailRowLayout('Ticket Date', '24/10/2018'),
                    ticketDetailRowLayout('Order No.', 'S01P901-00000331'),
                    ticketDetailRowLayout('Order Date', '27/08/2018'),
                    ticketDetailRowLayout('Ship To', '320000106 SH_Name 105'),
                    ticketDetailRowLayout('Product Name',
                        '997525133500 WPROOF PMP 25MPa 25mm S120 25@7DWPC1'),
                    ticketDetailRowLayout('Plant Name', 'cV101 RMX Plant 101'),
                    ticketDetailRowLayout('Order Qty.', '78'),
                    ticketDetailRowLayout('Ticket Qty.', '2'),
                    ticketDetailRowLayout('Driver Name', 'Theary Theary_'),
                    ticketDetailRowLayout('Truck No.', 'FS22'),
                    ticketDetailRowLayout('License Plate', '51E00491'),
                    ticketDetailRowLayout('Leave Time', '16:54:43'),
                    ticketDetailRowLayout('Ship Condition', 'Delivery'),
                    ticketDetailRowLayout('Ticket Status', '5'),
                  ],
                }
              ],
            },
          },
        }
      ],
    });
    var userMulticastJson = jsonEncode({
      "to": ["Ue415fadc8c8f6f08dda78bff57da7835"],
      // "Uc1dd5c7730988280c6c7731980655f7a"
      // "Ue415fadc8c8f6f08dda78bff57da7835"
      // "Uae4bfcada214d07661bb5a8779ad4fd3",
      "messages": [
        {"type": "text", "text": "Hi ${DateTime.now()}"}
      ],
    });
    var userJson = apiType == 'push' ? userPushJson : userMulticastJson;

    var res = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
      body: userJson,
    );

    if (res.statusCode != HttpStatus.ok) {
      print('Response: ${res.body}');
    }
    return;
  }

  void startTimer(var type) {
    if (type == 'start') {
      const second = Duration(seconds: 3);
      _timer = Timer.periodic(second, (timer) {
        setState(() {
          greeting = "${DateTime.now()}";
          print("${DateTime.now().second}");
        });
        callApi('push');
      });
    } else {
      _timer.cancel();
      setState(() {
        greeting = "Stop at ${DateTime.now()}";
        print("======= Stop at ${DateTime.now().second} =======");
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LINE Official Timer Tools'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Start Pressed จะ CALL API ทุกๆ 3 Second',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 50),
            Text(greeting),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                startTimer('start');
              },
              child: const Text('Start Timer'),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                startTimer('stop');
              },
              child: const Text('Stop'),
              style: ButtonStyle(),
            ),
          ],
        ),
      ),
    );
  }
}
