import 'package:flutter/material.dart';
import 'package:flutter_fsky_music/utils/net_utils.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                height: 170,
                child: FutureBuilder(
                    builder: (context, projectSnap) {
                      if (projectSnap.connectionState == ConnectionState.none &&
                          projectSnap.hasData == null) {
                        return Container(
                          child: Text("Data Api Error"),
                        );
                      }
                      return Card(
                        child: Container(
                          height: 170,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      projectSnap.data.data.path.toString())),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey),
                        ),
                      );
                    },
                    future: NetUtils.getBannerData()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
