class PopularBookModel {
  String id,title, author, price, image, description;
  int color,count;
  bool perm;

  PopularBookModel(this.id,this.title, this.author, this.price, this.image, this.color,
      this.description,this.count,this.perm);

}

// List populars = populars
//     .map((item) => PopularBookModel(item['id'],item['title'], item['author'],
//         item['price'], item['image'], item['color'], item['description'],0,true)).toList();
