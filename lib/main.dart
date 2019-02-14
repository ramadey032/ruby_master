import 'package:flutter/material.dart';
import 'package:master_task/dash_board.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Master Planner',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: MyHomePage(title: 'Master Planner'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  List<BottomCategory> _items;
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();

    _items = [
      new BottomCategory(
          icon: new Icon(Icons.dashboard),
          title: 'DashBoard',
          color: Colors.tealAccent.shade400,
          body: DashBoard(),
          vsync: this),
      new BottomCategory(
        icon: new Icon(Icons.schedule),
        title: 'Schedule',
        color: Colors.pinkAccent.shade400,
        // body: new MapPage(),
        vsync: this,
      ),
      new BottomCategory(
        icon: new Icon(Icons.contact_mail),
        title: 'Contacts',
        color: Colors.teal,
        // body: new PhotosPage(),
        vsync: this,
      ),
      new BottomCategory(
        icon: new Icon(Icons.info_outline),
        title: 'Info',
        color: Colors.blueAccent.shade400,
        // body: new InfoPage(),
        vsync: this,
      ),
    ];

    for (BottomCategory view in _items) view.controller.addListener(_rebuild);

    _items[_currentIndex].controller.value = 1.0;
  }

  void _rebuild() {
    setState(() {});
  }

  @override
  void dispose() {
    for (BottomCategory page in _items) {
      page.controller.dispose();
    }
    super.dispose();
  }

  Widget _buildPageStack() {
    final List<Widget> transitions = <Widget>[];
    for (int i = 0; i < _items.length; i++) {
      transitions.add(IgnorePointer(
          ignoring: _currentIndex != i,
          child: _items[i].buildTransition(context)));
    }
    return new Stack(children: transitions);
  }

  @override
  Widget build(BuildContext context) {
    final BottomNavigationBar navBar = new BottomNavigationBar(
      items: _items.map((page) {
        return page.item;
      }).toList(),
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.shifting,
      onTap: (index) {
        setState(() {
          _items[_currentIndex].controller.reverse();
          _currentIndex = index;
          _items[_currentIndex].controller.forward();
        });
      },
    );

    return new Scaffold(
    
      body: new Center(
        child: _buildPageStack(),
      ),
      bottomNavigationBar: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Material(child: navBar),
        ],
      ),
    );
  }
}

class BottomCategory {
  BottomCategory({
    Widget icon,
    String title,
    Color color,
    this.body,
    TickerProvider vsync,
  })  : this._icon = icon,
        this._title = title,
        this._color = color,
        this.controller = AnimationController(
            vsync: vsync, duration: Duration(milliseconds: 300)),
        this.item = BottomNavigationBarItem(
          icon: icon,
          title: Text(title),
          backgroundColor: color,
        ) {
    _animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);
  }

  final Widget _icon;
  final String _title;
  final Color _color;
  final AnimationController controller;
  final BottomNavigationBarItem item;
  final Widget body;
  CurvedAnimation _animation;

  FadeTransition buildTransition(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: body,
    );
  }
}
