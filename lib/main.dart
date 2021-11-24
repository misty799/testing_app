import 'package:flutter/material.dart';
import 'package:test_app/Utils/bottom_nav_bar.dart';
import 'package:test_app/models/market.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;
  void onTabChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  final List _tabIcons = List.unmodifiable([
    {'icon': 'assets/Favoriten ICON.png', 'title': 'Markte'},
    {'icon': 'assets/Favoriten ICON.png', 'title': 'Favoriten'},
    {'icon': 'assets/Deine Bestellungen ICON.png', 'title': 'Warenkorb'},
    {'icon': 'assets/Profil ICON.png', 'title': 'Profil'},
  ]);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: <Widget>[
            const FirstScreen(),
            Container(),
            Container(),
            Container()
          ][currentIndex],
          bottomNavigationBar: NavBar(
            tabIcons: _tabIcons,
            activeIndex: currentIndex,
            onTabChanged: onTabChanged,
            key: const Key(""),
          )),
    );
  }
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(children: [
            Flexible(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "Am Gatherhof 10, Dussseldorf",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            Icon(Icons.add_chart_sharp),
          ]),
          Container(
            margin: EdgeInsets.only(top: 10),
            padding: const EdgeInsets.all(4.0),
            color: Colors.blue[100],
            child: TabBar(
                isScrollable: true,
                unselectedLabelColor: Colors.black,
                labelColor: Colors.blue[800],
                indicator: BoxDecoration(
                    border: Border.all(color: Colors.blue[800]!, width: 2),
                    borderRadius: BorderRadius.circular(30)),
                tabs: const [
                  Tab(
                    text: "Obst/Gemuse",
                  ),
                  Tab(
                    text: "Fisch",
                  ),
                  Tab(
                    text: "Fleisch",
                  ),
                  Tab(
                    text: "Kase",
                  ),
                  Tab(
                    text: "Konditorei",
                  ),
                ]),
          ),
          Expanded(
            child: TabBarView(children: [
              ListView.builder(
                  itemCount: 6,
                  itemBuilder: (context, i) {
                    return FirstScreenWidget();
                  }),
              Container(),
              Container(),
              Container(),
              Container()
            ]),
          )
        ],
      ),
    );
  }
}

class FirstScreenWidget extends StatelessWidget {
  FirstScreenWidget({Key? key}) : super(key: key);
  Market market = Market(
      logo: "Logo",
      image: "assets/fish.jpg",
      name: "MarktName",
      rating: 5,
      price: 1200);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return SecondScreen(
            market: market,
          );
        }));
      },
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        height: 180,
        child: Card(
            child: Stack(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              market.image,
              width: MediaQuery.of(context).size.width,
              height: 150,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
              top: 85,
              left: 0,
              bottom: 45,
              right: MediaQuery.of(context).size.width * 0.4,
              child: Opacity(
                opacity: 0.8,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        market.logo,
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        market.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              )),
          Positioned(
            top: 120,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: Colors.white,
              child: Row(
                children: [
                  const Icon(
                    Icons.access_alarm,
                    color: Colors.grey,
                  ),
                  const Text("08-20 Uhr"),
                  const Spacer(),
                  const Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  Text("${market.rating}/5(${market.price})"),
                ],
              ),
            ),
          )
        ])),
      ),
    );
  }
}

class SecondScreen extends StatefulWidget {
  final Market market;
  const SecondScreen({Key? key, required this.market}) : super(key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Container(
                height: 180,
                child: Stack(children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      widget.market.image,
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                      top: 20,
                      child: Row(
                        children: [
                          IconButton(
                            icon:
                                Icon(Icons.arrow_back_ios, color: Colors.white),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          Image.asset(
                            "assets/Favoriten ICON.png",
                            color: Colors.white,
                          ),
                          Image.asset("assets/Info ICON.png")
                        ],
                      )),
                  Positioned(
                      top: 80,
                      left: 0,
                      bottom: 40,
                      right: 0,
                      child: Opacity(
                        opacity: 0.8,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.market.logo,
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                widget.market.name,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      )),
                  Positioned(
                    top: 130,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      color: Colors.white,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.access_alarm,
                            color: Colors.grey,
                          ),
                          const Text("08-20 Uhr"),
                          const Spacer(),
                          const Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                          Text(
                              "${widget.market.rating}/5(${widget.market.price})"),
                        ],
                      ),
                    ),
                  )
                ]),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                padding: const EdgeInsets.all(4.0),
                color: Colors.blue[100],
                child: TabBar(
                    isScrollable: true,
                    unselectedLabelColor: Colors.black,
                    labelColor: Colors.blue[800],
                    indicator: BoxDecoration(
                        border: Border.all(color: Colors.blue[800]!, width: 2),
                        borderRadius: BorderRadius.circular(30)),
                    tabs: const [
                      Tab(
                        text: "Angebote",
                      ),
                      Tab(
                        text: "Kategorie 1",
                      ),
                      Tab(
                        text: "Kategorie 2",
                      ),
                      Tab(
                        text: "Kategorie 3",
                      ),
                      Tab(
                        text: "Kategorie 4",
                      ),
                    ]),
              ),
              Expanded(
                child: TabBarView(children: [
                  ListView.builder(
                      itemCount: 6,
                      itemBuilder: (context, i) {
                        return Container(
                          height: 150,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: 3,
                              itemBuilder: (context, j) {
                                return SecondScreenWidget();
                              }),
                        );
                      }),
                  Container(),
                  Container(),
                  Container(),
                  Container()
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SecondScreenWidget extends StatelessWidget {
  const SecondScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            "assets/fish.jpg",
            height: 50,
          ),
          Text(
            "4,99 ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            """Orza Risotto- 
          & Paella-Reis 1 kg""",
          ),
        ],
      ),
    );
  }
}
