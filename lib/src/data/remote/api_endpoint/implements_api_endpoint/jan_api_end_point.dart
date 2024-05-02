part of api_endpoint;


class _JanApiEndPoint extends ApiEndpoint{
  _JanApiEndPoint({required super.environment});

  @override
  String  baseUrl(){
    switch(environment){
      case AppEnvironment.DEVELOPMENT:
        return 'https://jancargo.com';
      case AppEnvironment.PRODUCTION:
        return 'https://jancargo.com';
    }
  }

  @override
  String clientId() {
   switch(environment){
     case AppEnvironment.DEVELOPMENT:
       return 'f50128b2-95aa-4b5c-a3e7-c2d4db3eb869';
     case AppEnvironment.PRODUCTION:
     return 'eab813d7-fc12-4e80-80d6-5fd57fdddb4c';
   }
  }
}