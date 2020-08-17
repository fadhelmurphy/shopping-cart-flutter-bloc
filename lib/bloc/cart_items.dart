/// The [dart:async] is neccessary for using streams
import 'dart:async';

class CartItemsBloc {
  /// The [cartStreamController] is an object of the StreamController class
  /// .broadcast enables the stream to be read in multiple screens of our app

  var cartStreamController = StreamController.broadcast();

  /// The [getStream] getter would be used to expose our stream to other classes
  Stream get getStream => cartStreamController.stream;
  var allItems = {
    'prod': [
      {
        "id": "1",
        "title": "You’re A Miracle",
        "author": "Mike McHargue",
        "price": "20",
        "image": "assets/images/img_popular_book1.png",
        "color": 0xFFFFD3B6,
        "description":
            "“Holding brain science in one hand and rich emotional presence in the other, this book feels timely and necessary.”—Shauna Niequist, New York Times bestselling author of Present Over Perfect\n\nWhy is there such a gap between what you want to do and what you actually do? The host of Ask Science Mike explains why our desires and our real lives are so wildly different—and what you can do to close the gap.\n\nFor thousands of years, scientists, philosophers, and self-help gurus have wrestled with one of the basic conundrums of human life: Why do we do the things we do? Or, rather, why do we so often not do the things we want to do? As a podcast host whose voice goes out to millions each month, Mike McHargue gets countless emails from people seeking to understand their own misbehavior—why we binge on Netflix when we know taking a walk outside would be better for us, or why we argue politics on Facebook when our real friends live just down the street. Everyone wants to be a good person, but few of us, twenty years into the new millennium, have any idea how to do that.\n\nIn You’re a Miracle (and a Pain in the Ass), McHargue addresses these issues. We like to think we’re in control of our thoughts and decisions, he writes, but science has shown that a host of competing impulses, emotions, and environmental factors are at play in every action we undertake. Touching on his podcast listeners’ most pressing questions, from relationships and ethics to stress and mental health, and sharing some of the biggest triumphs and hardships from his own life, McHargue shows us how some of our qualities that seem most frustrating—including “negative” emotions like sadness, anger, and anxiety—are actually key to helping humans survive and thrive. In doing so, he invites us on a path of self-understanding and, ultimately, self-acceptance.\n\nYou’re a Miracle (and a Pain in the Ass) is a guided tour through the mystery of human consciousness, showing readers how to live more at peace with themselves in a complex world."
      ,"count":0,
        "perm":false
      },
      {
        "id": "2",
        "title": "Pattern Maker",
        "author": "Kerry Johnston",
        "price": "40",
        "image": "assets/images/img_popular_book2.png",
        "color": 0xFF2B325C,
        "description":
            "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text.\n\nAll the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc."
      ,"count":0,
        "perm":false
      },
      {
        "id": "3",
        "title": "Papercraf",
        "author": "Mike Brown",
        "price": "60",
        "image": "assets/images/img_popular_book3.png",
        "color": 0xFFF7EA4A,
        "description":
            "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of \"de Finibus Bonorum et Malorum\" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, \"Lorem ipsum dolor sit amet..\", comes from a line in section 1.10.32.\n\nThe standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from \"de Finibus Bonorum et Malorum\" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham."
        ,"count":0,
        "perm":false
      }
    ],
    'cart items': []
  };

  addToCart(item) {
    print(item.count.toString()+"ZZZZ1");
    if (item.count == 0) {
      allItems['cart items'].add(item);
    }
    allItems['prod']
        .forEach((e) => (e["id"] == item.id ? e["count"] += 1 : e["count"]));
    allItems['cart items']
        .forEach((e) => (e.id == item.id ? e.count += 1 : e.count));
    cartStreamController.sink.add(allItems);
    print(item.count.toString()+"ZZZZ2");
  }

  addCheck(item){
    allItems['prod']
        .forEach((e) => (e["id"]==item.id?e["perm"] == false? e["perm"] = true: e["perm"]?e["perm"]=false:e["perm"]:e["id"]));
    cartStreamController.sink.add(allItems);
    allItems['cart items']
        .forEach((e) => (e.id==item.id?e.perm == false? e.perm = true: e.perm?e.perm=false:e.perm:e.id));
    cartStreamController.sink.add(allItems);
  }

  decrease(item) {
    allItems['prod']
        .forEach((e) => (e["id"] == item.id ? e["count"]-- : e["count"]));
    allItems['cart items']
        .forEach((e) => (e.id == item.id ? e.count-- : e.count));
    cartStreamController.sink.add(allItems);
  }

  removeFromCart(item) {
    allItems['prod']
        .forEach((e) => (e["id"] == item.id ? e["count"]=0 : e["count"]));
    allItems['cart items']
        .forEach((e) => (e.id == item.id ? e.count = 0 : e.count));
    allItems['cart items'].remove(item);
    // allItems['shop items'].add(item);
    cartStreamController.sink.add(allItems);
  }

  totalCart() {
    final totalAngka = allItems['cart items'].fold(
        0, (total, number) => total + (int.parse(number.price) * number.count));
    return totalAngka;
  }

  getAllCount() {
    final totalAngka =
        allItems['cart items'].fold(0, (total, number) => total + number.count);
    // var total = 0;
    // allItems['cart items'].forEach((item) => total += item.count);
    return totalAngka;
  }

  /// The [dispose] method is used
  /// to automatically close the stream when the widget is removed from the widget tree
  dispose() {
    cartStreamController.close(); // close our StreamController
  }
}

final bloc = CartItemsBloc();
