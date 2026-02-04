import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:sadid/App/AppColors.dart';
import 'package:sadid/App/assets_path.dart';
import 'package:sadid/Core/numberTranslation.dart';
import '../../calcolator/View/calculator.dart';
import '../Controller/Controller.dart';
import '../Model/savingModel.dart';
import 'history.dart';

class saving extends StatelessWidget {
  final controller = Get.put(savingController());
  saving({super.key});

  Future<double?> _showAddDialog() async {
    final c = TextEditingController();

    final result = await Get.dialog<double>(
      AlertDialog(
        backgroundColor: Colors.white,
        title: Text("Add to Overall Saving".tr),
        content: TextField(
          controller: c,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: "Enter amount".tr,
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: null),
            child: Text("Cancel".tr, style: TextStyle(color: Colors.black)),
          ),
          TextButton(
            onPressed: () {
              final amount = double.tryParse(c.text.trim());
              Get.back(result: amount);
            },
            child: Text("Add".tr, style: TextStyle(color: Colors.green)),
          ),
        ],
      ),
      barrierDismissible: false,
    );

    return result;
  }

  Future<bool> _showResetDialog() async {
    final result = await Get.dialog<bool>(
      AlertDialog(
        backgroundColor: Colors.white,
        title: Text("Remove Overall Saving".tr),
        content: Text("This will set Overall Saving to 0. Continue?".tr),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text("Cancel".tr, style: TextStyle(color: Colors.black)),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: Text("Remove".tr, style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
      barrierDismissible: false,
    );

    return result ?? false;
  }

  Widget _card({required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final widgets = [allMonthSavingsList(), AllSavingsListWidget()];

    return Scaffold(
      appBar: AppBar(
        title: Text("Savings".tr),
        titleSpacing: -10,
        actions: [
          IconButton(
            onPressed: () => controller.openAddSavingSheet(context),
            icon: Icon(
              Icons.add_circle_outline_rounded,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          Get.dialog(CalculatorDialog(), barrierDismissible: true);
        },
        child: SizedBox(
          width: 50,
          height: 50,
          child: Lottie.asset(
            assets_path.calculator,
            fit: BoxFit.contain,
            repeat: false,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // ✅ 2) Overall Saving (stored separately)
            _card(
              title: "Overall Saving".tr,
              child: StreamBuilder<double>(
                stream: controller.streamOverallSaving(),
                builder: (context, snap) {
                  final overall = snap.data ?? 0.0;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Text(numberTranslation.toBnDigits(controller.streamTotalSavingsText())),

                          Text(
                            "৳${numberTranslation.toBnDigits(overall.toStringAsFixed(1))}",
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () async {
                                final amount = await _showAddDialog();
                                if (amount == null) return;
                                if (amount <= 0) return;

                                await controller.addToOverallSaving(amount);
                              },
                              child: Text("Add".tr),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.red,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                side: const BorderSide(color: Colors.red),
                              ),
                              onPressed: () async {
                                final confirm = await _showResetDialog();
                                if (!confirm) return;

                                await controller.resetOverallSaving();
                              },
                              child: Text("Remove".tr),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Remove means Overall Saving will be set to 0.".tr,
                        style: TextStyle(color: Colors.black45, fontSize: 12),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Obx(() {
                return Row(
                  children: [
                    _tabButton(
                      label: "Overview".tr,
                      index: 0,
                      selectedIndex: controller.tabIndex.value,
                      onTap: () => controller.changeTab(0),
                    ),
                    _tabButton(
                      label: "History".tr,
                      index: 1,
                      selectedIndex: controller.tabIndex.value,
                      onTap: () => controller.changeTab(1),
                    ),
                  ],
                );
              }),
            ),
            const SizedBox(height: 10),

            Obx(() => widgets[controller.tabIndex.value]),
          ],
        ),
      ),
    );
  }
}

Widget _tabButton({
  required String label,
  required int index,
  required int selectedIndex,
  required VoidCallback onTap,
}) {
  final isSelected = selectedIndex == index;

  return Expanded(
    child: GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),
  );
}

Widget allMonthSavingsList() {
  final controller = Get.find<savingController>();

  String formatMonth(String mk) {
    final parts = mk.split('-');
    if (parts.length != 2) return mk;
    final year = int.tryParse(parts[0]) ?? 0;
    final month = int.tryParse(parts[1]) ?? 1;
    final dt = DateTime(year, month, 1);
    return DateFormat('MMM yyyy').format(dt);
  }

  Widget row(String left, String right, {Color? color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(left, style: const TextStyle(fontWeight: FontWeight.w600)),
        Text(
          numberTranslation.toBnDigits(right),
          style: TextStyle(fontWeight: FontWeight.w800, color: color),
        ),
      ],
    );
  }

  Widget buildList(List<MonthSaving> months) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: months.map((m) {
        final saving = m.saving;
        final isPositive = saving >= 0;

        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.black12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              row(
                numberTranslation.formatMonthYearBnFromString(
                  formatMonth(m.monthKey),
                ),
                "${isPositive ? '+' : ''} ${saving.toStringAsFixed(0)}৳",
                color: isPositive ? Colors.green : Colors.red,
              ),
              const SizedBox(height: 8),
              row(
                "Income".tr,
                "${numberTranslation.formatDateBnFromString(m.income.toStringAsFixed(0))}৳",
                color: Colors.green,
              ),
              const SizedBox(height: 4),
              row(
                "Expense".tr,
                "${m.expense.toStringAsFixed(0)}৳",
                color: Colors.red,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  return StreamBuilder<List<MonthSaving>>(
    stream: controller.streamAllMonthSavings(),
    builder: (context, snap) {
      // ✅ Save new data into cache (silent updates)
      if (snap.hasData) {
        controller.cachedMonths.assignAll(snap.data!);
      }

      // ✅ Use cached data when waiting (no flicker)
      final months = controller.cachedMonths;

      // ✅ Show loader only on very first load (no cache yet)
      if (snap.connectionState == ConnectionState.waiting && months.isEmpty) {
        return const Center(child: CircularProgressIndicator.adaptive());
      }

      if (snap.hasError && months.isEmpty) {
        return Center(child: Text("Error: ${snap.error}"));
      }

      if (months.isEmpty) {
        return Center(child: Text("No monthly data found".tr));
      }

      return Obx(() => buildList(controller.cachedMonths));
    },
  );
}
