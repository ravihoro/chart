import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sports_chart/bloc/home_page_cubit.dart';
import 'package:sports_chart/view/charts_flutter_tab.dart';
import 'package:sports_chart/view/syncfusion_tab.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomePageCubit>(
      create: (context) => HomePageCubit()..fetchData(),
      child: MaterialApp(
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomePageCubit, HomePageState>(
        builder: (context, state) {
          if (state is LoadingHomePageState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is FailedHomePageState) {
            return Center(
              child: Text(
                state.exception.toString(),
              ),
            );
          } else if (state is LoadedHomePageState) {
            return DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: AppBar(
                  title: Text('Chart'),
                  bottom: TabBar(
                    tabs: [
                      Tab(
                        child: Text('Syncfusion'),
                      ),
                      Tab(
                        child: Text('Charts Flutter'),
                      ),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    SyncFusionTab(
                      dataList: state.dataList,
                    ),
                    ChartsFlutterTab(
                      dataList: state.dataList,
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: Text('Unknown State'),
            );
          }
        },
      ),
    );
  }
}
