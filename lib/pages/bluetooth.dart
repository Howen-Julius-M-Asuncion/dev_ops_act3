import 'package:flutter/cupertino.dart';
import '/main.dart';
import '/config/options.dart';

class BTpage extends StatefulWidget {
  const BTpage({super.key});

  @override
  State<BTpage> createState() => _BTpageState();
}

class _BTpageState extends State<BTpage> {

  List<Map<String, dynamic>> devices = [
    {'name': 'Apple Watch', 'isConnected': true},
    {'name': 'Niemann\'s Chess Pawn', 'isConnected': false},
    {'name': 'JBL Speaker', 'isConnected': false},
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.secondarySystemBackground,
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoNavigationBarBackButton(
          previousPageTitle: 'Settings',
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        middle: Text('Bluetooth', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 8,),
            Form(
              child: CupertinoFormSection.insetGrouped(
                margin: EdgeInsets.all(14),
                children: [
                  CupertinoListTile(
                    title: Text('Bluetooth'),
                    trailing: CupertinoSwitch(
                      value: true,
                      onChanged: (value){
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 4, 30, 12),
              child: Text('This iPhone is discoverable as "iPhone" while Bluetooth Settings is open.', style: TextStyle(fontSize: 14, color: CupertinoColors.systemGrey)),
            ),
            CupertinoListSection.insetGrouped(
              header: Row(children: [
                SizedBox(width: 14,),
                Text('MY DEVICES', style: TextStyle(fontSize: 14, color: CupertinoColors.systemGrey, fontWeight: FontWeight.w100)),
                SizedBox(width: 14,),
                CupertinoActivityIndicator()
              ],),
              children: devices.map((device) {
                return CupertinoListTile(
                  title: Text(device['name']),
                  additionalInfo: Text(
                    device['isConnected'] ? 'Connected' : 'Not Connected',
                  ),
                  trailing: CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Icon(CupertinoIcons.info_circle),
                    onPressed: () {},
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 18,),
            CupertinoListSection.insetGrouped(
              header: Row(children: [
                SizedBox(width: 14,),
                Text('OTHER DEVICES', style: TextStyle(fontSize: 14, color: CupertinoColors.systemGrey, fontWeight: FontWeight.w100)),
                SizedBox(width: 14,),
                CupertinoActivityIndicator()
              ],),
              children: []
            ),
          ],
        ),
      ),
    );
  }
}
