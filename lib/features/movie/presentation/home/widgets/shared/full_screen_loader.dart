import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  Stream<String> getLoadingMessages() {
    final messages = <String>[
      'Cargando Peliculas',
      'Comprando Palomitas zzz',
      'Cargando Populares',
      'Preparando los asientos',
    ];
    return Stream.periodic(const Duration(microseconds: 1200), (step) {
      return messages[step];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Espere'),
          const SizedBox(height: 10),
          const CircularProgressIndicator(strokeWidth: 2),
          const SizedBox(height: 10),
          StreamBuilder(stream: getLoadingMessages(), builder:(context, snapshot) {
            if (!snapshot.hasData) {
              return const Text('Cargando...');
            }else {
              return Text(snapshot.data!);
            }
          },),
        ],
      ),
    );
  }
}
