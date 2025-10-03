import 'package:flutter/material.dart';
import '../models/receta.dart';

class RecetaCard extends StatelessWidget {
  final Receta receta;
  final VoidCallback onDelete;

  const RecetaCard({super.key, required this.receta, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ExpansionTile(
        title: Text(receta.nombre),
        subtitle: Text(receta.descripcion),
        children: [
          ...receta.pasos.asMap().entries.map((entry) {
            int idx = entry.key;
            String paso = entry.value;
            return ListTile(
              leading: CircleAvatar(child: Text('${idx + 1}')),
              title: Text(paso),
            );
          }),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: onDelete,
              ),
            ],
          )
        ],
      ),
    );
  }
}
