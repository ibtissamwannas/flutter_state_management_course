import 'package:flutter/material.dart';

class TextMain extends StatelessWidget {
  const TextMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contacts')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return NewContactPhone();
              },
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      body: ValueListenableBuilder(
        valueListenable: ContactBook(),
        builder: (BuildContext context, value, Widget? child) {
          return ListView.builder(
            itemCount: value.length,
            itemBuilder: (context, index) {
              return Dismissible(
                onDismissed: (direction) {
                  ContactBook().remove(contact: value[index]);
                },
                key: ValueKey(value[index].id),
                child: ListTile(
                  title: Text(value[index].name),
                  subtitle: Text(value[index].phone),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ContactBook extends ValueNotifier<List<Contact>> {
  ContactBook._() : super(contacts);
  static final ContactBook shared = ContactBook._();
  factory ContactBook() => shared;

  int get length => value.length;

  void add({required Contact contact}) {
    value.add(contact);
    notifyListeners();
  }

  void remove({required Contact contact}) {
    if (value.contains(contact)) {
      value.remove(contact);
      notifyListeners();
    }
  }
}

class Contact {
  final int id;
  final String name;
  final String phone;
  const Contact({required this.id, required this.name, required this.phone});
}

List<Contact> contacts = [
  const Contact(id: 1, name: 'John Doe', phone: '1234567890'),
  const Contact(id: 2, name: 'Jane Doe', phone: '0987654321'),
];

class NewContactPhone extends StatefulWidget {
  const NewContactPhone({super.key});

  @override
  State<NewContactPhone> createState() => _NewContactPhoneState();
}

class _NewContactPhoneState extends State<NewContactPhone> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Contact')),
      body: Column(
        children: [
          TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Enter a new contact name here',
            ),
          ),
          TextButton(
            onPressed: () {
              ContactBook().add(
                contact: Contact(
                  id: 3,
                  name: controller.text,
                  phone: '1234567890',
                ),
              );
              Navigator.of(context).pop();
            },
            child: const Text('Add Contact'),
          ),
        ],
      ),
    );
  }
}
