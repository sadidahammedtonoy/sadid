import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Expense.dart';

class expense_page extends StatelessWidget {
  expense_page({super.key});
  final expenseController controller = Get.put(expenseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                final id = await controller.addExpense(
                  amount: 250,
                  categoryId: "food",
                  walletId: "cash",
                  note: "Lunch",
                );
                print("Expense added: $id");
              },
              child: Text("Add Expense"),
            ),
            ElevatedButton(
              onPressed: () async {
                await controller.updateExpense(
                  txId: "xEE4ZJCukHvxqhJIeSP5",
                  amount: 350,
                  note: "Dinner with friends",
                );
              },
              child: Text("Edit Expense"),
            ),

            ElevatedButton(
                onPressed: () async {
                  await controller.addIncome(
                    amount: 5000,
                    categoryId: "salary",
                    walletId: "cash",
                    note: "January Salary",
                    date: DateTime.now(),
                  );
                },
                child: Text("Add Income"),
            ),

            ElevatedButton(
              onPressed: () async {
                await controller.updateIncome(
                  txId: "boYaZ8oUzJv2HmRyVSsk",
                  amount: 48000,
                  categoryId: "salary",
                  walletId: "bank",
                  note: "Updated salary",
                  date: DateTime.now(),
                );
              },
                child: Text("Edit Income"),
            ),

            ElevatedButton(
              onPressed: () async {
                await controller.deleteIncome(
                  txId: "boYaZ8oUzJv2HmRyVSsk",
                );
              },
                child: Text("Delete Income"),
            ),

            ElevatedButton(
                onPressed: () async {
                  await controller.setAllTimeSaving(15000);
                },
                child: Text("Add All Time saving"),
            ),

            ElevatedButton(
                onPressed: () async {
                  await controller.setMonthlySaving(year: 2026, month: 1, amount: 250);
                },
                child: Text("Add monthly saving"),
            ),

            ElevatedButton(
                onPressed: () async {
                  final jan = await controller.getMonthlySaving(year: 2026, month: 2);
                  print("Jan 2026 saving = $jan");
                },
                child: Text("Get monthly saving.."),
            ),

            StreamBuilder<Map<String, double>>(
              stream: controller.streamMonthlySummary(year: 2026, month: 1),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                }

                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }

                final data = snapshot.data!;
                final income = data["income"] ?? 0.0;
                final expense = data["expense"] ?? 0.0;
                final saving = data["saving"] ?? 0.0;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Income: ৳${income.toStringAsFixed(2)}",
                        style: const TextStyle(fontSize: 18)),
                    const SizedBox(height: 6),
                    Text("Expense: ৳${expense.toStringAsFixed(2)}",
                        style: const TextStyle(fontSize: 18)),
                    const SizedBox(height: 6),
                    Text("Saving: ৳${saving.toStringAsFixed(2)}",
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                );
              },
            ),







            StreamBuilder<double>(
              stream: controller.streamDailyExpenseNoIndex(),
              builder: (context, snapshot) {
                final daily = snapshot.data ?? 0.0;
                return Text("Today: ৳${daily.toStringAsFixed(2)}");
              },
            ),

            StreamBuilder<double>(
              stream: controller.streamWeeklyExpenseNoIndex(),
              builder: (context, snapshot) {
                final weekly = snapshot.data ?? 0.0;
                return Text("This Week: ৳${weekly.toStringAsFixed(2)}");
              },
            ),

            StreamBuilder<double>(
              stream: controller.streamMonthlyExpenseNoIndex(),
              builder: (context, snapshot) {
                final monthly = snapshot.data ?? 0.0;
                return Text("This Month: ৳${monthly.toStringAsFixed(2)}");
              },
            ),

            Expanded(
              child: StreamBuilder<List<Map<String, dynamic>>>(
                stream: controller.streamMonthlySavingsNoIndex(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final list = snapshot.data!;
                  if (list.isEmpty) return const Center(child: Text("No savings"));

                  return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      final item = list[index];
                      return ListTile(
                        title: Text("${item['year']}-${item['month']}"),
                        trailing: Text("${item['amount']}"),
                      );
                    },
                  );
                },
              ),
            ),




            // StreamBuilder<List<Map<String, dynamic>>>(
            //   stream: controller.streamAllIncomeNoIndex(),
            //   builder: (context, snapshot) {
            //     if (!snapshot.hasData) return const CircularProgressIndicator();
            //     final list = snapshot.data!;
            //     return Expanded(
            //       child: ListView.builder(
            //         itemCount: list.length,
            //         itemBuilder: (context, i) {
            //           final item = list[i];
            //           return ListTile(
            //             title: Text("৳${item['amount']}"),
            //             subtitle: Text(item['note'] ?? ""),
            //           );
            //         },
            //       ),
            //     );
            //   },
            // ),





            // Expanded(
            //   child: StreamBuilder<List<Map<String, dynamic>>>(
            //     stream: controller.streamAllTransactions(),
            //     builder: (context, snapshot) {
            //       if (!snapshot.hasData)
            //         return const CircularProgressIndicator();
            //
            //       final list = snapshot.data!;
            //       if (list.isEmpty) return const Text("No data found");
            //
            //       return ListView.builder(
            //         itemCount: list.length,
            //         itemBuilder: (context, i) {
            //           final tx = list[i];
            //           return ListTile(
            //             title: Text("${tx['type']} - ${tx['amount']}"),
            //             subtitle: Text(
            //               "Category: ${tx['categoryId']} || Wallet Type: ${tx['walletId']}\n${tx['note'] ?? ''}",
            //               style: TextStyle(color: Colors.blue),
            //             ),
            //             // trailing: Text(tx['id']),
            //           );
            //         },
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
