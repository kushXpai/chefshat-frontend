import 'package:flutter/cupertino.dart';
import 'package:graphql/client.dart';

// Xiaomi 11i - Jio
// final HttpLink httpLink = HttpLink('http://192.168.143.104:8000/graphql/');
// final httpLinkC = 'http://192.168.143.104:8000';
// final httpLinkImage = 'http://192.168.143.104:8000/media/';

// Xiaomi 11i - Airtel
final HttpLink httpLink = HttpLink('http://192.168.143.104:8000/graphql/');
final httpLinkC = 'http://192.168.143.104:8000';
final httpLinkImage = 'http://192.168.143.104:8000/media/';

// Deepak - Black Airtel
// final HttpLink httpLink = HttpLink('http://192.168.1.100:8000/graphql/');
// final httpLinkC = 'http://192.168.1.100:8000';
// final httpLinkImage = 'http://192.168.1.100:8000/media/';

// Adv.Rahul Pai
// final HttpLink httpLink = HttpLink('http://192.168.1.19:8000/graphql/');
// final httpLinkC = 'http://192.168.1.19:8000';
// final httpLinkImage = 'http://192.168.1.19:8000/media/';

// PP
// final HttpLink httpLink = HttpLink('http://192.168.0.126:8000/graphql/');
// final httpLinkC = 'http://192.168.0.126:8000';
// final httpLinkImage = 'http://192.168.0.126:8000/media/';

// Rajesh
// final HttpLink httpLink = HttpLink('http://192.168.1.20:8000/graphql/');
// final httpLinkC = 'http://192.168.1.20:8000';
// final httpLinkImage = 'http://192.168.1.20:8000/media/';

// A Oppo F11 Pro
// final HttpLink httpLink = HttpLink('http://192.168.187.104:8000/graphql/');
// final httpLinkC = 'http://192.168.187.104:8000';
// final httpLinkImage = 'http://1192.168.187.104:8000/media/';

// Omkar Sir
// final HttpLink httpLink = HttpLink('http://172.20.10.2:8000/graphql/');
// final httpLinkC = 'http://172.20.10.2:8000';
// final httpLinkImage = 'http://172.20.10.2:8000/media/';

// V Poco F1 Pro
// final HttpLink httpLink = HttpLink('http://192.168.43.104:8000/graphql/');
// final httpLinkC = 'http://192.168.43.104:8000';
// final httpLinkImage = 'http://192.168.43.104:8000/media/';

final ValueNotifier<GraphQLClient> client = ValueNotifier(
  GraphQLClient(
    cache: GraphQLCache(),
    link: httpLink,
  ),
);
