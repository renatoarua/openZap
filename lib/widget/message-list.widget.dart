import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:openzap/controller/home.controller.dart';
import 'package:openzap/store/app.store.dart';
import 'package:openzap/widget/oz-busy.widget.dart';
import 'package:provider/provider.dart';

class MessageList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _appStore = Provider.of<AppStore>(context);
    final _homeController = new HomeController(_appStore, context);
    int _selectedId = -1;

    return Observer(
      builder: (_) => OZBusy(
        busy: _appStore.busy,
        child: _appStore.messages.length == 0
            ? Center(child: Text("Nenhuma mensagem cadastrada"))
            : ListView.builder(
                itemCount: _appStore.messages.length,
                itemBuilder: (context, index) {
                  var message = _appStore.messages[index];

                  return Column(
                    children: [
                      ListTile(
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          tooltip: 'Deletar Mensagem',
                          onPressed: () async {
                            await _homeController.remove(message);
                          },
                        ),
                        title: Text(message.title.toString()),
                        subtitle: Text(
                          message.text.toString(),
                          style: TextStyle(fontSize: 12),
                        ),
                        selected: _selectedId == message.id,
                        onTap: () {
                          _homeController.setMessage(message);
                          _selectedId = message.id;
                        },
                      ),
                      Divider(
                        height: 2,
                        thickness: 2,
                      ),
                    ],
                  );
                },
              ),
      ),
    );
  }
}
