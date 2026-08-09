// lib/models/usuario.dart
import 'package:hive/hive.dart';

part 'usuario.g.dart';

@HiveType(typeId: 0)
class Usuario extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String nome;

  @HiveField(2)
  int xp;

  @HiveField(3)
  int nivel;

  Usuario({
    required this.id,
    required this.nome,
    required this.xp,
    required this.nivel,
  });

  factory Usuario.empty(String id) => Usuario(id: id, nome: '', xp: 0, nivel: 1);

  void addXp(int amount) {
    xp += amount;
    if (xp >= 1000) {
      int carry = xp ~/ 1000;
      nivel += carry;
      xp = xp % 1000;
    }
  }

  void reset() {
    nome = '';
    xp = 0;
    nivel = 1;
  }
}
