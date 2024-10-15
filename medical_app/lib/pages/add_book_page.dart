import 'package:flutter/material.dart';
import 'package:medical_app/global/lists.dart';
import 'package:medical_app/models/item.dart';

class AddBookPage extends StatefulWidget {
  const AddBookPage({super.key});

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

final TextEditingController titleController = TextEditingController();
final TextEditingController authorController = TextEditingController();
final TextEditingController imageLinkController = TextEditingController();
final TextEditingController descriptionController = TextEditingController();
final TextEditingController pageNumberController = TextEditingController();
final TextEditingController priceController = TextEditingController();

class _AddBookPageState extends State<AddBookPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Добавить книгу"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration:
                    const InputDecoration(labelText: 'Введите название книги:'),
              ),
              TextField(
                controller: authorController,
                decoration:
                    const InputDecoration(labelText: 'Введите имя автора:'),
              ),
              TextField(
                controller: imageLinkController,
                decoration: const InputDecoration(
                    labelText: 'Введите ссылку на обложку книги:'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                    labelText: 'Введите краткое описание книги:'),
              ),
              TextField(
                controller: pageNumberController,
                decoration: const InputDecoration(
                    labelText: 'Введите количество страниц в книге:'),
              ),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(
                  labelText: 'Введите стоимость книги',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    // Собираем информацию с текстовых полей
                    String newTitle = titleController.text;
                    String newAuthor = authorController.text;
                    String newImageLink = imageLinkController.text;
                    String newDescription = descriptionController.text;
                    int newPageNum = int.parse(pageNumberController.text);
                    int newPrice = int.parse(priceController.text);

                    // Получаем id новой книги - такой, чтобы не было повторений
                    var maxId = items.reduce((currentItem, nextItem) =>
                        currentItem.id > nextItem.id ? currentItem : nextItem);

                    // Создаем новый объект
                    Item newBook = Item(
                      maxId.id + 1,
                      newTitle,
                      newAuthor,
                      newImageLink,
                      newDescription,
                      newPageNum,
                      newPrice,
                      false,
                    );

                    if (newBook.title.isNotEmpty &&
                        newBook.author.isNotEmpty &&
                        newBook.imageLink.isNotEmpty &&
                        newBook.description.isNotEmpty) {
                      // Очищаем текстовые поля для следующего ввода
                      titleController.text = '';
                      authorController.text = '';
                      imageLinkController.text = '';
                      descriptionController.text = '';
                      pageNumberController.text = '';
                      priceController.text = '';

                      // Передаем новую книгу наверх
                      Navigator.pop(context, newBook);
                    }
                  },
                  child: const Text("Добавить книгу"))
            ],
          ),
        ),
      ),
    );
  }
}
