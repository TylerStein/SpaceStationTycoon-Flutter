import 'package:flutter/material.dart';
import 'package:space_station_tycoon/widgets/tabs/economy_tab/economy_tab.dart';
import 'package:space_station_tycoon/widgets/tabs/log_tab.dart';
import 'package:space_station_tycoon/widgets/tabs/modules_tab/modules_tab.dart';
import 'package:space_station_tycoon/widgets/tabs/quest_tab.dart';
import 'package:space_station_tycoon/widgets/tabs/settings_tab.dart';
import 'package:space_station_tycoon/widgets/tabs/visitors_tab/visitors_tab.dart';

class GameTabs extends StatefulWidget {

  @override
  _GameTabsState createState() => _GameTabsState();
}

class _GameTabsState extends State<GameTabs> with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 6, vsync: this);
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
            //  Tab(icon: Icon(Icons.home)),
              Tab(icon: Icon(Icons.trending_up)),
              Tab(icon: Icon(Icons.view_module)),
              Tab(icon: Icon(Icons.group)),
              Tab(icon: Icon(Icons.book)),
              Tab(icon: Icon(Icons.rss_feed)),
              Tab(icon: Icon(Icons.settings)),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: [
            //  OverviewTab(),
              EconomyTab(),
              ModulesTab(),
              VisitorsTab(),
              QuestTab(),
              LogTab(),
              SettingsTab(),
            ],
          )
        ),
      ],
    );
  }
}