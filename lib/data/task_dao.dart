import 'package:sqflite/sqflite.dart';
import '../components/task.dart';
import 'database.dart';

class TaskDao {
  //Criação do banco de dados.

  static const String tableSql = 'CREATE TABLE $_tablename('
      '$_name TEXT, '
      '$_dificulty INTEGER, '
      '$_image TEXT)';

  static const String _tablename = 'taskTable';
  static const String _name = 'name';
  static const String _dificulty = 'dificulty';
  static const String _image = 'image';

  //Função de Salvar Tarefa.

  save(Task tarefa) async {
    print('Iniciando o save: ');
    final Database bancoDeDados = await getDatabase(); //carrega o banco de dados
    var itemExist = await find(tarefa.nome);

    Map <String, dynamic> taskMap = toMap(tarefa);

    if(itemExist.isEmpty){
      print('A tarefa não existia!!');
      return await bancoDeDados.insert(_tablename, taskMap);
    } //verifica se a tarefa não existe.
    else{
      print('A tarefa existe!!');
      return await bancoDeDados.update(_tablename, taskMap, where: '$_name = ?', whereArgs: [tarefa.nome]);
    } //verifica se a tarefa ja existe.
  }

  //Conversor de tarefas em MAP.

  Map<String, dynamic> toMap(Task tarefa){
    print('Convertendo uma Tarefa em Map: ');
    final Map<String, dynamic> mapaDeTarefas = Map();

    mapaDeTarefas[_name] = tarefa.nome;
    mapaDeTarefas[_dificulty] = tarefa.dificuldade;
    mapaDeTarefas[_image] = tarefa.foto;

    print('Mapa de Tarefas: $mapaDeTarefas');
    return mapaDeTarefas;
  }

  //Funçao para acessar todas as tarefas.

  Future<List<Task>> findAll() async {
    print('Acessando o FindAll: ');

    final Database bancoDeDados = await getDatabase(); //carregando o banco de dados.
    final List<Map<String,dynamic>> result = await bancoDeDados.query(_tablename); //carregando a tabela.

    print('Procurando os dados no banco de dados... Encontrado: $result');
    return toList(result); //retornando a lista de tarefas.
  }

  //Função para toList.

  List<Task> toList(List<Map<String, dynamic>> mapaDeTarefas){
    print('Convertendo to List: ');

    final List<Task> tarefas = [];
    for (Map<String, dynamic> linha in mapaDeTarefas){
      final Task tarefa = Task(linha[_name], linha[_image], linha[_dificulty]);
      tarefas.add(tarefa);
    }

    print('Lista de Tarefas: $tarefas');
    return tarefas;
  }

  //Função para acessar uma tarefa em especifico.

  Future<List<Task>> find(String nomeDaTarefa) async {
    print('Acessando find: ');

    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result = await bancoDeDados.query(_tablename, where: '$_name = ?', whereArgs: [nomeDaTarefa],);

    print('Tarefa encontrada: ${toList(result)}');
    return toList(result);
  }

  //Função para deletar uma tarefa.

  delete(String nomeDaTarefa) async {
    print('Deletando tarefa: $nomeDaTarefa');
    final Database bancoDeDados = await getDatabase();
    return bancoDeDados.delete(_tablename, where: '$_name = ?', whereArgs: [nomeDaTarefa]);
  }
}