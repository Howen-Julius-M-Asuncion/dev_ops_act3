import 'package:flutter/cupertino.dart';
import 'package:ios_settings/pages/wifi.dart';
import '/pages/bluetooth.dart';
import '/config/options.dart';

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

bool isLoading = false;

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: CupertinoColors.secondarySystemBackground,
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
                              value: OptionSettings.airplaneMode,
                              onChanged: (value) {
                                setState(() {
                                  OptionSettings.airplaneMode = value;
                                  isLoading = true;

                                  if (OptionSettings.airplaneMode) {
                                    // Store previous states
                                    OptionSettings.previousBluetoothState = OptionSettings.isBluetoothOn;
                                    OptionSettings.previousWifiState = OptionSettings.isWifiOn;
                                    OptionSettings.previousHotspotState = OptionSettings.isHotspotOn;

                                    OptionSettings.isBluetoothOn = false;
                                    OptionSettings.isWifiOn = false;
                                    OptionSettings.isHotspotOn = false;

                                    isLoading = false;
                                  } else {
                                    // Simulate loading before restoring previous states
                                    Future.delayed(Duration(milliseconds: 1200), () {
                                      setState(() {
                                        isLoading = false;
                                        OptionSettings.isBluetoothOn = OptionSettings.previousBluetoothState;
                                        OptionSettings.isWifiOn = OptionSettings.previousWifiState;
                                        OptionSettings.isHotspotOn = OptionSettings.previousHotspotState;
                                      });
                                    });
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
                          additionalInfo:  OptionSettings.previousWifiState && isLoading
                              ? CupertinoActivityIndicator() : Text(OptionSettings.isWifiOn ? 'HJR Wifi' : 'Off'),
                          trailing: Icon(CupertinoIcons.chevron_forward, color: CupertinoColors.systemGrey2),
                          onTap: () async {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(title: "Settings",builder: (context) => Wifipage()), ).then((value) {setState(() {});}
                            );
                          },
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
                          additionalInfo: OptionSettings.previousBluetoothState && isLoading
                              ? CupertinoActivityIndicator()
                              : Text(OptionSettings.isBluetoothOn ? 'On' : 'Off'),
                          trailing: Icon(CupertinoIcons.chevron_forward, color: CupertinoColors.systemGrey2),
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(builder: (context) => BTpage()), ).then((value) {setState(() {});}
                            );
                          },
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
                              child: Icon(CupertinoIcons.personalhotspot, color: CupertinoColors.white)
                          ),
                          leadingSize: 32,
                          additionalInfo: OptionSettings.previousHotspotState && isLoading
                              ? CupertinoActivityIndicator()
                              : Text(OptionSettings.isHotspotOn ? 'On' : 'Off'),
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
