import 'package:flutter/material.dart';
import 'package:flutter_fsky_music/page/search/search_data_page.dart';
import 'package:flutter_fsky_music/widget/common_text_style.dart';
import 'package:flutter_fsky_music/widget/v_empty_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../application.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with TickerProviderStateMixin {
  List<String> historySearchList;
  TextEditingController _searchController = TextEditingController();
  FocusNode _blankNode = FocusNode();
  bool _isSearching = false;
  String searchText;

  @override
  void initState() {
    super.initState();
    historySearchList = Application.sp.getStringList("search_history")??[];
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// History search
  Widget _buildHistorySearch() {
    return Offstage(
      offstage: historySearchList.isEmpty,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  'history record',
                  style: bold18TextStyle,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.delete_outline,
                  color: Colors.grey,
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Text(
                            "Are you sure you want to clear all history records?",
                            style: common14GrayTextStyle,
                          ),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('cancel'),
                              textColor: Colors.red,
                            ),
                            FlatButton(
                              onPressed: () {
                                setState(() {
                                  historySearchList.clear();
                                  Application.sp.remove("search_history");
                                });
                                Navigator.of(context).pop();
                              },
                              child: Text('Empty'),
                              textColor: Colors.red,
                            ),
                          ],
                        );
                      });
                },
              )
            ],
          ),
          Wrap(
            spacing: ScreenUtil().setWidth(20),
            children: historySearchList
                .map((v) => GestureDetector(
                      onTap: () {
                        searchText = v;
                        _search();
                      },
                      child: Chip(
                        label: Text(
                          v,
                          style: common14TextStyle,
                        ),
                        backgroundColor: Color(0xFFf2f2f2),
                      ),
                    ))
                .toList(),
          ),
          VEmptyView(50),
        ],
      ),
    );
  }

  // // search for
  void _search() {
    FocusScope.of(context).requestFocus(_blankNode);
    setState(() {
      if (historySearchList.contains(searchText))
        historySearchList.remove(searchText);
      historySearchList.insert(0, searchText);
      if (historySearchList.length > 5) {
        historySearchList.removeAt(historySearchList.length - 1);
      }
      _isSearching = true;
      _searchController.text = searchText;
    });
    Application.sp.setStringList("search_history", historySearchList);
  }

  Widget _buildUnSearchingPage() {
    return ListView(
      padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(40),
          vertical: ScreenUtil().setWidth(30)),
      children: <Widget>[
        _buildHistorySearch(),
      ],
    );
  }

  // Build layout in search
  Widget _buildSearchingPage() {
    return SearchDataPage(data: searchText);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          title: Theme(
            
            child: TextField(
              controller: _searchController,
              cursorColor: Colors.red,
              textInputAction: TextInputAction.search,
              onEditingComplete: () {
                searchText = _searchController.text.isEmpty
                    ? 'PitBull'
                    : _searchController.text;
                _search();
              },
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintText: "Search Artist",
                hintStyle: commonGrayTextStyle,
                suffixIcon: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      Icons.clear,
                      color: Colors.black87,
                    ),
                    onPressed: () {
                      if (_searchController.text.isNotEmpty)
                        setState(() {
                          _searchController.text = "";
                        });
                    }),
              ),
            ),
            data: Theme.of(context).copyWith(primaryColor: Colors.black54),
          ),
        ),
        body: Listener(
          onPointerDown: (d) {
            FocusScope.of(context).requestFocus(_blankNode);
          },
          child: Stack(
            children: <Widget>[
              _isSearching ? _buildSearchingPage() : _buildUnSearchingPage(),
            ],
          ),
        ),
      ),
      onWillPop: () async {
        if (_isSearching) {
          setState(() {
            _searchController.text = "";
            _isSearching = false;
          });
          return false;
        }
        return true;
      },
    );
  }
}
