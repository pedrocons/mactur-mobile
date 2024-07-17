import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mactur_mobile/Pages/DotPage.dart';

// ignore: non_constant_identifier_names
SizedBox deslocamentoinicialimput_km(
    {required TextEditingController controller}) {
  return (SizedBox(
    width: 130,
    child: TextFormField(
      inputFormatters: [
        KmInputFormatter(),
      ],
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: "Quilometragem :",
        suffix: Text("km"),
      ),
    ),
  ));
}

// ignore: non_constant_identifier_names
SizedBox deslocamentoinicialimput_hora({required controller}) {
  return (SizedBox(
    width: 120,
    child: TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        HoraInputFormatter(),
      ],
      decoration: const InputDecoration(
        labelText: "Hora :",
      ),
    ),
  ));
}

SizedBox inicioimput_km({required controller}) {
  return (SizedBox(
    width: 130,
    child: TextFormField(
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
  ));
}

SizedBox inicioimput_hora({required controller}) {
  return (SizedBox(
    width: 120,
    child: TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        HoraInputFormatter(),
      ],
      decoration: const InputDecoration(
        labelText: "Hora :",
      ),  
    ),
  ));
}

SizedBox kmimputfinal({required controller}) {
  return (SizedBox(
    width: 130,
    child: TextFormField(
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
  ));
}

SizedBox hourimputfinal({required controller}) {
  return (SizedBox(
    width: 120,
    child: TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        HoraInputFormatter(),
      ],
      decoration: const InputDecoration(
        labelText: "Hora :",
      ),
    ),
  ));
}

SizedBox prefix({required controller}) {
  return (SizedBox(
    width: 200,
    child: TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      decoration: const InputDecoration(
        labelText: "Prefixo do veículo :",
      ),
    ),
  ));
}

BoxDecoration borda() {
  return BoxDecoration(
      border: Border.all(),
      borderRadius: const BorderRadius.all(Radius.circular(20)));
}
