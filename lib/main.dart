import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:salesman/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:salesman/features/dashboard/bloc/dashboard_events.dart';
import 'package:salesman/features/dashboard/bloc/dashboard_state.dart';
import 'package:salesman/features/dashboard/data/respository/dashboard_repository.dart';
import 'package:salesman/features/dashboard/ui/dashboard.dart';
import 'package:salesman/features/details/bloc/details_bloc.dart';
import 'package:salesman/features/details/data/repository/details_repository.dart';
import 'package:salesman/features/editinvoice/bloc/editinvoice_bloc.dart';
import 'package:salesman/features/editinvoice/data/repository/edit_invoice_repository.dart';
import 'package:salesman/features/invoices/data/repository/invoice_repository.dart';
import 'package:salesman/features/invoices/ui/invoice.dart';
import 'package:salesman/features/profile/bloc/profile_bloc.dart';
import 'package:salesman/features/profile/data/respository/profile_repository.dart';
import 'package:salesman/features/profile/ui/profile.dart';
import 'package:salesman/features/transactions/bloc/transactions_bloc.dart';
import 'package:salesman/features/transactions/data/respoitory/transactions.dart';
import 'package:salesman/features/transactions/ui/transactions.dart';

import 'features/invoices/bloc/invoice_bloc.dart';


void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.dark,
    statusBarColor: Colors.white.withOpacity(1)
  ));
  runApp(HomeScreen());
}

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Euclid Circular B',
        primaryColor: Color(0xFF1e7145)
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
  final InvoiceRepository invoiceRepository = new InvoiceRepository();
  final ProfileRepository profileRepository = new ProfileRepository();
  final InvoiceInfoRepository invoiceInfoRepository = new InvoiceInfoRepository();
  final EditInvoiceRepository editInvoiceRepository = new EditInvoiceRepository();
  final TransactionRepository transactionsRepository = new TransactionRepository();

  void changePage(index){
    setState(() {
      currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: IndexedStack(
          children: <Widget>[
            MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => DashboardBloc(dashboardRepository: dashboardRepository),
                )
              ],
              child: Dashboard()
            ),
            MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => InvoiceBloc(
                    invoiceRepository: invoiceRepository
                  ),
                ),
                BlocProvider(
                  create: (context) {
                    return InvoiceDetailsBloc(invoiceInfoRepository: invoiceInfoRepository
                  );
                  },
                ),
                BlocProvider(
                  create: (context) => EditInvoiceBloc(
                    editInvoiceRepository: editInvoiceRepository
                  ),
                )
              ], 
              child: Invoice()
            ),
            BlocProvider(
              create: (context) => TransactionsBloc(
                transactionsRepository
              ),
              child: Transactions(),
            ),
            MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => ProfileBloc(profileRepository: profileRepository)),
              ],
              child: Profile(),
            )
          ],
          index: currentPage,
        ),
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
