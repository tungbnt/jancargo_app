part of networks;

typedef T GenericObject<T>(_);

enum ApiMethod {
  GET('GET'),
  POST('POST'),
  PUT('PUT'),
  PATCH('PATCH'),
  DELETE('DELETE');

  const ApiMethod(this.name);
  final String name;
  @override
  String toString() {
    return name;
  }
}
