import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class expenseController extends GetxController {


  Future<User> ensureLoggedIn() async {
    final auth = FirebaseAuth.instance;

    if (auth.currentUser != null) return auth.currentUser!;

    final cred = await auth.signInAnonymously();
    return cred.user!;
  }




  Future<String> addExpense({
    required double amount,
    required String categoryId,
    required String walletId,
    String? note,
    DateTime? date,
  }) async {
    // await ensureLoggedIn();
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception("User not logged in");
    }

    final now = DateTime.now();
    final txRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('transactions')
        .doc(); // auto id

    await txRef.set({
      "type": "expense",
      "amount": amount,
      "categoryId": categoryId,
      "walletId": walletId,
      "note": note ?? "",
      "date": Timestamp.fromDate(date ?? now),
      "createdAt": FieldValue.serverTimestamp(),
      "updatedAt": FieldValue.serverTimestamp(),
    });

    return txRef.id;
  }

  Future<void> updateExpense({
    required String txId,          // document id
    double? amount,
    String? categoryId,
    String? walletId,
    String? note,
    DateTime? date,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception("User not logged in");
    }

    final Map<String, dynamic> updateData = {
      "updatedAt": FieldValue.serverTimestamp(),
    };

    if (amount != null) updateData["amount"] = amount;
    if (categoryId != null) updateData["categoryId"] = categoryId;
    if (walletId != null) updateData["walletId"] = walletId;
    if (note != null) updateData["note"] = note;
    if (date != null) updateData["date"] = Timestamp.fromDate(date);

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('transactions')
        .doc(txId)
        .update(updateData);
  }

  Future<void> deleteExpense({
    required String txId,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception("User not logged in");
    }

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('transactions')
        .doc(txId)
        .delete();
  }

  // ✅ READ ALL (REALTIME STREAM)
  Stream<List<Map<String, dynamic>>> streamAllTransactions() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception("User not logged in");

    return FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('transactions')
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => {
        "id": doc.id,
        ...doc.data(),
      }).toList();
    });
  }

  Stream<double> streamDailyExpenseNoIndex() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return const Stream<double>.empty();

    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day); // today 00:00
    final end = start.add(const Duration(days: 1));       // tomorrow 00:00

    return FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('transactions')
        .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(start))
        .where('date', isLessThan: Timestamp.fromDate(end))
        .snapshots()
        .map((snap) {
      double total = 0;

      for (final doc in snap.docs) {
        final data = doc.data();
        if ((data['type'] ?? '') == 'expense') {
          total += (data['amount'] as num).toDouble();
        }
      }

      return total;
    });
  }


  Stream<double> streamWeeklyExpenseNoIndex() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return const Stream<double>.empty();

    final now = DateTime.now();

    // Monday as start of week
    final startRaw = now.subtract(Duration(days: now.weekday - 1));
    final start = DateTime(startRaw.year, startRaw.month, startRaw.day); // Monday 00:00
    final end = start.add(const Duration(days: 7)); // next Monday 00:00

    return FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('transactions')
        .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(start))
        .where('date', isLessThan: Timestamp.fromDate(end))
        .snapshots()
        .map((snap) {
      double total = 0;

      for (final doc in snap.docs) {
        final data = doc.data();
        if ((data['type'] ?? '') == 'expense') {
          total += (data['amount'] as num).toDouble();
        }
      }

      return total;
    });
  }


  Stream<double> streamMonthlyExpenseNoIndex() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return const Stream<double>.empty();

    final now = DateTime.now();
    final start = DateTime(now.year, now.month, 1);
    final end = DateTime(now.year, now.month + 1, 1);

    return FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('transactions')
        .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(start))
        .where('date', isLessThan: Timestamp.fromDate(end))
        .snapshots()
        .map((snap) {
      double total = 0;

      for (final doc in snap.docs) {
        final data = doc.data();
        final type = (data['type'] ?? '').toString();
        if (type == 'expense') {
          total += (data['amount'] as num).toDouble();
        }
      }

      return total;
    });
  }


  Future<String> addIncome({
    required double amount,
    required String categoryId,
    required String walletId,
    String? note,
    DateTime? date,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception("User not logged in");

    final now = DateTime.now();
    final ref = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('transactions')
        .doc();

    await ref.set({
      "type": "income",
      "amount": amount,
      "categoryId": categoryId,
      "walletId": walletId,
      "note": note ?? "",
      "date": Timestamp.fromDate(date ?? now),
      "createdAt": FieldValue.serverTimestamp(),
      "updatedAt": FieldValue.serverTimestamp(),
    });

    return ref.id;
  }

  Future<void> updateIncome({
    required String txId,
    double? amount,
    String? categoryId,
    String? walletId,
    String? note,
    DateTime? date,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception("User not logged in");

    final updateData = <String, dynamic>{
      "updatedAt": FieldValue.serverTimestamp(),
    };

    if (amount != null) updateData["amount"] = amount;
    if (categoryId != null) updateData["categoryId"] = categoryId;
    if (walletId != null) updateData["walletId"] = walletId;
    if (note != null) updateData["note"] = note;
    if (date != null) updateData["date"] = Timestamp.fromDate(date);

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('transactions')
        .doc(txId)
        .update(updateData);
  }


  Future<void> deleteIncome({required String txId}) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception("User not logged in");

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('transactions')
        .doc(txId)
        .delete();
  }

  Stream<List<Map<String, dynamic>>> streamAllIncomeNoIndex() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return const Stream.empty();

    return FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('transactions')
        .snapshots()
        .map((snap) {
      return snap.docs
          .map((doc) => {"id": doc.id, ...doc.data()})
          .where((e) => (e["type"] ?? "") == "income")
          .toList();
    });
  }

  Stream<Map<String, double>> streamMonthlySummary({
    required int year,
    required int month,
  }) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return const Stream.empty();

    final start = DateTime(year, month, 1);
    final end = DateTime(year, month + 1, 1);

    return FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('transactions')
        .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(start))
        .where('date', isLessThan: Timestamp.fromDate(end))
        .snapshots()
        .map((snap) {
      double totalIncome = 0;
      double totalExpense = 0;

      for (final doc in snap.docs) {
        final data = doc.data();
        final type = (data['type'] ?? '').toString();
        final amount = (data['amount'] as num).toDouble();

        if (type == 'income') {
          totalIncome += amount;
        } else if (type == 'expense') {
          totalExpense += amount;
        }
      }

      return {
        "income": totalIncome,
        "expense": totalExpense,
        "saving": totalIncome - totalExpense,
      };
    });
  }


  Future<void> setAllTimeSaving(double amount) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception("User not logged in");

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('meta')
        .doc('saving')
        .set({
      "allTimeSaving": amount,
      "updatedAt": FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Stream<double> streamAllTimeSaving() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return const Stream.empty();

    return FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('meta')
        .doc('saving')
        .snapshots()
        .map((doc) {
      final data = doc.data();
      if (data == null) return 0.0;
      return (data["allTimeSaving"] as num?)?.toDouble() ?? 0.0;
    });
  }

  Future<void> setMonthlySaving({
    required int year,
    required int month, // 1-12
    required double amount,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception("User not logged in");

    final id = "${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}";

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('monthly_savings')
        .doc(id)
        .set({
      "year": year,
      "month": month,
      "amount": amount,
      "updatedAt": FieldValue.serverTimestamp(),
    }, SetOptions(merge: true)); // merge = update if exists
  }

  Stream<List<Map<String, dynamic>>> streamMonthlySavingsNoIndex() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return const Stream<List<Map<String, dynamic>>>.empty();

    int toInt(dynamic v) {
      if (v == null) return 0;
      if (v is int) return v;
      if (v is num) return v.toInt();
      return int.tryParse(v.toString()) ?? 0;
    }

    double toDouble(dynamic v) {
      if (v == null) return 0.0;
      if (v is double) return v;
      if (v is num) return v.toDouble();
      return double.tryParse(v.toString()) ?? 0.0;
    }

    return FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('monthly_savings')
        .snapshots()
        .map((snap) {
      final list = snap.docs.map((d) {
        final data = d.data();

        return {
          "id": d.id,
          "year": toInt(data["year"]),
          "month": toInt(data["month"]),
          "amount": toDouble(data["amount"]), // ✅ correct conversion
        };
      }).toList();

      // newest first
      list.sort((a, b) {
        final ay = a["year"] as int;
        final am = a["month"] as int;
        final by = b["year"] as int;
        final bm = b["month"] as int;
        if (ay != by) return by.compareTo(ay);
        return bm.compareTo(am);
      });

      return list;
    });
  }

  Future<double> getMonthlySaving({required int year, required int month}) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception("User not logged in");

    final id =
        "${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}";

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('monthly_savings')
        .doc(id)
        .get();

    final data = doc.data();
    if (data == null) return 0.0;

    final v = data["amount"];
    if (v is num) return v.toDouble();
    return double.tryParse(v?.toString() ?? "") ?? 0.0;
  }














}