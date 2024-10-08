// Класс для хранения записки

class Item {
  final int id;
  final String title;
  final String author;
  final int pageCount;
  final String imageLink;
  final String description;
  bool favourite;

  Item(this.id, this.title, this.author, this.pageCount, this.imageLink,
      this.description, this.favourite);
}
