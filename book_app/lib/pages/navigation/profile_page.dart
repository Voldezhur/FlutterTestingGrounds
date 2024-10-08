import 'package:flutter/material.dart';
import 'package:book_app/global/lists.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

final TextEditingController pictureLinkController = TextEditingController();

var imageLink =
    'https://static.vecteezy.com/system/resources/thumbnails/003/337/584/small/default-avatar-photo-placeholder-profile-icon-vector.jpg';

class _ProfilePageState extends State<ProfilePage> {
  void _saveImageLink() {
    setState(() {
      if (pictureLinkController.text != '') {
        imageLink = pictureLinkController.text;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
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
                  const Column(
                    children: [
                      Text(
                        'Имя пользователя',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        'Логин пользователя',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  Flexible(
                    child: TextField(
                      controller: pictureLinkController,
                      decoration: const InputDecoration(
                        label: Text('Введите ссылку на картинку профиля'),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: _saveImageLink,
                    icon: const Icon(Icons.save),
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
