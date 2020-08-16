import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perpus/models/popularbook_model.dart';
import 'package:perpus/widgets/custom_tab_indicator.dart';
// import '../bloc/cart_items.dart';
import 'package:perpus/bloc/cart_items.dart';

// import 'package:perpus/screens/selected_book_screen.dart';
// import 'home_screen.dart';
class SelectedBookScreen extends StatelessWidget {
  final PopularBookModel popularBookModel;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  SelectedBookScreen({Key key, @required this.popularBookModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(left: 25, right: 25, bottom: 25),
        height: 49,
        color: Colors.transparent,
        child: FlatButton(
          color: Colors.lightGreen,
          onPressed: () {
            bloc.addToCart(popularBookModel);
                    final snackBar = SnackBar(
          content: Text('${popularBookModel.title} added to Cart'),
          duration: Duration(milliseconds: 1000),
        );

        _scaffoldKey.currentState.showSnackBar(snackBar);
            // print(popularBookModel);
          },
          child: Text(
            'Add to Library',
            style: GoogleFonts.openSans(
                fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
      body: SafeArea(
        child: Container(
          child: CustomScrollView(slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Color(popularBookModel.color),
              expandedHeight: MediaQuery.of(context).size.height * 0.5,
              flexibleSpace: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        left: 25,
                        top: 35,
                        child: GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, "/homeScreen");
                            },
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white),
                              child: SvgPicture.asset(
                                  'assets/icons/icon_back_arrow.svg'),
                            ))),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                            margin: EdgeInsets.only(bottom: 62),
                            width: 172,
                            height: 225,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: AssetImage(popularBookModel.image)),
                            )))
                  ],
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              Padding(
                padding: EdgeInsets.only(top: 24, left: 25),
                child: Text(
                  popularBookModel.title,
                  style: GoogleFonts.openSans(
                      fontSize: 27,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 24, left: 25),
                child: Text(
                  popularBookModel.author,
                  style: GoogleFonts.openSans(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 7, left: 25),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "\$",
                        style: GoogleFonts.openSans(
                            fontSize: 14,
                            color: Color(popularBookModel.color),
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        popularBookModel.price,
                        style: GoogleFonts.openSans(
                            fontSize: 32,
                            color: Color(popularBookModel.color),
                            fontWeight: FontWeight.w600),
                      )
                    ]),
              ),

              Container(
                height: 28,
                margin: EdgeInsets.only(top: 23, bottom: 36),
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
                            weight: 2, width: 30, color: Colors.black),
                        tabs: [
                          Tab(
                            child: Container(
                                margin: EdgeInsets.only(right: 39),
                                child: Text('Description')),
                          ),
                          Tab(
                            child: Container(
                                margin: EdgeInsets.only(right: 39),
                                child: Text('Reviews')),
                          ),
                          Tab(
                            child: Container(
                                margin: EdgeInsets.only(right: 39),
                                child: Text('Similiar')),
                          ),
                        ])),
              ),
              Padding(
                  padding: EdgeInsets.only(left: 25, right: 25, bottom: 25),
                  child: Text(
                    popularBookModel.description,
                    style: GoogleFonts.openSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                        letterSpacing: 1.5,
                        height: 2),
                  ))
            ]))
          ]),
        ),
      ),
    );
  }
}
