import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restoranapp/provider/scheduling_provider.dart';

class SettingPage extends StatefulWidget {
  static const routeName = '/setting_page';
  
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Setting"),),
      body:Column(
        children: [
             ListTile(
              title: Text('Restaurant Notification'),
              trailing: Consumer<SchedulingProvider>(
               builder: (context, scheduled, _) {
                return Switch.adaptive(
                  value: scheduled.isScheduled,
                  onChanged: (value) async {
                    scheduled.scheduledNews(value);
                  },
                );
              },
            ),
            ),
        ],
      ) ,
    );
  }
}