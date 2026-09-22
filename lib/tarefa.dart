// tarefa.dart REPRESENTA O REGISTRO QUE SERÁ ARMAZENADO NA TABELA
class Tarefa {
  int? id;
  String descricao;
  String prioridade;
  String status;

  Tarefa({
    this.id,
    required this.descricao,
    required this.prioridade,
    required this.status,
  });

  // Converte um objeto Tarefa em um mapa
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'descricao': descricao,
      'prioridade': prioridade,
      'status': status,
    };
  }

  // Converte um registro do SQlite novamente em um objeto Tarefa
  factory Tarefa.fromMap(Map<String, dynamic> map) {
    return Tarefa(
      id: map['id'],
      descricao: map['descricao'],
      prioridade: map['prioridade'],
      status: map['status'],
    );
  }
}