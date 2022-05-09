import 'package:flutter/material.dart';
import 'package:long_time_no_notification/long_time_no_notification.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LongTimeNoNotification Demo Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _notification1(),
            _notification2(),
          ],
        ),
      ),
    );
  }

  Widget _notification1() {
    return FutureBuilder(
      future: LongTimeNoNotification.findBy('notification_1'),
      builder: (context, AsyncSnapshot<LongTimeNoNotification?> snapshot) {
        if (snapshot.data == null || snapshot.data!.shouldNotify()) {
          return Card(
            child: ListTile(
              title: const Text('Notification1'),
              subtitle: const Text('Not display forever once closed.'),
              trailing: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  setState(() {
                    LongTimeNoNotification.setForever(id: 'notification_1');
                  });
                },
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _notification2() {
    return FutureBuilder(
      future: LongTimeNoNotification.findBy('notification_2'),
      builder: (context, AsyncSnapshot<LongTimeNoNotification?> snapshot) {
        if (snapshot.data == null || snapshot.data!.shouldNotify()) {
          return Card(
            child: ListTile(
              title: const Text('Notification2'),
              subtitle: const Text('Display again in 7 days.'),
              trailing: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  setState(() {
                    LongTimeNoNotification.setDuration(id: 'notification_2', duration: const Duration(days: 7));
                  });
                },
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
