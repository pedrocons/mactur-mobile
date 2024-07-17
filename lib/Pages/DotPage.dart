import 'package:mactur_mobile/Pages/styles/ImputStyle.dart';
import './styles/shared_preferences.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mactur_mobile/Pages/Api/Sheets/SheetsApi.dart';
import 'package:mactur_mobile/Pages/model/User.dart';
import 'package:mactur_mobile/Pages/styles/TitleStyle.dart';

class DotPage extends StatefulWidget {
  const DotPage({super.key});

  @override
  State<DotPage> createState() => _DotPageState();
}

final formkey = GlobalKey<FormState>();
late TextEditingController motivo_deslocamentocontroller;
late TextEditingController deslocamentofinal_kmcontroller;
late TextEditingController deslocamentofinal_horacontroller;
late TextEditingController motoristacontroller;
late TextEditingController prefixcontroller;
late TextEditingController kmcontroller;
late TextEditingController deslocamentoini_kmcontroller;
late TextEditingController deslocamentoini_horacontroller;
late TextEditingController inicioimput_kmcontroller;
late TextEditingController inicioimput_horacontroller;
late TextEditingController kmimput_finalcontroller;
late TextEditingController hourimput_finalcontroller;

class _DotPageState extends State<DotPage> {
  String atual = '';
  String valorimput = '';

  String? get bosta => null;

  @override
  void initState() {
    super.initState();
    initUser();
    _retrieveValues();
    receviedeslocamento();
    recevieinicio();
    receviefinal();
  }

  void setatual() async {
    atual = await LocalDate.getString();
    setState(() {});
  }

