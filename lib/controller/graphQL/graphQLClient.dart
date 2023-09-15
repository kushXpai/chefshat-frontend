import 'package:flutter/cupertino.dart';
import 'package:graphql/client.dart';

// PP
final HttpLink httpLink = HttpLink('http://192.168.0.200:8000/graphql/');
final httpLinkC = 'http://192.168.0.200:8000';
final httpLinkImage = 'http://192.168.0.200:8000/media/';

// Xiaomi 11i
// final HttpLink httpLink = HttpLink('http://192.168.78.104:8000/graphql/');
// final httpLinkC = 'http://192.168.78.104:8000';
// final httpLinkImage = 'http://192.168.78.104:8000/media/';

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
