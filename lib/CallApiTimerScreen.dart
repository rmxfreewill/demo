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
  ticketDetailRowLayout() {
    var objDetailRow;
    var objDetailBaselineTitle = [];
    var objDetailBaselineValue = [];

    // //Title
    // $objDetailBaselineTitle->type = "text";
    // $objDetailBaselineTitle->text = $title;
    // $objDetailBaselineTitle->size = "sm";
    // $objDetailBaselineTitle->color = "#AAAAAA";
    // $objDetailBaselineTitle->weight = "bold";
    // $objDetailBaselineTitle->flex = 2;
    // $objDetailBaselineValue->wrap = true;
    // $objDetailBaselineTitle->contents = [];

    // //Value
    // $objDetailBaselineValue->type = "text";
    // $objDetailBaselineValue->text = $val;
    // $objDetailBaselineValue->size = "sm";
    // $objDetailBaselineValue->color = "#666666";
    // $objDetailBaselineValue->flex = 4;
    // $objDetailBaselineValue->wrap = true;
    // $objDetailBaselineValue->align = "end";
    // $objDetailBaselineValue->contents = [];

    // $contentsList = [$objDetailBaselineTitle, $objDetailBaselineValue];

    // $objDetailRow->type = "box";
    // $objDetailRow->layout = "baseline";
    // $objDetailRow->spacing = "sm";
    // $objDetailRow->contents = $contentsList;

    objDetailRow = jsonEncode({
      "type": "box",
    });
    return objDetailRow;
  }

  pashJson() {
    //     $replyText["type"] = "flex";
    // $replyText["altText"] =  "Ticket Detail";
    // $replyText["contents"]["type"] = "bubble";
    // $replyText["contents"]["body"]["type"] = "box";
    // $replyText["contents"]["body"]["layout"] = "vertical";
    // $replyText["contents"]["body"]["spacing"] = "sm";
    // $replyText["contents"]["body"]["contents"] = $output;

    var replyText = jsonEncode({});

    return replyText;
  }

  void callApi(var apiType) async {
    var url = "https://api.line.me/v2/bot/message/" + apiType;
    var accessToken =
        "s2l19GfGgdDnsbO9cidJGvlkKDvlT9MRiQla/SKo63c3Us7Tv/xKjLnkLnafX15C3U9N9AT5FiL/ARZHWhicfAqm7bSmB1TJWFAzYkBxgSdZbHVKMag6WdTUtnsb56UmvcwbxVq5WUiRzRfTcLTv9QdB04t89/1O/w1cDnyilFU=";

    var userMulticastJson = jsonEncode({
      "to": ["Uae4bfcada214d07661bb5a8779ad4fd3"],
      "messages": [
        {"type": "text", "text": "Hi ${DateTime.now()}"}
      ],
    });

    var userPushJson = jsonEncode({
      "to": "Uae4bfcada214d07661bb5a8779ad4fd3",
      "messages": [
        {
          "type": "flex",
          "altText": "Ticket Detail",
          "contents": [

          ],
        }
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
