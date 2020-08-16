import 'package:flutter/material.dart';
import 'package:perpus/models/popularbook_model.dart';
import '../bloc/cart_items.dart';

class Incdecwidget extends StatelessWidget {
  // const Incdecwidget({Key key}) : super(key: key);
  final PopularBookModel cartList;
  Incdecwidget(this.cartList);

  double _buttonWidth = 30;



  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 25),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300], width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(vertical: 5),
      width: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox(
            width: _buttonWidth,
            height: _buttonWidth,
            child: FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: () {
                  if (cartList.count > 1) {
                     bloc.decrease(cartList);
                  }else{
                    bloc.removeFromCart(cartList);
                  }
              },
              child: Text(
                "-",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22,color: Colors.orange[800]),
              ),
            ),
          ),
          Text(
            cartList.count.toString(),
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22,color: Colors.grey[800]),
          ),
          SizedBox(
            width: _buttonWidth,
            height: _buttonWidth,
            child: FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: () {
                bloc.addToCart(cartList);
              },
              child: Text(
                "+",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22,color: Colors.lightGreen[900]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
