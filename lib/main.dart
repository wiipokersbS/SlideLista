import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:layout_lista_notificacao/model/users.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  String data = 'PRU';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

enum Actions { share, delete, archive }

class _MyHomePageState extends State<MyHomePage> {
  List<User> usuarios = allUsers;
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('Layout Notificação');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Layout Notificação'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
              if (customIcon.icon == Icons.search) {
                customIcon = const Icon(Icons.cancel);
                customSearchBar = const ListTile(
                  leading: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 28,
                  ),
                  title: TextField(
                    decoration: InputDecoration(
                      hintText: 'type in journal name...',
                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                      ),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
              } else {
                customIcon = const Icon(Icons.search);
                customSearchBar = const Text('PRU');
              }
            },
            icon: customIcon,
          ),
        ],
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
            UserAccountsDrawerHeader(
              accountName: Text('Pru'),
              accountEmail: Text('user@pru.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://img.freepik.com/vetores-premium/perfil-de-avatar-de-mulher-no-icone-redondo_24640-14042.jpg?w=2000'),
              ),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: usuarios.length,
        itemBuilder: (context, index) {
          final user = usuarios[index];
          return Slidable(
              key: Key(user
                  .nome!), //chave definida para identificar a "mudança", no caso de ter id, deve ser id
              startActionPane: ActionPane(
                motion: const StretchMotion(),
                dismissible: DismissiblePane(
                  onDismissed: () => _onDismissed(index, Actions.share),
                ),
                children: [
                  SlidableAction(
                    backgroundColor: Colors.green,
                    icon: Icons.share,
                    label: 'Share',
                    onPressed: (BuildContext context) =>
                        _onDismissed(index, Actions.share),
                  ),
                  SlidableAction(
                    backgroundColor: Colors.blue,
                    icon: Icons.archive,
                    label: 'Archive',
                    onPressed: (BuildContext context) =>
                        _onDismissed(index, Actions.archive),
                  ),
                ],
              ),
              endActionPane: ActionPane(
                motion: const BehindMotion(),
                dismissible: DismissiblePane(
                  onDismissed: () => _onDismissed(index, Actions.delete),
                ),
                children: [
                  SlidableAction(
                    backgroundColor: Colors.red,
                    icon: Icons.delete,
                    label: 'Delete',
                    onPressed: (BuildContext context) =>
                        _onDismissed(index, Actions.delete),
                  ),
                ],
              ),
              child: buildListTitles(user));
        },
      ),
    );
  }

  void _onDismissed(int index, Actions actions) {
    // ações vs notificação de qual foi feita com qual usuário
    final user = usuarios[index];
    setState(() => usuarios.removeAt(index));

    switch (actions) {
      case Actions.delete:
        _showSnackBar(context, '${user.nome} foi deletado', Colors.red);
        break;
      case Actions.archive:
        _showSnackBar(context, '${user.nome} foi arquivado', Colors.blue);
        break;
      case Actions.share:
        _showSnackBar(context, '${user.nome} foi compartilhado', Colors.green);
        break;
    }
  }

  void _showSnackBar(BuildContext context, String mensagem, Color cor) {
    //responsável pelo comportamento da notificação
    final snackBar = SnackBar(content: Text(mensagem), backgroundColor: cor);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget buildListTitles(User user) => Builder(
        //componente da lista, com comportamento de slide
        builder: (context) => SlidableAutoCloseBehavior(
          closeWhenOpened: true,
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            title: Text(user!.nome!),
            subtitle: Text(user!.email!),
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(user.image!),
            ),
            onTap: () {
              // ação do item dentro da lista
              final slidable = Slidable.of(context)!;
              final isClosed =
                  slidable.actionPaneType.value == ActionPaneType.none;
              if (isClosed) {
                slidable.openStartActionPane();
              } else {
                slidable.close();
              }
            },
          ),
        ),
      );
}
