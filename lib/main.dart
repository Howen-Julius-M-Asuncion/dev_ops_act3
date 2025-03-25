import 'package:flutter/cupertino.dart';
import 'package:ios_settings/pages/wifi.dart';
import '/pages/bluetooth.dart';

void main() => runApp(CupertinoApp(
  theme: CupertinoThemeData(
    brightness: Brightness.light,
  ),
  debugShowCheckedModeBanner: false,
  home: MyApp(),
));

class OptionSettings {
  bool airplaneMode = false;

  bool isLoading = false;

  bool isWifiOn = true;
  bool isBluetoothOn = true;
  bool isHotspotOn = true;

  bool previousWifiState = false;
  bool previousBluetoothState = false;
  bool previousHotspotState = false;
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final OptionSettings settings = OptionSettings();

  void toggleSetting(bool currentValue, Function(bool) updateState) {
    if (!currentValue) {
      // If turning ON -> show loading
      setState(() => settings.isLoading = true);

      Future.delayed(Duration(milliseconds: 1200), () {
        setState(() {
          settings.isLoading = false;
          updateState(true); // Set new value after loading
        });
      });
    } else {
      // If turning OFF -> change immediately
      setState(() => updateState(false));
    }
  }

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
                              value: settings.airplaneMode,
                              onChanged: (value) {
                                setState(() {
                                  settings.airplaneMode = value;
                                  settings.isLoading = true;

                                  if (settings.airplaneMode) {
                                    // Store previous states
                                    settings.previousBluetoothState = settings.isBluetoothOn;
                                    settings.previousWifiState = settings.isWifiOn;
                                    settings.previousHotspotState = settings.isHotspotOn;

                                    settings.isBluetoothOn = false;
                                    settings.isWifiOn = false;
                                    settings.isHotspotOn = false;

                                    settings.isLoading = false; // No need to delay turning off
                                  } else {
                                    // Simulate loading before restoring previous states
                                    Future.delayed(Duration(milliseconds: 1200), () {
                                      setState(() {
                                        settings.isLoading = false;
                                        settings.isBluetoothOn = settings.previousBluetoothState;
                                        settings.isWifiOn = settings.previousWifiState;
                                        settings.isHotspotOn = settings.previousHotspotState;
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
                          additionalInfo:  settings.previousWifiState && settings.isLoading
                              ? CupertinoActivityIndicator() : Text(settings.isWifiOn ? 'HJR Wifi' : 'Off'),
                          trailing: Icon(CupertinoIcons.chevron_forward, color: CupertinoColors.systemGrey2),
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(builder: (context) => Wifipage()),
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
                          additionalInfo: settings.previousBluetoothState && settings.isLoading
                              ? CupertinoActivityIndicator()
                              : Text(settings.isBluetoothOn ? 'On' : 'Off'),
                          trailing: Icon(CupertinoIcons.chevron_forward, color: CupertinoColors.systemGrey2),
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(builder: (context) => BTpage()),
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
                              child: Icon(CupertinoIcons.antenna_radiowaves_left_right, color: CupertinoColors.white)
                          ),
                          leadingSize: 32,
                          additionalInfo: settings.previousHotspotState && settings.isLoading
                              ? CupertinoActivityIndicator()
                              : Text(settings.isHotspotOn ? 'On' : 'Off'),
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
