import 'package:cloud_firestore/cloud_firestore.dart';

class SavingItem {
  final String id;
  final double amount;
  final DateTime date;
  final String wallet;
  final String source;
  final String? note;

  SavingItem({
    required this.id,
    required this.amount,
    required this.date,
    required this.wallet,
    required this.source,
    this.note,
  });

  factory SavingItem.fromDoc(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();

    double parseAmount(dynamic raw) {
      if (raw is num) return raw.toDouble();
      if (raw is String) return double.tryParse(raw.replaceAll(',', '')) ?? 0.0;
      return 0.0;
    }

    DateTime parseDate(dynamic raw) {
      if (raw is Timestamp) return raw.toDate();
      if (raw is DateTime) return raw;
      return DateTime.now();
    }

    return SavingItem(
      id: doc.id,
      amount: parseAmount(data["amount"]),
      date: parseDate(data["date"]),
      wallet: (data["wallet"] ?? "").toString(),
      source: (data["source"] ?? "").toString(),
      note: (data["note"] == null || (data["note"].toString().trim().isEmpty))
          ? null
          : data["note"].toString(),
    );
  }
}
