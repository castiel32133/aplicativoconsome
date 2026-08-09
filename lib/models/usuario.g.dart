// GENERATED CODE - User TypeAdapter (manually added here)
// If you prefer, run build_runner to generate this automatically.

part of 'usuario.dart';

class UsuarioAdapter extends TypeAdapter<Usuario> {
  @override
  final int typeId = 0;

  @override
  Usuario read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Usuario(
      id: fields[0] as String,
      nome: fields[1] as String,
      xp: fields[2] as int,
      nivel: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Usuario obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nome)
      ..writeByte(2)
      ..write(obj.xp)
      ..writeByte(3)
      ..write(obj.nivel);
  }
}
