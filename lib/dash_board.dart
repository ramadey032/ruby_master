import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => new _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  Material myActivites(IconData icon, String heading, Color color) {
    return Material(
      color: color,
      elevation: 14.0,
      shadowColor: Colors.blueGrey,
      borderRadius: BorderRadius.circular(14.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                heading,
                style: TextStyle(fontSize: 30.0),
              ),
            ),
            Icon(
              icon,
              color: Colors.black,
              size: 30.0,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Master Task"),
        centerTitle: true,
      ),
      body: StaggeredGridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 12.0,
        crossAxisSpacing: 10.0,
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        children: <Widget>[
          myActivites(Icons.add_alert, "Total Activites", Colors.cyan),
          myActivites(Icons.add_box, "M&G1", Colors.deepOrange),
          myActivites(Icons.add_location, "M&G2", Colors.cyanAccent),
          myActivites(Icons.developer_board, "BP1", Colors.indigo),
          myActivites(Icons.face, "FP1", Colors.orangeAccent),
          myActivites(Icons.border_all, "BP2", Colors.purple),
          myActivites(Icons.favorite_border, "FP2", Colors.green),
        ],
        staggeredTiles: [
          StaggeredTile.extent(2, 130.0),
          StaggeredTile.extent(1, 150.0),
          StaggeredTile.extent(1, 150.0),
          StaggeredTile.extent(1, 150.0),
          StaggeredTile.extent(1, 150.0),
          StaggeredTile.extent(1, 150.0),
          StaggeredTile.extent(1, 150.0),
        ],
      ),
    );
  }
}
