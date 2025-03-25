import 'package:flutter/cupertino.dart';
import '/main.dart';
import '/config/options.dart';

class BTpage extends StatefulWidget {
  const BTpage({super.key});

  @override
  State<BTpage> createState() => _BTpageState();
}

bool isLoading = false;

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
                      value: OptionSettings.isBluetoothOn,
                      onChanged: (value){
                        setState(() {
                          if(OptionSettings.airplaneMode){

                          } else {
                            OptionSettings.isBluetoothOn = !OptionSettings.isBluetoothOn;
                            isLoading = true;
                            Future.delayed(Duration(milliseconds: 3000), () {
                              setState(() {
                                isLoading = false;
                              });
                            });
                          }

                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 4, 30, 12),
              child: Text(
                OptionSettings.airplaneMode
                    ? 'To enable Bluetooth, turn off Airplane Mode.'
                    : (!OptionSettings.isBluetoothOn
                    ? 'AirDrop, AirPlay, Find My, and Location Services use Bluetooth.'
                    : 'This iPhone is discoverable as "HJR iPhone" while Bluetooth Settings is open.'),
                style: TextStyle(fontSize: 16, color: CupertinoColors.systemGrey),
              ),
            ),
            if(OptionSettings.isBluetoothOn)
            CupertinoListSection.insetGrouped(
              header: Row(children: [
                SizedBox(width: 14,),
                Text('MY DEVICES', style: TextStyle(fontSize: 14, color: CupertinoColors.systemGrey, fontWeight: FontWeight.w100)),
                SizedBox(width: 14,),
                if(isLoading) CupertinoActivityIndicator()
              ],),
              children: isLoading ? [] : devices.map((device) {
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
            if(OptionSettings.isBluetoothOn)
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
