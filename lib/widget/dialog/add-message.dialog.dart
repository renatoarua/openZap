import 'package:flutter/material.dart';
import 'package:openzap/controller/home.controller.dart';
import 'package:openzap/repository/entity/message.entity.dart';
import 'package:openzap/store/app.store.dart';
import 'package:openzap/widget/snack-bar/snack-bar.snackBar.dart';
import 'package:provider/provider.dart';

class AddMessageDialog {
  final _formKey = GlobalKey<FormState>();
  Message _message = new Message();
  late BuildContext _context;
  late HomeController _homeController;
  late AppStore _appStore;
  // TextEditingController _titleController = new TextEditingController();
  // TextEditingController _messageController = new TextEditingController();

  AddMessageDialog(BuildContext context) {
    _context = context;
    _appStore = Provider.of<AppStore>(context);
    _homeController = new HomeController(_appStore, context);
  }

  showMessageDialog() {
    showDialog(
        context: _context,
        builder: (_) {
          return AlertDialog(
            title: Text(
              'Mensagem',
              style: TextStyle(
                color: Theme.of(_context).primaryColorDark,
              ),
            ),
            content: SingleChildScrollView(
              // height: 300,
              child: Form(
                key: _formKey,
                child: Column(children: [
                  TextFormField(
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: "Título",
                      labelStyle: TextStyle(
                        color: Theme.of(_context).primaryColorDark,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                      hintText: "Escreva seu título",
                      hintStyle: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 16,
                        color: Theme.of(_context).unselectedWidgetColor,
                      ),
                    ),
                    onSaved: (value) => {_message.title = value},
                    onFieldSubmitted: (value) {},
                    validator: (value) {
                      if (value! == '') return 'Informe um título';

                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Mensagem",
                      labelStyle: TextStyle(
                        color: Theme.of(_context).primaryColorDark,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                      hintText: "Escreva sua mensagem",
                      hintStyle: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 16,
                        color: Theme.of(_context).unselectedWidgetColor,
                      ),
                    ),
                    maxLines: 8,
                    onSaved: (value) => {_message.text = value},
                    validator: (value) {
                      if (value! == '') return 'Informe uma mensagem';

                      return null;
                    },
                  ),
                ]),
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () => {Navigator.of(_context).pop()},
                  child: Text('Cancelar')),
              ElevatedButton(
                  onPressed: () => {
                        _onSubmit(),
                      },
                  child: Text('Adicionar'))
            ],
          );
        });
  }

  _onSubmit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      var result = await _homeController.add(_message);
      if (result) {
        Navigator.of(_context).pop();
        SnackBarAlert.buildSnackBarSuccefull(_context, "Mensagem criada");
      } else {
        SnackBarAlert.buildSnackBarError(_context, "Mensagem não criada");
      }
    }
  }
}
