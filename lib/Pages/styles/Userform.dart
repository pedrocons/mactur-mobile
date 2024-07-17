import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:mactur_mobile/Pages/DotPage.dart';
import 'package:mactur_mobile/Pages/model/User.dart';

class UserFormWidget extends StatefulWidget {
  final ValueChanged<User> onSavedUser;
  const UserFormWidget(
      {super.key,
      required Future<Null> Function(dynamic user) OnSavedUser,
      required this.onSavedUser});

  @override
  State<UserFormWidget> createState() => _UserFormWidgetState();
}

class _UserFormWidgetState extends State<UserFormWidget> {
  @override
  Widget build(BuildContext context) => buildSubmit();

  Widget buildSubmit() => ElevatedButton(
        child: const Text('Save'),
        onPressed: () {
          final form = formkey.currentState!;
          final isvalid = form.validate();
          if (isvalid) {
            final user = User(
              Motorista: motoristacontroller.text.toLowerCase(),
              Data: DateTime.now().weekday.toString(),
              Deslocamento_Inicial_km: deslocamentoini_kmcontroller.text,
              Deslocamento_Inicial_hora:
                  deslocamentoini_horacontroller.text.toString(),
              Inicio_Linha_km: inicioimput_kmcontroller.text,
              Inicio_Linha_hora: inicioimput_horacontroller.text.toString(),
              Final_Linha_km: kmimput_finalcontroller.text,
              Final_Linha_hora: hourimput_finalcontroller.text.toString(),
              Prefixo: prefixcontroller.text,
              Deslocamento_final_km: deslocamentofinal_kmcontroller.text,
              Deslocamento_final_hora:
                  deslocamentofinal_horacontroller.text.toString(),
              Deslocamento_Motivo: motivo_deslocamentocontroller.text,
            );
          }
        },
      );
}
