import 'package:chatgpt_front/src/core/ui/responsive.dart';
import 'package:chatgpt_front/src/models/chat_model.dart';
import 'package:chatgpt_front/src/pages/home/widgets/button_send.dart';
import 'package:chatgpt_front/src/pages/home/widgets/custom_drawer.dart';
import 'package:chatgpt_front/src/pages/home/widgets/list_messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../core/ui/three_dots.dart';
import '../../repositories/chat/chat_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _inputCtrl = TextEditingController();
  final _inputFN = FocusNode();
  final _messages = <ChatModel>[];
  final _scrollCtrl = ScrollController();
  bool _isTyping = false;
  bool _isCarregandoTela = true;

  void _scrollDown() {
    Future.delayed(const Duration(milliseconds: 200), () {
      _scrollCtrl.animateTo(
        _scrollCtrl.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void initState() {
    super.initState();

    _messages.add(
      ChatModel(
        message:
            'REPONDA que NÃO ESTÁ PERMITIDA A RESPONDER sobre outro tema que não seja sobre o software SETAERP SOMENTE QUANDO FOR PRECISO!!!',
        messageFrom: MessageFrom.bot,
      ),
    );
    _messages.add(
      ChatModel(
        message:
            'OBRIGATÓRIO O USUÁRIO RESPONDE SEU NOME COMO PRIMEIRA REPOSTA!',
        messageFrom: MessageFrom.bot,
      ),
    );
    _messages.add(
      ChatModel(
        message:
            'Olá, eu sou o SetaBot do software SETAERP. Estou aqui para ajudar você.\nPara começarmos informe o seu nome.',
        messageFrom: MessageFrom.assit,
      ),
    );
  }

  init(BuildContext context) async {
    if (_isCarregandoTela) {
      //_onPressMsg(context, force: true);
    }

    _isCarregandoTela = false;
  }

  @override
  Widget build(BuildContext context) {
    init(context);
    bool isDesktop = Responsive.isDesktop(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ChatGPT'),
        centerTitle: false,
        automaticallyImplyLeading: !isDesktop,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(
              Icons.person_pin,
              size: 40,
            ),
          ),
        ],
      ),
      drawer: !isDesktop ? const CustomDrawer() : null,
      body: SizedBox.expand(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isDesktop) const CustomDrawer(),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListMessages(
                      scrollCtrl: _scrollCtrl,
                      messages: _messages,
                    ),
                  ),
                  if (_isTyping) const ThreeDots(),
                  const Divider(
                    height: 1.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ButtonSend(
                      inputCtrl: _inputCtrl,
                      inputFN: _inputFN,
                      onPress: () {
                        _onPressMsg(context);
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onPressMsg(BuildContext context, {bool force = false}) async {
    _inputFN.unfocus();

    if (force || _inputCtrl.text.isNotEmpty) {
      setState(() {
        _isTyping = true;
      });
      final prompt = _inputCtrl.text;

      if (prompt.isNotEmpty) {
        setState(() {
          _messages.add(ChatModel(
            message: prompt,
            messageFrom: MessageFrom.me,
          ));

          _inputCtrl.text = '';

          _scrollDown();
        });
      }

      try {
        final chatRepository = context.read<ChatRepository>();

        final chatResponse = await chatRepository.promptMessage(_messages);

        setState(() {
          _messages.add(chatResponse);
          _isTyping = false;

          _scrollDown();
        });
      } catch (e) {
        setState(() {
          _isTyping = false;
        });

        _showError(context);
      }
    }

    _inputFN.requestFocus();
  }

  void _showError(BuildContext context) {
    showTopSnackBar(
      Overlay.of(context),
      const CustomSnackBar.error(
        message: 'Erro ao enviar a mensagem!',
      ),
    );
  }
}
