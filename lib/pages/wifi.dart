import 'package:flutter/cupertino.dart';
import '/config/options.dart';

class Wifipage extends StatefulWidget {
  const Wifipage({super.key});

  @override
  State<Wifipage> createState() => _WifipageState();
}

bool isLoading = false;

class _WifipageState extends State<Wifipage> {
  List<Map<String, dynamic>> savedNetworks = [
    {'name': 'HJR WiFi', 'isConnected': true, 'isSecured': true},
    {'name': 'Work WiFi', 'isConnected': false, 'isSecured': false},
  ];

  List<Map<String, dynamic>> availableNetworks = [
    {'name': 'PLDTHOMEFIBRxfh5gH', 'isSecured': true},
    {'name': 'SM Free WiFi', 'isSecured': false},
    {'name': 'Shop WiFi', 'isSecured': true},
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.secondarySystemBackground,
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoNavigationBarBackButton(
          previousPageTitle: 'Settings',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        middle: Text('Wi-Fi', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 8),
            Form(
              child: CupertinoFormSection.insetGrouped(
                margin: EdgeInsets.all(14),
                children: [
                  CupertinoListTile(
                    title: Text('Wi-Fi'),
                    trailing: CupertinoSwitch(
                      value: OptionSettings.isWifiOn,
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),
            CupertinoListSection.insetGrouped(
              header: Row(
                children: [
                  SizedBox(width: 14),
                  Text('MY NETWORKS',
                      style: TextStyle(fontSize: 14, color: CupertinoColors.systemGrey, fontWeight: FontWeight.w100)),
                  SizedBox(width: 14),
                  if (isLoading) CupertinoActivityIndicator(),
                ],
              ),
              children: savedNetworks.map((network) {
                return CupertinoListTile(
                  title: Text(network['name']),
                  leading: network['isConnected'] ? Icon(CupertinoIcons.check_mark) : Text(''),
                  additionalInfo: Row(
                    children: [
                      if(network['isSecured'])
                        Icon(
                          CupertinoIcons.lock_fill,
                          size: 16,
                          color: CupertinoColors.label,
                        ),
                      SizedBox(width: 5,),
                      Icon(
                        CupertinoIcons.wifi,
                        size: 16,
                        color: CupertinoColors.label,
                      ),
                    ],
                  ),
                  trailing: CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Icon(CupertinoIcons.info_circle),
                    onPressed: () {},
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 18),
            CupertinoListSection.insetGrouped(
              header: Row(
                children: [
                  SizedBox(width: 14),
                  Text('OTHER NETWORKS',
                      style: TextStyle(fontSize: 14, color: CupertinoColors.systemGrey, fontWeight: FontWeight.w100)),
                  SizedBox(width: 14),
                  CupertinoActivityIndicator(),
                ],
              ),
              children: availableNetworks.map((network) {
                return CupertinoListTile(
                  title: Text(network['name']),
                  leading: Text(''),
                  additionalInfo: Row(
                    children: [
                      if(network['isSecured'])
                      Icon(
                        CupertinoIcons.lock_fill,
                        size: 16,
                        color: CupertinoColors.label,
                      ),
                      SizedBox(width: 5,),
                      Icon(
                        CupertinoIcons.wifi,
                        size: 16,
                        color: CupertinoColors.label,
                      ),
                    ],
                  ),
                  trailing: CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Icon(CupertinoIcons.info_circle),
                    onPressed: () {},
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
