import 'NotificationService.dart';

class TrackioReminderManager {
  static Future<void> scheduleDailyReminders() async {
    final daySeed = DateTime.now().day;

    await NotificationService.scheduleDailyAt(
      id: 101,
      hour: 8,
      minute: 0,
      title: TrackioMessages.morning[daySeed % TrackioMessages.morning.length]["title"]!,
      body: TrackioMessages.morning[daySeed % TrackioMessages.morning.length]["body"]!,
    );

    await NotificationService.scheduleDailyAt(
      id: 102,
      hour: 10,
      minute: 0,
      title: TrackioMessages.morning[(daySeed + 1) % TrackioMessages.morning.length]["title"]!,
      body: TrackioMessages.morning[(daySeed + 1) % TrackioMessages.morning.length]["body"]!,
    );

    await NotificationService.scheduleDailyAt(
      id: 103,
      hour: 13,
      minute: 0,
      title: TrackioMessages.afternoon[daySeed % TrackioMessages.afternoon.length]["title"]!,
      body: TrackioMessages.afternoon[daySeed % TrackioMessages.afternoon.length]["body"]!,
    );

    await NotificationService.scheduleDailyAt(
      id: 104,
      hour: 15,
      minute: 0,
      title: TrackioMessages.afternoon[(daySeed + 1) % TrackioMessages.afternoon.length]["title"]!,
      body: TrackioMessages.afternoon[(daySeed + 1) % TrackioMessages.afternoon.length]["body"]!,
    );

    await NotificationService.scheduleDailyAt(
      id: 105,
      hour: 20,
      minute: 0,
      title: TrackioMessages.night[daySeed % TrackioMessages.night.length]["title"]!,
      body: TrackioMessages.night[daySeed % TrackioMessages.night.length]["body"]!,
    );

    await NotificationService.scheduleDailyAt(
      id: 106,
      hour: 22,
      minute: 0,
      title: TrackioMessages.night[(daySeed + 1) % TrackioMessages.night.length]["title"]!,
      body: TrackioMessages.night[(daySeed + 1) % TrackioMessages.night.length]["body"]!,
    );
  }
}


class TrackioMessages {
  static final List<Map<String, String>> morning = [
    {"title":"Good Morning ☀️","body":"Start fresh today. Log your first expense in Trackio."},
    {"title":"New Day, New Control 💡","body":"Plan before you spend. Trackio keeps you mindful."},
    {"title":"Start Smart 💸","body":"Small entries today build better money habits."},
    {"title":"Fresh Start 🌅","body":"A few taps in Trackio can shape a better day."},
    {"title":"Morning Check ✨","body":"Trackio is ready. Stay aware of your spending today."},
    {"title":"Money Mindset 🧠","body":"Be intentional today. Trackio helps you stay in control."},
    {"title":"Build the Habit 🚀","body":"Consistency beats perfection. Log what you spend."},
    {"title":"Good Vibes, Better Budget 😄","body":"Trackio helps you stay calm with money today."},
    {"title":"Today’s Plan 📋","body":"A quick plan now can save stress later. Track in Trackio."},
    {"title":"Morning Boost 💪","body":"You’ve got this. Track your spending and move forward."},
    {"title":"Start With Awareness 👀","body":"Notice your spending today. Trackio keeps you grounded."},
    {"title":"Mindful Morning 🧘","body":"Pause before purchases. Trackio helps you decide better."},
    {"title":"Fresh Goals 🎯","body":"Set a small money goal today and log your steps."},
    {"title":"Morning Motivation 🌞","body":"One small entry today can change your habits."},
    {"title":"Plan Lightly ✍️","body":"You don’t need perfection—just track honestly."},
    {"title":"New Energy ⚡","body":"Use Trackio to keep your spending in check today."},
    {"title":"Today Matters 📅","body":"Today’s tracking builds tomorrow’s savings."},
    {"title":"Easy Start 😊","body":"Log as you go—Trackio keeps it simple."},
    {"title":"Stay Curious 🔍","body":"Where will your money go today? Trackio will show you."},
    {"title":"Morning Reset 🔄","body":"New day, new chances to spend wisely."},
    {"title":"Money Clarity 🌤️","body":"Clarity beats stress. Track your spending today."},
    {"title":"Tiny Steps 👣","body":"Even small entries move you forward."},
    {"title":"Intentional Start 🧭","body":"Spend with purpose. Trackio helps you notice patterns."},
    {"title":"Start Calm 😌","body":"Trackio keeps your money journey peaceful."},
    {"title":"Daily Focus 📌","body":"Focus on awareness, not perfection."},
    {"title":"Mindful Choices 🧠","body":"Your future self thanks you for tracking today."},
    {"title":"Gentle Start 🌼","body":"No pressure—just log what you spend."},
    {"title":"Budget Buddy 🤝","body":"Trackio is your daily money companion."},
    {"title":"Fresh Intent ✨","body":"Set an intention to track today."},
    {"title":"Morning Clarity 🔆","body":"Know your spending. Trackio makes it easy."},
    {"title":"Start Balanced ⚖️","body":"Balance your choices by tracking them."},
    {"title":"Awareness First 🧩","body":"Awareness leads to better money decisions."},
    {"title":"Light Start 🌈","body":"Track gently and move forward."},
    {"title":"Daily Check 📝","body":"A small log now saves confusion later."},
    {"title":"Smart Start 🧠","body":"Use Trackio to guide your spending today."},
    {"title":"Morning Intent 🌅","body":"Track one thing today. That’s progress."},
    {"title":"Keep It Simple ✨","body":"Simple tracking, better control."},
    {"title":"Fresh Focus 🎯","body":"Focus on awareness, not numbers."},
    {"title":"New Chance 🔄","body":"Every day is a chance to improve habits."},
    {"title":"Money Awareness 👁️","body":"See your spending clearly with Trackio."},
    {"title":"Gentle Goals 🌿","body":"Set gentle goals and track honestly."},
    {"title":"Start Aware 🌞","body":"Awareness today brings savings tomorrow."},
    {"title":"Morning Habit 🧠","body":"Build a habit of logging early."},
    {"title":"Easy Win ✅","body":"One entry this morning is a win."},
    {"title":"Calm Control 🧘","body":"Stay calm and track your spending."},
    {"title":"Fresh Day 🌄","body":"Trackio helps you begin with clarity."},
  ];


