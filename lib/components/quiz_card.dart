import 'package:flutter/material.dart';

class QuizCard extends StatefulWidget {
  QuizCard({
    super.key,
    this.isVisible = true,
    required this.title,
    required this.description,
    required this.author,
    required this.questionCount,
    required this.createdAt,
    required this.isPrivate,
  });
  final String title;
  final String description;
  final String author;
  final int questionCount;
  final String createdAt;
  final bool isPrivate;

  bool isVisible = true;

  @override
  State<QuizCard> createState() => _QuizCardState();
}

class _QuizCardState extends State<QuizCard> {
  void hideCard() {
    setState(() {
      widget.isVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.isVisible,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  _privateTag,
                ],
              ),

              const SizedBox(height: 6),
              Text(widget.description, style: TextStyle(color: Colors.black54)),

              const SizedBox(height: 10),
              Text(
                "👤 ${widget.author}",
                style: TextStyle(fontSize: 13, color: Colors.black87),
              ),

              const SizedBox(height: 4),
              Text(
                "${widget.questionCount} questions",
                style: TextStyle(fontSize: 13, color: Colors.black87),
              ),

              const SizedBox(height: 4),
              Text(
                "Created about 2 hours ago",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),

              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () {
                      hideCard();
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit_outlined),
                    onPressed: () {},
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.play_arrow, color: Colors.white),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          "/quiz/play",
                          arguments: {
                            'title': widget.title,
                            'description': widget.description,
                            'author': widget.author,
                            'questionCount': widget.questionCount,
                            'createdAt': widget.createdAt,
                            'isPrivate': widget.isPrivate,
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container get _privateTag {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: !widget.isPrivate ? Colors.green.shade100 : Colors.red.shade100,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        widget.isPrivate ? "Private" : "Public",
        style: TextStyle(
          color: widget.isPrivate ? Colors.red : Colors.green,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
