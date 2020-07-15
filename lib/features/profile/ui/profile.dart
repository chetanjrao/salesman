import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading:  Icon(
            Feather.chevron_left,
            color: Theme.of(context).primaryColor
          ),
        ),
        body: Column(
          children: [
            ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Chethan Jagannatha Kulkarni"
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 6.0),
                    child: Text(
                      "+919110466718",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Color(0XFF404864)
                      )
                    )
                  )
                ]
              ),
              trailing: Container(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    "https://widgetwhats.com/app/uploads/2019/11/free-profile-photo-whatsapp-4.png"
                  ),
                )
              ),
            ),
            Container(
              child: ListTile(
                leading: Icon(
                  Feather.settings,
                  size: 20.0,
                  color: Color(0XFF828CA3),
                ),
                title: Text(
                  "General"
                ),
                trailing: Icon(
                  Feather.chevron_right,
                  color: Color(0XFF828CA3).withOpacity(0.6)
                ),
              )
            ),
            Divider(
              color: Color(0xFFDFE2E9)
            ),
            ListTile(
              leading: Icon(
                Feather.grid,
                size: 20.0,
                color: Color(0XFF828CA3),
              ),
              title: Text(
                "About the app"
              ),
              trailing: Icon(
                Feather.chevron_right,
                color: Color(0XFF828CA3).withOpacity(0.6)
              ),
            ),
            Divider(
              color: Color(0xFFDFE2E9)
            ),
            ListTile(
              leading: Icon(
                Feather.info,
                size: 20.0,
                color: Color(0XFF828CA3),
              ),
              title: Text(
                "Version 1.0.14"
              ),
              trailing: Icon(
                Feather.chevron_right,
                color: Color(0XFF828CA3).withOpacity(0.6)
              ),
            ),
            Divider(
              color: Color(0xFFDFE2E9)
            ),
            ListTile(
              leading: Icon(
                Feather.log_out,
                size: 20.0,
                color: Color(0XFF828CA3),
              ),
              title: Text(
                "Sign Out"
              ),
              trailing: Icon(
                Feather.chevron_right,
                color: Color(0XFF828CA3).withOpacity(0.6)
              ),
            )
          ]
        ),
      ),
    );
  }
}