abstract class Sql {
  static const favoriteQuery = '''
          CREATE TABLE favorites(
            id TEXT PRIMARY KEY,
            name TEXT,
            description TEXT,
            imageUrl TEXT
          )
        ''';
  static const authQuery = '''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT,
            password TEXT
          )
        ''';
}
