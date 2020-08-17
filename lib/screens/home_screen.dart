import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perpus/models/popularbook_model.dart';
import 'package:perpus/screens/selected_book_screen.dart';
import 'package:perpus/widgets/custom_tab_indicator.dart';
import 'package:perpus/models/newbook_model.dart';
import 'package:badges/badges.dart';
import '../bloc/cart_items.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 25, top: 25, right: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Mamang pro!',
                      style: GoogleFonts.openSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      'Discover Latest Book!',
                      style: GoogleFonts.openSans(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ]),
              ShopItemsWidget('cart items')
            ],
          ),
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          Container(
            height: 39,
            margin: EdgeInsets.only(left: 25, right: 25, top: 18),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200]),
            child: Stack(
              children: <Widget>[
                TextField(
                  maxLengthEnforced: true,
                  style: GoogleFonts.openSans(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.only(left: 19, right: 50, bottom: 8),
                      border: InputBorder.none,
                      hintText: "Search book...",
                      hintStyle: GoogleFonts.openSans(
                          fontSize: 16,
                          color: Colors.grey[500],
                          fontWeight: FontWeight.w600)),
                ),
                Positioned(
                    top: 7,
                    right: 10,
                    child:
                        SvgPicture.asset('assets/icons/icon_search_white.svg')),
              ],
            ),
          ),
          Container(
            height: 25,
            margin: EdgeInsets.only(top: 30),
            padding: EdgeInsets.only(left: 25),
            child: DefaultTabController(
                length: 3,
                child: TabBar(
                    labelPadding: EdgeInsets.all(0),
                    indicatorPadding: EdgeInsets.all(0),
                    isScrollable: true,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    labelStyle: GoogleFonts.openSans(
                        fontSize: 14, fontWeight: FontWeight.w700),
                    unselectedLabelStyle: GoogleFonts.openSans(
                        fontSize: 14, fontWeight: FontWeight.w600),
                    indicator: RoundedRectangleTabIndicator(
                        weight: 2, width: 10, color: Colors.black),
                    tabs: [
                      Tab(
                        child: Container(
                            margin: EdgeInsets.only(right: 23),
                            child: Text('New')),
                      ),
                      Tab(
                        child: Container(
                            margin: EdgeInsets.only(right: 23),
                            child: Text('Trending')),
                      ),
                      Tab(
                        child: Container(
                            margin: EdgeInsets.only(right: 23),
                            child: Text('Best Seller')),
                      ),
                    ])),
          ),
          Container(
            margin: EdgeInsets.only(top: 21),
            height: 210,
            child: ListView.builder(
                padding: EdgeInsets.only(left: 25, right: 6),
                itemCount: newbooks.length,
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(right: 19),
                    height: 210,
                    width: 153,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black,
                        image: DecorationImage(
                            image: AssetImage(newbooks[index].image))),
                  );
                }),
          ),
          Padding(
            padding: EdgeInsets.only(left: 25, top: 25),
            child: Text(
              'Popular!',
              style: GoogleFonts.openSans(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
        ]),
        ShopItemsWidget('prod'),
      ]),
    ));
  }
}

class ShopItemsWidget extends StatelessWidget {
  final param;
  ShopItemsWidget(this.param);
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: StreamBuilder(
      initialData: bloc.allItems,
      stream: bloc.getStream,
      builder: (context, snapshot) {
        return snapshot.data[param].length > 0
            ? shopItemsListBuilder(context, snapshot, param)
            : param == 'prod'
                ? Center(child: Text("All items in shop have been taken"))
                : param == 'cart items'
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.shopping_cart),
                              onPressed: () =>
                                  Navigator.pushNamed(context, '/checkout'),
                            )
                          ])
                    : '';
      },
    ));
  }
}

Widget shopItemsListBuilder(@required context, snapshot, param) {
  return param == 'prod'
      ? ListView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.only(top: 25, right: 25, left: 18),
          itemCount: snapshot.data[param].length,
          itemBuilder: (BuildContext context, index) {
            final post = snapshot.data[param][index];
            if(snapshot.data[param].length>0)
            return GestureDetector(
                onTap: () {
                  // print('ListView Tapped');
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SelectedBookScreen(
                              popularBookModel: PopularBookModel(
                                  post["id"],
                                  post["title"],
                                  post["author"],
                                  post["price"],
                                  post["image"],
                                  post["color"],
                                  post["description"],
                                  snapshot.data['cart items'].length==0?0:post["count"],
                                  snapshot.data['cart items'].length==0?false:post["perm"],
                                  ))));
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 19),
                  height: 81,
                  width: MediaQuery.of(context).size.width - 50,
                  color: Colors.transparent,
                  child: Row(children: <Widget>[
                    Container(
                        height: 81,
                        width: 62,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                                image: AssetImage(post["image"])),
                            color: Color(0xFFFFAAA5))),
                    SizedBox(
                      width: 21,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(post["title"],
                            style: GoogleFonts.openSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black)),
                        SizedBox(
                          height: 5,
                        ),
                        Text(post["author"],
                            style: GoogleFonts.openSans(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey)),
                        SizedBox(
                          height: 5,
                        ),
                        Text('\$' + post["price"],
                            style: GoogleFonts.openSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black))
                      ],
                    )
                  ]),
                ));
          },
        )
      : param == 'cart items'
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                  Badge(
                      badgeContent:
                          Text("${bloc.allItems['cart items'].length}",
                              style: GoogleFonts.openSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              )),
                      shape: BadgeShape.circle,
                      badgeColor: Colors.lightGreen[800],
                      borderRadius: 5,
                      padding:
                          EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                      animationType: BadgeAnimationType.scale,
                      child: IconButton(
                        icon: Icon(Icons.shopping_cart),
                        onPressed: () =>
                            Navigator.pushNamed(context, '/checkout'),
                      ))
                ])
          : '';
  '';
}
