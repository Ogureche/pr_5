import 'package:flutter/material.dart';
import 'package:pr_5/models/note.dart';


class NotePage extends StatelessWidget {
  final Note note;
  final VoidCallback onTap;
  final VoidCallback onToggleFavorite;

  const NotePage({
    Key? key,
    required this.note,
    required this.onTap,
    required this.onToggleFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFF1F2025),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(211, 225, 176, 155),
              blurRadius: 4,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (note.imagePath.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.network(
                      note.imagePath,
                      height: 170,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    note.title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white, fontSize: 14) ?? TextStyle(color: Colors.white, fontSize: 14), // Уменьшен шрифт до 14
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${note.price} ₽',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.green) ?? TextStyle(color: Colors.green),
                  ),
                ),
              ],
            ),
            Positioned(
              right: 8,
              top: 8,
              child: IconButton(
                icon: note.isFav
                    ? const Icon(Icons.favorite, color: Colors.red)
                    : const Icon(Icons.favorite_border),
                onPressed: onToggleFavorite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}