import "package:flutter/material.dart";
import 'package:padak_starter/list_page.dart';

import 'grid_page.dart';

// 1-2. 탭 화면 (각 화면 import)

// 1-2. 탭 화면 (Stateless -> Stateful)
class MainPage extends StatefulWidget {
  // 1-2. 탭 화면 (_selectedTabIndex 변수 옮김)

  // 1-2. 탭 화면 (탭 인덱스 설정)

  // 1-2. 탭 화면 (createState 함수 추가)

  // 1-2. 탭 화면 (build() 함수를 _MainState로 옮김)
  @override
  _MainPageState createState() => _MainPageState();
}

// 1-2. 탭 화면 (State 구현)
class _MainPageState extends State<StatefulWidget> {
  int _selectedTab = 0;

// 1-2. 탭 화면 (List, Grid Widget 반환)
  Widget _buildPage(index) {
    if (index == 0)
      return ListPage();
    return GridPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 1-1. 상단화면 (제목 수정)
        title: Text('Movie'),
        // 1-1. 상단화면 (좌측 버튼 추가)
        leading: Icon(Icons.menu),
        // 1-1. 상단화면 (우측 팝업 버튼 및 이벤트 추가)
        actions: [
          PopupMenuButton<int>(
            icon: Icon(Icons.sort),
            onSelected: (value) {
              switch (value) {
                case 0:
                  print("예매율순");
                  break;
                case 1:
                  print("큐레이션");
                  break;
                default:
                  print("최신순");
                  break;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: 0, child: Text("예매율순")),
              PopupMenuItem(value: 1, child: Text("큐레이션")),
              PopupMenuItem(value: 2, child: Text("최신순")),
            ],
          )
        ],
      ),
      // 1-2. 탭 화면 (List, Grid Widget 연동)
      body: _buildPage(_selectedTab),
      // 1-2. 탭 화면 (bottomNavigationBar 추가)
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.view_list),
            title: Text('List'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_on),
            title: Text('Grid'),
          ),
        ],
        currentIndex: _selectedTab,
        onTap: (index) {
          setState(() {
            _selectedTab = index;
            print('Selected tab is $index');
          });
        },
      ),
    );
  }

}


