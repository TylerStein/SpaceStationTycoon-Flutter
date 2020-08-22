import 'package:flutter/material.dart';
import 'package:space_station_tycoon/widgets/tabs/economy_tab.dart';
import 'package:space_station_tycoon/widgets/tabs/log_tab.dart';
import 'package:space_station_tycoon/widgets/tabs/modules_tab/modules_tab.dart';
import 'package:space_station_tycoon/widgets/tabs/overview_tab.dart';

class GameTabs extends StatefulWidget {

  @override
  _GameTabsState createState() => _GameTabsState();
}

class _GameTabsState extends State<GameTabs> with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: TabBar(
            isScrollable: true,
            physics: AlwaysScrollableScrollPhysics(),
            controller: _tabController,
            tabs: [
              Tab(text: 'Overview'),
              Tab(text: 'Economy'),
              Tab(text: 'Modules'),
              Tab(text: 'Logs'),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: [
              OverviewTab(),
              EconomyTab(),
              ModulesTab(),
              LogTab(),
            ],
          )
        ),
      ],
    );
  }
}