  static final List<Map<String, String>> afternoon = [
    {"title":"Midday Check ⏰","body":"Quick update in Trackio—know where you stand."},
    {"title":"Stay Aware 👀","body":"Small expenses add up. Track them as you go."},
    {"title":"Quick Log 📌","body":"If you spent anything, log it now."},
    {"title":"Midday Money 💰","body":"No judgment—just clarity. Track your spending."},
    {"title":"Consistency Wins 📊","body":"One small update keeps your finances healthy."},
    {"title":"Pause & Track ✋","body":"Pause for a second and log today’s spending."},
    {"title":"Midday Reminder 🌤️","body":"Take 10 seconds to update Trackio."},
    {"title":"Stay on Track 🚦","body":"A quick log keeps you aware."},
    {"title":"Check Your Path 🧭","body":"Awareness now helps you later."},
    {"title":"Small Check 🔁","body":"Little updates keep habits strong."},
    {"title":"Mindful Spend 🧠","body":"Notice where your money goes today."},
    {"title":"Quick Awareness 👁️","body":"A glance at Trackio keeps you grounded."},
    {"title":"Track Gently 🌿","body":"No pressure—just log what you spent."},
    {"title":"Midday Clarity ✨","body":"Clarity beats guessing. Track now."},
    {"title":"Keep It Going 🔄","body":"Consistency builds control."},
    {"title":"Midday Focus 🎯","body":"Focus on awareness, not perfection."},
    {"title":"Simple Update ✍️","body":"A small log now saves confusion later."},
    {"title":"Stay Mindful 😌","body":"Mindful tracking brings calm."},
    {"title":"Tiny Habit 👣","body":"Small habits build big results."},
    {"title":"Track One Thing 📌","body":"One quick entry is progress."},
    {"title":"Check-In Now ⏳","body":"A quick check-in keeps you aware."},
    {"title":"Money Pause ⏸️","body":"Pause before spending and track it."},
    {"title":"Midday Awareness 🔍","body":"Notice patterns as you log."},
    {"title":"Gentle Reminder 🌼","body":"Track honestly, move forward."},
    {"title":"Quick Review 📘","body":"See where your money went so far."},
    {"title":"Midday Balance ⚖️","body":"Balance your choices by tracking."},
    {"title":"Stay Present 🧘","body":"Stay present with your spending."},
    {"title":"Small Steps 🚶","body":"Every small step counts."},
    {"title":"Midday Checkpoint 🧩","body":"Check your progress with Trackio."},
    {"title":"Awareness Break ☕","body":"Take a moment to log your spending."},
    {"title":"Clarity Check 🔆","body":"Clear view brings calm choices."},
    {"title":"Keep Habits 📊","body":"Habits grow with small actions."},
    {"title":"Midday Reset 🔄","body":"Reset your awareness and track."},
    {"title":"Quick Look 👀","body":"Look at Trackio for clarity."},
    {"title":"Midday Nudge 👉","body":"A gentle nudge to log expenses."},
    {"title":"Stay Centered 🎯","body":"Stay centered with mindful tracking."},
    {"title":"Short Update ✍️","body":"Short update, big clarity."},
    {"title":"Midday Calm 😌","body":"Tracking brings calm control."},
    {"title":"Money Moment ⏱️","body":"Take a money moment with Trackio."},
    {"title":"Tiny Review 🔁","body":"Tiny reviews build strong habits."},
    {"title":"Check Your Flow 🌊","body":"Go with awareness, track gently."},
    {"title":"Midday Insight 💡","body":"Insights start with logging."},
    {"title":"Keep Noting 📝","body":"Keep noting your spending."},
    {"title":"Mindful Minute ⏲️","body":"One mindful minute to track."},
    {"title":"Clarity Now ✨","body":"Clarity now saves stress later."},
    {"title":"Midday Awareness 🌤️","body":"Awareness today helps tomorrow."},
    {"title":"Stay Aware 📌","body":"Awareness keeps habits healthy."},
    {"title":"Track the Moment ⏳","body":"Track this moment’s spending."},
  ];