  void initUser() {
    prefixcontroller = TextEditingController();
    motoristacontroller = TextEditingController();
    deslocamentoini_kmcontroller = TextEditingController();
    deslocamentoini_horacontroller = TextEditingController();
    motivo_deslocamentocontroller = TextEditingController();
    deslocamentofinal_kmcontroller = TextEditingController();
    deslocamentofinal_horacontroller = TextEditingController();
    inicioimput_kmcontroller = TextEditingController();
    inicioimput_horacontroller = TextEditingController();
    kmimput_finalcontroller = TextEditingController();
    hourimput_finalcontroller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Registro de ponto",
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 228, 183, 1),
      ),
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //Prefixo
                    SizedBox(
                      width: 150,
                      child: TextFormField(
                        controller: prefixcontroller,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: const InputDecoration(
                          labelText: "Prefixo do veículo :",
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: TextFormField(
                        controller: motoristacontroller,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: "Motorista :",
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString('prefixo', prefixcontroller.text);
                      prefs.setString('motorista', motoristacontroller.text);
                    },
                    child: const Text('Salvar')),

                divisor(),
                //Deslocamento Inicial
                Container(
                  width: MediaQuery.sizeOf(context).width * 0.95,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: Column(
                    children: [
                      deslocamento(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          //Deslocamento Inicial Km
                          SizedBox(
                            width: 130,
                            child: TextFormField(
                              controller: deslocamentoini_kmcontroller,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                KmInputFormatter(),
                              ],
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: "Quilometragem :",
                                suffix: Text("km"),
                              ),
                            ),
                          ),
                          //Deslocamento inicial hora
                          SizedBox(
                            width: 120,
                            child: TextFormField(
                              readOnly: true,
                              controller: deslocamentoini_horacontroller,
                              keyboardType: TextInputType.datetime,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                HoraInputFormatter(),
                              ],
                              decoration: const InputDecoration(
                                labelText: "Hora :",
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      //Deslocamento inicial motivo
                      TextFormField(
                        controller: motivo_deslocamentocontroller,
                        decoration: const InputDecoration(
                            labelText: 'Motivo do Deslocamento  :'),
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setString('deslocamentokm',
                                deslocamentoini_kmcontroller.text);
                            await prefs.setString('deslocamentohora',
                                DateFormat('kk:mm').format(DateTime.now()));
                            await prefs.setString('deslocamentomotivo',
                                motivo_deslocamentocontroller.text);
                            setState(() {
                              deslocamentoini_horacontroller.text =
                                  prefs.getString('deslocamentohora') ?? '';
                              motivo_deslocamentocontroller.text =
                                  prefs.getString('deslocamentomotivo') ?? '';
                            });
                          },
                          child: const Text('Salvar')),
                    ],
                  ),
                ),
                divisor(),
                //Deslocamento final
                Container(
                  width: MediaQuery.sizeOf(context).width * 0.95,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: Column(
                    children: [
                      deslocamento_final(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          //Deslocamento final Km
                          SizedBox(
                            width: 130,
                            child: TextFormField(
                              controller: deslocamentofinal_kmcontroller,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                KmInputFormatter(),
                              ],
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: "Quilometragem :",
                                suffix: Text("km"),
                              ),
                            ),
                          ),
                          //Deslocamento final hora
                          SizedBox(
                            width: 120,
                            child: TextFormField(
                              readOnly: true,
                              controller: deslocamentofinal_horacontroller,
                              keyboardType: TextInputType.datetime,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                HoraInputFormatter(),
                              ],
                              decoration: const InputDecoration(
                                labelText: "Hora :",
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setString('deslocamentofinalkm',
                                deslocamentoini_kmcontroller.text);
                            await prefs.setString('deslocamentofinalhora',
                                DateFormat('kk:mm').format(DateTime.now()));
                            setState(() {
                              deslocamentofinal_horacontroller.text =
                                  prefs.getString('deslocamentofinalhora') ??
                                      '';
                            });
                          },
                          child: const Text('Salvar')),
                    ],
                  ),
                ),
                divisor(),
                // Inicio Linha
                Container(
                  width: MediaQuery.sizeOf(context).width * 0.95,
                  padding: const EdgeInsets.all(20),
                  decoration: borda(),
                  child: Column(
                    children: [
                      titlebegin(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // Inicio_Linha_km
                          SizedBox(
                            width: 130,
                            child: TextFormField(
                              controller: inicioimput_kmcontroller,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                KmInputFormatter(),
                              ],
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: "Quilometragem :",
                                suffix: Text("km"),
                              ),
                            ),
                          ),
                          //Inicio_Linha_hora
                          SizedBox(
                            width: 120,
                            child: TextFormField(
                              readOnly: true,
                              controller: inicioimput_horacontroller,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                HoraInputFormatter(),
                              ],
                              decoration: const InputDecoration(
                                labelText: "Hora :",
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setString(
                                'iniciokm', inicioimput_kmcontroller.text);
                            prefs.setString('iniciohora',
                                DateFormat('kk:mm').format(DateTime.now()));
                            setState(() {
                              inicioimput_horacontroller.text =
                                  prefs.getString('iniciohora') ?? '';
                            });
                          },
                          child: const Text('Salvar')),
                    ],
                  ),
                ),
                divisor(),
                //Final Linha
                Container(
                  width: MediaQuery.sizeOf(context).width * 0.95,
                  padding: const EdgeInsets.all(20),
                  decoration: borda(),
                  child: Column(
                    children: [
                      titlefinal(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          //Final_Linha_km
                           SizedBox(
                            width: 130,
                            child: TextFormField(
                              controller: kmimput_finalcontroller,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                KmInputFormatter(),
                              ],
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: "Quilometragem :",
                                suffix: Text("km"),
                              ),
                            ),
                          ),
                          //Final_Linha_hora
                          SizedBox(
                            width: 120,
                            child: TextFormField(
                              readOnly: true,
                              controller: hourimput_finalcontroller,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                HoraInputFormatter(),
                              ],
                              decoration: const InputDecoration(
                                labelText: "Hora :",
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setString(
                                'finalkm', kmimput_finalcontroller.text);
                            prefs.setString('finalhora',
                                DateFormat('kk:mm').format(DateTime.now()));
                            setState(() {
                              hourimput_finalcontroller.text =
                                  prefs.getString('finalhora') ?? '';
                            });
                          },
                          child: const Text('Salvar')),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final user = User(
                      Motorista: motoristacontroller.text,
                      Data: DateFormat('dd-MM-yyyy').format(DateTime.now()),
                      Prefixo: prefixcontroller.text,
                      Deslocamento_Inicial_km:
                          deslocamentoini_kmcontroller.text.toString(),
                      Deslocamento_Inicial_hora:
                          deslocamentoini_horacontroller.text,
                      Inicio_Linha_km: inicioimput_kmcontroller.text,
                      Inicio_Linha_hora:
                          inicioimput_horacontroller.text.toString(),
                      Final_Linha_km: kmimput_finalcontroller.text,
                      Final_Linha_hora:
                          hourimput_finalcontroller.text.toString(),
                      Deslocamento_final_km:
                          deslocamentofinal_kmcontroller.text,
                      Deslocamento_final_hora:
                          deslocamentofinal_horacontroller.text.toString(),
                      Deslocamento_Motivo: motivo_deslocamentocontroller.text,
                    );
                    await excel_api.insert(([user.toJson()]));
                    clear();
                    clear_database();
                    Finaly();
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: const Text("Registrar"),
                ),
                const SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  receviedeslocamento() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      deslocamentoini_kmcontroller.text =
          prefs.getString('deslocamentokm') ?? '';
      deslocamentoini_horacontroller.text = prefs.getString(bosta!) ?? '';
    });
  }

  recevieinicio() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      inicioimput_kmcontroller.text = prefs.getString('iniciokm') ?? '';
      inicioimput_horacontroller.text = prefs.getString('iniciohora') ?? '';
    });
  }

  receviefinal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      kmimput_finalcontroller.text = prefs.getString('finalkm') ?? '';
      hourimput_finalcontroller.text = prefs.getString('finalhora') ?? '';
    });
  }

  _retrieveValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefixcontroller.text = prefs.getString('prefixo') ?? '';
      motoristacontroller.text = prefs.getString('motorista') ?? '';
    });
  }

  clear() {
    motivo_deslocamentocontroller.clear();
    deslocamentofinal_horacontroller.clear();
    deslocamentofinal_kmcontroller.clear();
    deslocamentoini_kmcontroller.clear();
    deslocamentoini_horacontroller.clear();
    inicioimput_kmcontroller.clear();
    inicioimput_horacontroller.clear();
    kmimput_finalcontroller.clear();
    hourimput_finalcontroller.clear();
  }

  clear_database() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('deslocamentofinalkm');
    prefs.remove('deslocamentofinalhora');
    prefs.remove('finalkm');
    prefs.remove('finalhora');
    prefs.remove('iniciokm');
    prefs.remove('iniciohora');
    prefs.remove('deslocamentokm');
    prefs.remove('deslocamentohora');
  }

  Finaly() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Sucesso!',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text(' As informações foram enviadas para a central.'),
        actions: [
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }
}
