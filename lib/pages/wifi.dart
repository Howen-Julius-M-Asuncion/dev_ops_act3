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
        child: ListView(
            children: [Column(
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
                            setState(() {
                              if (OptionSettings.airplaneMode) {
                                // do nothing
                              } else {
                                OptionSettings.isWifiOn = !OptionSettings.isWifiOn;
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
                if (OptionSettings.airplaneMode || !OptionSettings.isWifiOn)
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 4, 30, 12),
                    child: Text(
                      OptionSettings.airplaneMode
                          ? 'To enable Wi-Fi, turn off Airplane Mode.'
                          : 'Wi-Fi networks will be listed here when Wi-Fi is enabled.',
                      style: TextStyle(fontSize: 16, color: CupertinoColors.systemGrey),
                    ),
                  ),
                if (OptionSettings.isWifiOn)
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
                    children: isLoading
                        ? []
                        : savedNetworks.map((network) {
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
                if (OptionSettings.isWifiOn)
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
                    children: isLoading
                        ? []
                        : availableNetworks.map((network) {
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
                SizedBox(height: 18,),
                if (OptionSettings.isWifiOn && !isLoading)
                  CupertinoListSection.insetGrouped(
                      children: [
                        CupertinoListTile(
                          title: Text('Aks to Join Networks'),
                          additionalInfo: Text('Notify', style: TextStyle(color: CupertinoColors.systemGrey),),
                          trailing: Icon(CupertinoIcons.chevron_forward, color: CupertinoColors.systemGrey,),
                        )
                      ]
                  ),
                if (OptionSettings.isWifiOn && !isLoading)
                  Padding(
                      padding: EdgeInsets.fromLTRB(30, 4, 30, 12),
                      child: Text('Known networks will be joined automatically. If no known networks are available, you will be notified of available networks.' ,style: TextStyle(fontSize: 12, color: CupertinoColors.systemGrey), )
                  ),
              ],
            ),]
        ),
      ),
    );
  }
}
