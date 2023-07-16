import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'controller/graphQL/graphQLClient.dart';

class test extends StatefulWidget {
  const test({Key? key}) : super(key: key);

  @override
  State<test> createState() => _testState();

}

class _testState extends State<test> {

  final String getUsersQuery = r'''
    query {
      displayUser {
        id
        username
        mobileNumber
        emailAddress
        dateOfBirth
        address
        profilePhoto
      }
    }
  ''';

  @override
  Widget build(BuildContext context) {

    // final HttpLink httpLink = HttpLink(
    //     'http://192.168.107.104:8000/graphql/'); // Replace with your GraphQL API URL
    //
    // final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
    //   GraphQLClient(
    //     cache: GraphQLCache(),
    //     link: httpLink,
    //   ),
    // );

    return GraphQLProvider(
      client: client,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('User List'),
        ),
        body: Query(
          options: QueryOptions(
            document: gql(getUsersQuery),
            variables: {'sex': 'MALE'}, // or 'FEMALE'
          ),
          builder: (QueryResult result, {fetchMore, refetch}) {
            if (result.hasException) {
              print(result.exception.toString());
              return Center(
                child: Text(
                    'Error fetching users: ${result.exception.toString()}'),
              );
            }

            if (result.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final List<dynamic> users = result.data?['displayUser'] ?? [];

            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  title: Text('ID: ${user['id']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Username: ${user['username']}'),
                      // Text('Sex: ${user['sex']}'),
                      Text('Mobile Number: ${user['mobileNumber']}'),
                      Text('Email Address: ${user['emailAddress']}'),
                      Text('Date of Birth: ${user['dateOfBirth']}'),
                      Text('Address: ${user['address']}'),
                      Text('Profile Photo: ${user['profilePhoto']}'),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}