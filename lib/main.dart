
import 'package:flutter/cupertino.dart';

void main() => runApp(CupertinoApp(
  theme: CupertinoThemeData(
    brightness: Brightness.light,
  ),
  debugShowCheckedModeBanner: false,
  home: MyApp(),
));

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool airplaneMode = false;

  bool isWifiOn = true;
  bool isBluetoothOn = true;
  bool isHotspotOn = true;

  bool previousWifiState = false;
  bool previousBluetoothState = false;
  bool previousHotspotState = false;
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Settings', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        child: SafeArea(
            child: Column(
              children: [
                Expanded(
                    child: ListView(
                      children: [
                        CupertinoListTile(
                          title: Text('Airplane Mode'),
                          leading: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: CupertinoColors.systemOrange),
                              child: Icon(CupertinoIcons.airplane, color: CupertinoColors.white)
                          ),
                          leadingSize: 32,
                          trailing: CupertinoSwitch(
                              value: airplaneMode,
                              onChanged: (value) {
                                setState(() {
                                  airplaneMode = value;
                                  if(airplaneMode){
                                    // store previous states
                                    previousBluetoothState = isBluetoothOn;
                                    previousWifiState = isWifiOn;
                                    previousHotspotState = isHotspotOn;

                                    isBluetoothOn = false;
                                    isWifiOn = false;
                                  }else{
                                    isBluetoothOn = previousBluetoothState;
                                    isWifiOn = previousWifiState;
                                  }
                                });
                              }),
                        ),
                        CupertinoListTile(
                          title: Text('WiFi'),
                          leading: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: CupertinoColors.systemBlue),
                              child: Icon(CupertinoIcons.wifi, color: CupertinoColors.white)
                          ),
                          leadingSize: 32,
                          additionalInfo: Text(isWifiOn ? 'HJR Wifi' : 'Off'),
                          trailing: Icon(CupertinoIcons.chevron_forward, color: CupertinoColors.systemGrey2),
                          onTap: () {},
                        ),
                        CupertinoListTile(
                          title: Text('Bluetooth'),
                          leading: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: CupertinoColors.systemBlue),
                              child: Icon(CupertinoIcons.bluetooth, color: CupertinoColors.white)
                          ),
                          leadingSize: 32,
                          additionalInfo: Text(isBluetoothOn ? 'On' : 'Off'),
                          trailing: Icon(CupertinoIcons.chevron_forward, color: CupertinoColors.systemGrey2),
                          onTap: (){},
                        ),
                        CupertinoListTile(
                          title: Text('Cellular'),
                          leading: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: CupertinoColors.systemGreen),
                              child: Icon(CupertinoIcons.antenna_radiowaves_left_right, color: CupertinoColors.white)
                          ),
                          leadingSize: 32,
                          trailing: Icon(CupertinoIcons.chevron_forward, color: CupertinoColors.systemGrey2),
                        ),
                        CupertinoListTile(
                          title: Text('Personal Hotspot'),
                          leading: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: CupertinoColors.systemGreen),
                              child: Icon(CupertinoIcons.antenna_radiowaves_left_right, color: CupertinoColors.white)
                          ),
                          leadingSize: 32,
                          additionalInfo: Text(isBluetoothOn ? 'On' : 'Off'),
                          trailing: Icon(CupertinoIcons.chevron_forward, color: CupertinoColors.systemGrey2),
                          onTap: (){},
                        ),
                      ],
                    )
                )
              ],
            )
        )
    );
  }
}
