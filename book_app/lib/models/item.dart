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
}
