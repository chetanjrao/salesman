import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:salesman/features/profile/bloc/profile_bloc.dart';
import 'package:salesman/features/profile/bloc/profile_event.dart';
import 'package:salesman/features/profile/bloc/profile_state.dart';
import 'package:salesman/utils/globals.dart';
import 'package:shimmer/shimmer.dart';

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
        body:  BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state){
            if(state is ProfileInitialState){
              context.bloc<ProfileBloc>().add(LoadProfile());
            }
            if(state is ProfileSuccessState){
              return Column(
              children: [
                ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${state.profileModel.firstName} ${state.profileModel.lastName}"
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 6.0),
                        child: Text(
                          "${state.profileModel.mobile}",
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
                        "$API_URL${state.profileModel.image}"
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
            );
            } else {
              return Column(
              children: [
                ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[200],
                            highlightColor: Colors.grey[100],
                            child: Container(
                              width: double.infinity,
                              height: 16.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  color: Colors.white
                                ),
                            )
                          )
                        ),
                      Container(
                        margin: EdgeInsets.only(top: 8.0),
                        child: Container(
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[200],
                            highlightColor: Colors.grey[100],
                            child: Container(
                              width: double.infinity,
                              height: 12.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  color: Colors.white
                                ),
                            )
                          )
                        ),
                      )
                    ]
                  ),
                  trailing: Container(
                    child: Shimmer.fromColors(
                              baseColor: Colors.grey[200],
                              highlightColor: Colors.grey[100],
                              child: Container(
                              width: 48.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.5),
                                  width: 0.5
                                )
                              )
                            ),
                        ),
                  ),
                ),
                Container(
                  child: ListTile(
                        leading: Shimmer.fromColors(
                              baseColor: Colors.grey[200],
                              highlightColor: Colors.grey[100],
                              child: Container(
                              width: 36.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.5),
                                  width: 0.5
                                )
                              )
                            ),
                        ),
                        title: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey[200],
                                highlightColor: Colors.grey[100],
                                child: Container(
                                  width: double.infinity,
                                  height: 18.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      color: Colors.white
                                    ),
                                )
                              )
                            )
                          ],
                        ),
                        trailing: Container(
                          child: Shimmer.fromColors(
                              baseColor: Colors.grey[200],
                              highlightColor: Colors.grey[100],
                              child: Container(
                                height: 24,
                                width: 24,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white
                                    ),
                              )
                            )
                        ),
                      )
                ),
                Divider(
                  color: Color(0xFFDFE2E9)
                ),
                ListTile(
                        leading: Shimmer.fromColors(
                              baseColor: Colors.grey[200],
                              highlightColor: Colors.grey[100],
                              child: Container(
                              width: 36.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.5),
                                  width: 0.5
                                )
                              )
                            ),
                        ),
                        title: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey[200],
                                highlightColor: Colors.grey[100],
                                child: Container(
                                  width: double.infinity,
                                  height: 18.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      color: Colors.white
                                    ),
                                )
                              )
                            )
                          ],
                        ),
                        trailing: Container(
                          child: Shimmer.fromColors(
                              baseColor: Colors.grey[200],
                              highlightColor: Colors.grey[100],
                              child: Container(
                                height: 24,
                                width: 24,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white
                                    ),
                              )
                            )
                        ),
                      ),
                Divider(
                  color: Color(0xFFDFE2E9)
                ),
                ListTile(
                        leading: Shimmer.fromColors(
                              baseColor: Colors.grey[200],
                              highlightColor: Colors.grey[100],
                              child: Container(
                              width: 36.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.5),
                                  width: 0.5
                                )
                              )
                            ),
                        ),
                        title: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey[200],
                                highlightColor: Colors.grey[100],
                                child: Container(
                                  width: double.infinity,
                                  height: 18.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      color: Colors.white
                                    ),
                                )
                              )
                            )
                          ],
                        ),
                        trailing: Container(
                          child: Shimmer.fromColors(
                              baseColor: Colors.grey[200],
                              highlightColor: Colors.grey[100],
                              child: Container(
                                height: 24,
                                width: 24,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white
                                    ),
                              )
                            )
                        ),
                      ),
                Divider(
                  color: Color(0xFFDFE2E9)
                ),
                ListTile(
                        leading: Shimmer.fromColors(
                              baseColor: Colors.grey[200],
                              highlightColor: Colors.grey[100],
                              child: Container(
                              width: 36.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.5),
                                  width: 0.5
                                )
                              )
                            ),
                        ),
                        title: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey[200],
                                highlightColor: Colors.grey[100],
                                child: Container(
                                  width: double.infinity,
                                  height: 18.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      color: Colors.white
                                    ),
                                )
                              )
                            )
                          ],
                        ),
                        trailing: Container(
                          child: Shimmer.fromColors(
                              baseColor: Colors.grey[200],
                              highlightColor: Colors.grey[100],
                              child: Container(
                                height: 24,
                                width: 24,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white
                                    ),
                              )
                            )
                        ),
                      )
              ]
            );
            }
          },
        )
      ),
    );
  }
}