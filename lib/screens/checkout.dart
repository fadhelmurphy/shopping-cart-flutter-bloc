import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perpus/widgets/inc_dec_widget.dart';
import '../bloc/cart_items.dart';

class Checkout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    bloc.allItems['cart items'].isNotEmpty?bloc.allItems['cart items'].forEach((e)=>(e.perm?e.perm=false:e.perm)):bloc.allItems['cart items'];
    bloc.cartStreamController.sink.add(bloc.allItems);
    return Scaffold(
        backgroundColor: Colors.grey[200],
        bottomNavigationBar: Container(
          margin: EdgeInsets.only(left: 25, right: 25, bottom: 25),
          height: 49,
          color: Colors.transparent,
          child: FlatButton(
            color: Colors.lightGreen,
            onPressed: () {},
            child: Text(
              'Checkout',
              style: GoogleFonts.openSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.lightGreen[800], //change your color here
          ),
          bottom: PreferredSize(
              child: Container(
                color: Colors.grey[400],
                height: 1.0,
              ),
              preferredSize: Size.fromHeight(1.0)),
          centerTitle: true,
          title: Text(
            'Checkout',
            style: GoogleFonts.openSans(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.lightGreen[800]),
          ),
          actions: <Widget>[GestureDetector(
  onTap: () {
    bloc.allItems['cart items'].where((e) => e.perm).toList().forEach((el) {bloc.removeFromCart(el);});
  },
  child: Padding(padding: EdgeInsets.only(right:20),
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:<Widget>[
                Text(
            'Delete',
            style: GoogleFonts.openSans(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.lightGreen[800]),
          ),
              ]
            ),
            ),
)
          ],
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
        ),
        body: Column(children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 20, top: 20),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'MY \nBASKET',
                    style: GoogleFonts.openSans(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[500],
                    ),
                  ),
                ]),
          ),
          Expanded(
              child: SafeArea(
            child: StreamBuilder(
              stream: bloc.getStream,
              initialData: bloc.allItems,
              builder: (context, snapshot) {
                print(bloc.totalCart());
                return snapshot.data['cart items'].length > 0
                    ? Column(
                        children: <Widget>[
                          /// The [checkoutListBuilder] has to be fixed
                          /// in an expanded widget to ensure it
                          /// doesn't occupy the whole screen and leaves
                          /// room for the the RaisedButton
                          Expanded(child: checkoutListBuilder(snapshot)),
                          Padding(
                            padding: EdgeInsets.all(25),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(right: 25),
                                  child: Text(
                                    "Total:",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.lightGreen[800]),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 25),
                                  child: Text(
                                    "\$${bloc.totalCart()}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 28,
                                        color: Colors.lightGreen[800]),
                                  ),
                                )
                              ],
                            ),
                          ),
                          // SizedBox(height: 80)
                        ],
                      )
                    : Center(child: Text("You haven't taken any item yet"));
              },
            ),
          ))
        ]));
  }
}

Widget checkoutListBuilder(snapshot) {
  return Container(
    margin: EdgeInsets.only(top: 10),
    child: ListView.builder(
      itemCount: snapshot.data["cart items"].length,
      itemBuilder: (BuildContext context, i) {
        final cartList = snapshot.data["cart items"];
        return Card(
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
              child: ListTile(
                  onTap: () {
                    bloc.addCheck(cartList[i]);
                  },
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  leading: Checkbox(
                    value: cartList[i].perm,
                    onChanged: (val) {},
                  ),
                  title: Row(
                    children: <Widget>[
                      Container(
                          height: 81,
                          width: 62,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                  image: AssetImage(cartList[i].image)),
                              color: Colors.lightGreen[800])),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(cartList[i].title,
                                style: GoogleFonts.openSans(
                                    fontSize: 22,
                                    color: Colors.lightGreen[800],
                                    fontWeight: FontWeight.w400)),
                            Text(
                                "\$${int.parse(cartList[i].price) * cartList[i].count}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: Colors.lightGreen[800],
                                    fontSize: 16))
                          ],
                        ),
                      ),
                    ],
                  ),
                  trailing: Incdecwidget(cartList[i]))),
        );
      },
    ),
  );
}
