import 'package:flutter/material.dart';
import 'package:flutter_contact_bloc/home/widget/ButtonCard.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed('/bloc/bloc_example');
                      },
                      child: ButtonCard(name: 'Bloc Example'),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed('/bloc/freezed_example');
                      },
                      child: ButtonCard(
                        name: 'Example Freezed',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed('/contact/list');
                      },
                      child: ButtonCard(
                        name: 'Contact List',
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed('/contact/cubit');
                      },
                      child: ButtonCard(
                        name: 'Contact Cubit',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
