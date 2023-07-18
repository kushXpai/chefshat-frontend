import 'package:flutter/cupertino.dart';
import 'package:graphql/client.dart';

// final HttpLink httpLink = HttpLink('http://192.168.43.104:8000/graphql/');
// final HttpLink httpLink = HttpLink('http://127.0.0.1:8000/graphql/');
final HttpLink httpLink = HttpLink('http://192.168.68.105:8000/graphql/');

final ValueNotifier<GraphQLClient> client = ValueNotifier(
  GraphQLClient(
    cache: GraphQLCache(),
    link: httpLink,
  ),
);
