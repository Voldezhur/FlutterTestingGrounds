// Класс книг

class Item {
  final int id;
  final String title;
  final String author;
  final String imageLink;
  final String description;
  final int pageCount;
  final int price;

  bool favourite;

  Item(this.id, this.title, this.author, this.imageLink, this.description,
      this.pageCount, this.price, this.favourite);

  // Для того, чтобы можно было создавать объекты из JSON
  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      json['ID'],
      json['Title'],
      json['Author'],
      json['ImageLink'],
      json['Description'],
      json['PageCount'],
      json['Price'],
      json['Favourite'],
    );
  }
}
