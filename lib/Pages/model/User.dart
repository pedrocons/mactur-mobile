class userfields {
  static final String Data = 'Data';
  static final String id = 'id';
  static final String Prefixo = 'Prefixo';
  static final String Nome = 'Motorista';
  static final String Deslocamento_Inicial_km = 'Deslocamento_Inicial_km';
  static final String Deslocamento_Inicial_hora = 'Deslocamento_Inicial_hora';
  static final String Deslocamento_Final_km = 'Deslocamento_Final_km';
  static final String Deslocamento_Final_hora = 'Deslocamento_Final_hora';
  static final String Inicio_Linha_km = 'Inicio_Linha_km';
  static final String Inicio_Linha_hora = 'Inicio_Linha_hora';
  static final String Final_Linha_km = 'Final_Linha_km';
  static final String Final_Linha_hora = 'Final_Linha_hora';
  static final String Motivo_Deslocamento = 'Motivo_Deslocamento';

  static List<String> getfields() => [
        Data,
        Nome,
        Prefixo,
        Deslocamento_Inicial_km,
        Deslocamento_Inicial_hora,
        Deslocamento_Final_km,
        Deslocamento_Final_hora,
        Inicio_Linha_km,
        Inicio_Linha_hora,
        Final_Linha_km,
        Final_Linha_hora,
        Motivo_Deslocamento,
      ];
}

class User {
  final String Final_Linha_hora;
  final String Final_Linha_km;
  final String Inicio_Linha_hora;
  final String Motorista;
  final String Data;
  final String Prefixo;
  final String Deslocamento_Inicial_km;
  final String Deslocamento_Inicial_hora;
  final String Deslocamento_final_km;
  final String Deslocamento_final_hora;
  final String Inicio_Linha_km;
  final String Deslocamento_Motivo;
  const User({
    required this.Deslocamento_final_km,
    required this.Deslocamento_final_hora,
    required this.Final_Linha_hora,
    required this.Final_Linha_km,
    required this.Inicio_Linha_hora,
    required this.Inicio_Linha_km,
    required this.Deslocamento_Inicial_hora,
    required this.Motorista,
    required this.Data,
    required this.Prefixo,
    required this.Deslocamento_Inicial_km,
    required this.Deslocamento_Motivo,
  });

  Map<String, dynamic> toJson() => {
        userfields.Final_Linha_hora: Final_Linha_hora,
        userfields.Final_Linha_km: Final_Linha_km,
        userfields.Nome: Motorista,
        userfields.Data: Data,
        userfields.Prefixo: Prefixo,
        userfields.Deslocamento_Inicial_km: Deslocamento_Inicial_km,
        userfields.Deslocamento_Inicial_hora: Deslocamento_Inicial_hora,
        userfields.Deslocamento_Final_km: Deslocamento_final_km,
        userfields.Deslocamento_Final_hora: Deslocamento_final_hora,
        userfields.Inicio_Linha_km: Inicio_Linha_km,
        userfields.Inicio_Linha_hora: Inicio_Linha_hora,
        userfields.Motivo_Deslocamento: Deslocamento_Motivo,
      };
}
