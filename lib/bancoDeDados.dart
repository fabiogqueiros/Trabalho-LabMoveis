import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BancoDados {
  // atributo privado e estático do banco de dados
  static final BancoDados instancia = BancoDados._();
  static Database? banco; // variavel do banco de dados

  // construtor privado
  BancoDados._();

  // construtor que retorna a unica instancia da classe
  factory BancoDados() {
    return instancia;
  }

  // metodo get banco
  Future<Database> getBanco() async {
    if (banco != null) return banco!;
    banco = await iniciaBanco();
    return banco!;
  }

  // configura a foreign key
  Future<void> foreignKey(Database bd) async {
    await bd.execute('PRAGMA foreign_keys = ON');
  }

  // metodo que inicia o banco de dados
  Future<Database> iniciaBanco() async {
    String caminho = join(await getDatabasesPath(), 'gamesTracker.db');
    const String scriptUser =
        "CREATE TABLE user(id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR NOT NULL, email VARCHAR NOT NULL, password VARCHAR NOT NULL);";
    const String scriptGenre =
        "CREATE TABLE genre(id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR NOT NULL);";
    const String scriptGame =
        "CREATE TABLE game(id INTEGER PRIMARY KEY AUTOINCREMENT, user_id INTEGER NOT NULL, name VARCHAR NOT NULL UNIQUE, description TEXT NOT NULL, release_date VARCHAR NOT NULL, FOREIGN KEY(user_id) REFERENCES user(id));";
    const String scriptGameGenre =
        "CREATE TABLE game_genre(game_id INTEGER NOT NULL, genre_id INTEGER NOT NULL, FOREIGN KEY(game_id) REFERENCES game(id), FOREIGN KEY(genre_id) REFERENCES genre(id));";
    const String scriptReview =
        "CREATE TABLE review(id INTEGER PRIMARY KEY AUTOINCREMENT, user_id INTEGER NOT NULL, game_id INTEGER NOT NULL, score REAL NOT NULL, description TEXT, date VARCHAR NOT NULL, FOREIGN KEY(user_id) REFERENCES user(id), FOREIGN KEY(game_id) REFERENCES game(id));";

    return await openDatabase(caminho, version: 1, onConfigure: foreignKey,
        onCreate: (bd, version) async {
      await bd.execute(scriptUser);
      await bd.execute(scriptGenre);
      await bd.execute(scriptGame);
      await bd.execute(scriptGameGenre);
      await bd.execute(scriptReview);
    });
  }

  /* funções do crud */
  Future<void> insereUser(String nome, String email, String password) async {
    final bd = banco;
    Map<String, dynamic> user = {
      'name': nome,
      'email': email,
      'password': password
    };
    await bd?.insert('user', user,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> insereGenre(String nome) async {
    final bd = banco;
    Map<String, dynamic> genre = {'name': nome};
    await bd?.insert('genre', genre,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> insereGame(
      int userId, String name, String description, String release_date) async {
    final bd = banco;
    Map<String, dynamic> game = {
      'user_id': userId,
      'name': name,
      'description': description,
      'release_date': release_date
    };
    await bd?.insert('game', game,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> insereGameGenre(int gameId, int genreId) async {
    final bd = banco;
    Map<String, dynamic> gameGenre = {'game_id': gameId, 'genre_id': genreId};
    await bd?.insert('game_genre', gameGenre,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> insereReview(int userId, int gameId, double score,
      String description, String date) async {
    final bd = banco;
    Map<String, dynamic> review = {
      'user_id': userId,
      'game_id': gameId,
      'score': score,
      'description': description,
      'date': date
    };
    await bd?.insert('review', review, conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
