class Product {
  final int productId;
  final String name;
  final String description;
  final int price;
  final String imageUrl;
  final int creatorId;

  Product(this.productId, this.name, this.description, this.price,
      this.imageUrl, this.creatorId);

  // Для того, чтобы можно было создавать объекты из JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    print(json);
    print('fuc');
    return Product(
      json['product_id'],
      json['name'],
      json['description'],
      json['price'],
      json['image_url'],
      json['creator_id'],
    );
  }
}
