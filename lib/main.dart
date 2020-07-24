import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:salesman/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:salesman/features/dashboard/data/respository/dashboard_repository.dart';
import 'package:salesman/features/dashboard/ui/dashboard.dart';
import 'package:salesman/features/invoices/ui/invoice.dart';
import 'package:salesman/features/profile/ui/profile.dart';
import 'package:salesman/features/transactions/ui/transactions.dart';


void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.dark,
    statusBarColor: Colors.white.withOpacity(0.9)
  ));
  runApp(HomeScreen());
}

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Euclid Circular B',
        primaryColor: Color(0xFF1B279C)
      ),
      initialRoute: "/home",
      routes: {
        "/home": (context) => HomePage(),
        "/auth": (context) => null
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currentPage = 0;  
  final DashboardRepository dashboardRepository = new DashboardRepository();


  void changePage(index){
    setState(() {
      currentPage = index;
    });
  }

  Widget _buildWidget(index, BuildContext context){
    switch(index){
      case 0:
        return BlocProvider(
          create: (context) => DashboardBloc(dashboardRepository: dashboardRepository),
          child: Dashboard()
        );
      case 1:
        return Invoice();
      case 2:
        return Transactions();
      case 3:
        return Profile();
      default:
        return Text("hello");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _buildWidget(currentPage, context),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: currentPage,
          onTap: (index) => changePage(index),
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Feather.bar_chart_2,
                size: 20.0
              ),
              title: Text(
                "Analytics",
                style: TextStyle(
                  fontSize: 14.0
                ),
              )
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Feather.file_text,
                size: 20.0
              ),
              title: Text(
                "Invoices",
                style: TextStyle(
                  fontSize: 14.0
                ),
              )
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Feather.repeat,
                size: 20.0
              ),
              title: Text(
                "Transactions",
                style: TextStyle(
                  fontSize: 14.0
                ),
              )
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Feather.zap,
                size: 20.0
              ),
              title: Text(
                "Profile",
                style: TextStyle(
                  fontSize: 14.0
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}
