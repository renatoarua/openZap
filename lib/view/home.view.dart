import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:openzap/controller/home.controller.dart';
import 'package:openzap/store/app.store.dart';
import 'package:openzap/widget/dialog/add-message.dialog.dart';
import 'package:openzap/widget/message-list.widget.dart';
import 'package:openzap/widget/snack-bar/snack-bar.snackBar.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeView extends StatefulWidget {
  const HomeView() : super();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late AppStore _appStore;
  late HomeController _homeController;

  final _formKey = GlobalKey<FormState>();
  TextEditingController _phoneNumberController = new TextEditingController();
  String _phoneNumber = '';
  String? _message;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _appStore = Provider.of<AppStore>(context);
    _homeController = new HomeController(_appStore);

    _homeController.loadPage();
    return _buildHome(context);
  }

  Widget _buildHome(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Container(
        color: Theme.of(context).primaryColorLight,
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          children: [
            Expanded(child: MessageList()),
            Divider(
              height: 4,
              thickness: 4,
            ),
            _buildSpaceY(5),
            _buildForm(context),
            _buildSpaceY(20),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    AddMessageDialog addMessageDialog = new AddMessageDialog(context);

    return AppBar(title: Text('OpenZap!'), actions: <Widget>[
      IconButton(
        icon: const Icon(Icons.add),
        tooltip: 'Adicionar Mensagem',
        onPressed: () {
          addMessageDialog.showMessageDialog();
        },
      ),
    ]);
  }

  Widget _buildSpaceY(double value) {
    return SizedBox(
      height: value,
    );
  }

  Widget _buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Expanded(
        child: ListView(
          children: [
            _buildMessageFild(context),
            _buildSpaceY(20),
            _buildTextFild(context),
            _buildSpaceY(20),
            _buildButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFild(BuildContext context) {
    MaskTextInputFormatter maskFormatter = new MaskTextInputFormatter(
        mask: '(##) # ####-####', filter: {"#": RegExp(r'[0-9]')});

    return TextFormField(
      controller: _phoneNumberController,
      keyboardType: TextInputType.number,
      autofocus: true,
      decoration: InputDecoration(
        labelText: "Celular",
        labelStyle: TextStyle(
          color: Theme.of(context).primaryColorDark,
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
        hintText: "(44) 9 9977 6655",
        hintStyle: TextStyle(
          fontStyle: FontStyle.italic,
          fontSize: 16,
          color: Theme.of(context).unselectedWidgetColor,
        ),
      ),
      style: TextStyle(
        fontSize: 20,
        color: Theme.of(context).primaryColorDark,
      ),
      inputFormatters: [maskFormatter],
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (value) {
        _onSubmit();
      },
      validator: (value) {
        if (value! == '')
          return "Insira um número";
        else if (value.length != 16) return "Número incorreto";

        return null;
      },
      onSaved: (value) {
        _phoneNumber = maskFormatter.getUnmaskedText();
      },
    );
  }

  Widget _buildMessageFild(BuildContext context) {
    return Observer(
      builder: (_) => TextFormField(
        controller: new TextEditingController(text: _appStore.message.text),
        autofocus: false,
        decoration: InputDecoration(
          labelText: "Mensagem",
          labelStyle: TextStyle(
            color: Theme.of(context).primaryColorDark,
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
          hintText: "Escreva sua mensagem",
          hintStyle: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 16,
            color: Theme.of(context).unselectedWidgetColor,
          ),
        ),
        style: TextStyle(
          fontSize: 20,
          color: Theme.of(context).primaryColorDark,
        ),
        maxLines: 3,
        textInputAction: TextInputAction.done,
        onSaved: (value) => {_message = value},
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return ElevatedButton(
      onPressed: _onSubmit,
      child: Text("Abrir no WhatsApp!"),
    );
  }

  void _openWhatsApp() async {
    String text = _appStore.message.text != null ? "&text=$_message" : "";
    String whatsappUrl = "whatsapp://send?phone=+55$_phoneNumber$text";

    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
      _homeController.afterSend();
      _phoneNumberController.clear();
      _message = '';
      _phoneNumber = '';
    } else {
      SnackBarAlert.buildSnackBarAlert(
          context, "WhatsApp não encontrado em seu dispositivo");
    }
  }

  _onSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _openWhatsApp();
    }
  }
}
