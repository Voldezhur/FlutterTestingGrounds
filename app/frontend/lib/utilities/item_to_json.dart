import 'package:book_app/models/item.dart';

Object itemToJson(
  Item item, {
  id,
  title,
  author,
  imagelink,
  description,
  pagecount,
  price,
  favourite,
}) {
  return {
    'ID': id ?? item.id,
    'Title': title ?? item.title,
    'Author': author ?? item.author,
    'ImageLink': imagelink ?? item.imageLink,
    'Description': description ?? item.description,
    'PageCount': pagecount ?? item.pageCount,
    'Price': price ?? item.price,
    'Favourite': favourite ?? item.favourite
  };
}
