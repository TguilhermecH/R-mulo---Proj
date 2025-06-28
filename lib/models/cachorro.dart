class Cachorro {
String id;
String nome;
String raca;
String imagemUrl;
String responsavel;
bool adotado = false;

Cachorro({
required this.id,
required this.nome,
required this.raca,
required this.imagemUrl,
required this.responsavel,
this.adotado = false,
});

Map<String, dynamic> toMap() => {
'nome': nome,
'raca': raca,
'imagemUrl': imagemUrl,
'responsavel': responsavel,
};

factory Cachorro.fromMap(Map<String, dynamic> map) => Cachorro(
id: map['id'] ?? '',
nome: map['nome'],
raca: map['raca'],
imagemUrl: map['imagemUrl'],
responsavel: map['responsavel'],
);

Cachorro copyWith({
  String? id, 
  String? nome,
  String? raca, 
  String? imagemUrl,
  String? responsavel,
  bool? adotado,
}) {
  return Cachorro(
    id: id ?? this.id,
    nome: nome ?? this.nome,
    raca: raca ?? this.raca,
    imagemUrl: imagemUrl ?? this.imagemUrl,
    responsavel: responsavel ?? this.responsavel,
    adotado: adotado ?? this.adotado,
  );
}
}
