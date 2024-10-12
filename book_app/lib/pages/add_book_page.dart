import 'package:flutter/material.dart';
import 'package:book_app/global/lists.dart';
import 'package:book_app/models/item.dart';

class AddBookPage extends StatefulWidget {
  const AddBookPage({super.key});

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

final TextEditingController titleController = TextEditingController();
final TextEditingController authorController = TextEditingController();
final TextEditingController pageNumberController = TextEditingController();
final TextEditingController imageLinkController = TextEditingController();
final TextEditingController descriptionController = TextEditingController();

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
                controller: pageNumberController,
                decoration: const InputDecoration(
                    labelText: 'Введите количество страниц в книге:'),
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
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    // Собираем информацию с текстовых полей
                    String newTitle = titleController.text;
                    String newAuthor = authorController.text;
                    int newPageNum = int.parse(pageNumberController.text);
                    String newImageLink = imageLinkController.text;
                    String newDescription = descriptionController.text;

                    // Получаем id новой книги - такой, чтобы не было повторений
                    var maxId = items.reduce((currentItem, nextItem) =>
                        currentItem.id > nextItem.id ? currentItem : nextItem);

                    // Создаем новый объект
                    Item newBook = Item(maxId.id + 1, newTitle, newAuthor,
                        newPageNum, newImageLink, newDescription, false);

                    if (newBook.title.isNotEmpty &&
                        newBook.author.isNotEmpty &&
                        newBook.imageLink.isNotEmpty &&
                        newBook.description.isNotEmpty) {
                      // Очищаем текстовые поля для следующего ввода
                      titleController.text = '';
                      authorController.text = '';
                      pageNumberController.text = '';
                      imageLinkController.text = '';
                      descriptionController.text = '';

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
