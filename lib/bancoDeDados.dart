import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BancoDados {
  // atributo privado e estático do banco de dados
  static BancoDados instancia = BancoDados._();
  static Database? banco; // variavel do banco de dados

  // construtor privado
  BancoDados._();

  // construtor que retorna a unica instancia da classe
  factory BancoDados() {
    return instancia;
  }

  // metodo get banco
  static BancoDados getBanco() {
    if(banco == null) banco = iniciaBanco() as Database;//Erro aqui!!!!!!!!!

    if (instancia != null) return instancia;
    instancia = BancoDados();
    return instancia;
  }

  // configura a foreign key
  static Future<void> foreignKey(Database bd) async {
    await bd.execute('PRAGMA foreign_keys = ON');
  }

  // metodo que inicia o banco de dados
  static Future<Database> iniciaBanco() async {
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
  // insere
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
      int userId, String name, String description, String releaseDate) async {
    final bd = banco;
    Map<String, dynamic> game = {
      'user_id': userId,
      'name': name,
      'description': description,
      'release_date': releaseDate
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
    await bd?.insert('review', review,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // gets
  // retorna senha e usuário - login
  Future<Map<String, dynamic>?> getUserLogin(
      String name, String email, String password) async {
    final bd = banco;
    String script = 'name = ? AND email = ? AND password = ?';
    List<Map<String, dynamic>> user = await bd!
        .query('user', where: script, whereArgs: [name, email, password]);

    if (user.isNotEmpty) {
      return user.first;
    } else {
      return null;
    }
  }

  // retorna id do usuário
  Future<List<int>?> getUserId() async {
    final bd = banco;
    final results = await bd!.query('user', columns: ['id']);
    final ids = results.map((row) => row['id'] as int).toList();

    if (ids.isNotEmpty) {
      return ids;
    } else {
      return null;
    }
  }

  // retorna descrição do jogo
  Future<Map<String, dynamic>> getDescriptionGame(int id, String name) async {
    final bd = banco;
    String script = 'id = ? AND name = ?';
    List<Map<String, dynamic>> description = await bd!.query('game',
        columns: ['description'], where: script, whereArgs: [id, name]);

    return description.first;
  }

  // retorna os comentários sobre o jogo
  Future<List<Map<String, dynamic>>?> getDescriptionReview(
      int id, String name) async {
    final bd = banco;
    String script = 'id = ? AND name = ?';
    List<Map<String, dynamic>> description = await bd!.query('review',
        columns: ['description', 'score'],
        where: script,
        whereArgs: [id, name]);

    if (description.isNotEmpty) {
      return description;
    } else {
      return null;
    }
  }
}
