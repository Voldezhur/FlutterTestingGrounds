import 'package:flutter/material.dart';
import 'package:book_app/global/lists.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

// Флаг редактирования профиля
var editing = false;

// Контроллеры для редактирования профиля
final TextEditingController pictureLinkController = TextEditingController();
final TextEditingController userNameController = TextEditingController();
final TextEditingController userLoginController = TextEditingController();

// Данные пользователя
var userName = 'Имя пользователя';
var userLogin = 'Логин пользователя';
var imageLink =
    'https://static.vecteezy.com/system/resources/thumbnails/003/337/584/small/default-avatar-photo-placeholder-profile-icon-vector.jpg';

class _ProfilePageState extends State<ProfilePage> {
  // Функция для сохранения изменений профиля
  void _saveChanges() {
    setState(() {
      if (pictureLinkController.text != '') {
        imageLink = pictureLinkController.text;
      } else {
        imageLink =
            'https://static.vecteezy.com/system/resources/thumbnails/003/337/584/small/default-avatar-photo-placeholder-profile-icon-vector.jpg';
      }

      userName = userNameController.text;
      userLogin = userLoginController.text;

      editing = false;
    });
  }

  void _toggleEditing() {
    setState(() {
      editing = !editing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return editing
        ? Scaffold(
            appBar: AppBar(
              title: const Text('Профиль'),
              actions: [
                IconButton(
                  onPressed: () => _saveChanges(),
                  icon: const Icon(Icons.save),
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.network(
                          imageLink,
                          height: 130,
                        ),
                        Column(
                          children: [
                            Text(
                              userName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            Text(
                              userLogin,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Flexible(
                      child: TextField(
                        controller: pictureLinkController,
                        decoration: const InputDecoration(
                          label: Text('Введите ссылку на картинку профиля'),
                        ),
                      ),
                    ),
                    Flexible(
                      child: TextField(
                        controller: userNameController,
                        decoration: const InputDecoration(
                          label: Text('Введите имя пользователя'),
                        ),
                      ),
                    ),
                    Flexible(
                      child: TextField(
                        controller: userLoginController,
                        decoration: const InputDecoration(
                          label: Text('Введите логин пользователя'),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Книг в библиотеке: ${items.length}',
                        ),
                        Text(
                          'Книг в избранном: ${items.where((item) => item.favourite).length}',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text('Профиль'),
              actions: [
                IconButton(
                  onPressed: () => _toggleEditing(),
                  icon: const Icon(Icons.edit),
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.network(
                          imageLink,
                          height: 130,
                        ),
                        Column(
                          children: [
                            Text(
                              userName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            Text(
                              userLogin,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Книг в библиотеке: ${items.length}',
                        ),
                        Text(
                          'Книг в избранном: ${items.where((item) => item.favourite).length}',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