  static final List<Map<String, String>> night = [
    {"title":"Night Review 🌙","body":"Before you sleep, review today’s spending."},
    {"title":"Wrap Up Your Day ✨","body":"Log today’s expenses and relax."},
    {"title":"Reflect & Rest 😴","body":"Tracking today helps you save tomorrow."},
    {"title":"End Strong 💪","body":"Even one entry tonight is progress."},
    {"title":"Good Night 🌙","body":"No matter how today went, logging is a win."},
    {"title":"Small Steps Matter 👣","body":"Trackio helps you improve daily."},
    {"title":"Peace of Mind 🧘","body":"Review your day and sleep easy."},
    {"title":"Daily Wrap 📘","body":"A quick review leads to better choices tomorrow."},
    {"title":"You Did Your Best 👏","body":"Tracking today is already progress."},
    {"title":"Tomorrow Starts Now 🌟","body":"Review today’s spending, plan tomorrow."},
    {"title":"Gentle Close 🌿","body":"Close your day with awareness."},
    {"title":"Night Check ⏰","body":"A quick check brings clarity."},
    {"title":"Calm Finish 😌","body":"Finish your day calmly by tracking."},
    {"title":"Daily Reflection 🔍","body":"Reflect on where your money went."},
    {"title":"Small Review ✍️","body":"One small review tonight helps tomorrow."},
    {"title":"End with Clarity 🔆","body":"Clarity brings peaceful rest."},
    {"title":"Rest Easy 🌙","body":"Track today and rest easy."},
    {"title":"Nightly Habit 🧠","body":"Build a nightly habit of tracking."},
    {"title":"Soft Reminder 🌼","body":"No pressure—just log what you spent."},
    {"title":"Today Counts 📅","body":"Today’s tracking shapes tomorrow."},
    {"title":"Evening Insight 💡","body":"Insights come from daily reviews."},
    {"title":"Wind Down 🌌","body":"Wind down by reviewing Trackio."},
    {"title":"Nightly Checkpoint 🧩","body":"Check your progress before sleep."},
    {"title":"Gentle Review 📝","body":"A gentle review keeps habits strong."},
    {"title":"End Balanced ⚖️","body":"Balance your day with reflection."},
    {"title":"Peaceful Close 🕊️","body":"Tracking brings peace of mind."},
    {"title":"Night Awareness 👁️","body":"Awareness today saves stress tomorrow."},
    {"title":"Quiet Moment 🤍","body":"Take a quiet moment to log today."},
    {"title":"Daily Clarity 🌠","body":"Clarity grows with daily tracking."},
    {"title":"Restful End 🌙","body":"End your day with calm awareness."},
    {"title":"One Last Look 👀","body":"One last look at Trackio before bed."},
    {"title":"Night Reset 🔄","body":"Reset your mindset with reflection."},
    {"title":"Daily Closure 📌","body":"Close your day with clarity."},
    {"title":"Soft Finish 🌙","body":"Softly finish your day with a log."},
    {"title":"Mindful Night 🧘","body":"Mindful review leads to better habits."},
    {"title":"End with Care 💛","body":"Care for your future self—review today."},
    {"title":"Nightly Calm 🌌","body":"Calm your mind by tracking today."},
    {"title":"Daily Win ✅","body":"Tracking today is a daily win."},
    {"title":"Quiet Review 🤫","body":"A quiet review helps you grow."},
    {"title":"Reflect Gently 🌿","body":"Reflect gently on today’s spending."},
    {"title":"Night Insight 🔎","body":"Insights start with nightly reviews."},
    {"title":"Rest & Review 😴","body":"Review today, rest well tonight."},
    {"title":"End Aware 👁️","body":"End your day with awareness."},
    {"title":"Daily Peace 🕊️","body":"Tracking brings daily peace."},
    {"title":"Close Strong 💪","body":"Close your day strong with reflection."},
    {"title":"Night Habit 🔁","body":"Build a nightly tracking habit."},
    {"title":"Tomorrow Ready 🚀","body":"Review today and get ready for tomorrow."},
  ];


  Map<String, String> pickForTime(DateTime now) {
    final daySeed = now.day;

    if (now.hour < 12) {
      return TrackioMessages.morning[daySeed % TrackioMessages.morning.length];
    } else if (now.hour < 18) {
      return TrackioMessages.afternoon[daySeed % TrackioMessages.afternoon.length];
    } else {
      return TrackioMessages.night[daySeed % TrackioMessages.night.length];
    }
  }
}
