import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MentisApp());
}

// ==========================================
// THEME & CONSTANTS
// ==========================================
class MentisTheme {
  static const Color primaryBlue = Color(0xFF1C438A);
  static const Color accentGreen = Color(0xFF2ECC71);
  static const Color premiumGold = Color(0xFFF1C40F); // Repurposed for "Excellent" quality rewards

  // Dynamic Theme Colors based on GlobalData.isDarkTheme
  static Color get background => GlobalData.isDarkTheme.value ? const Color(0xFF0F172A) : const Color(0xFFF8F9FA);
  static Color get cardBackground => GlobalData.isDarkTheme.value ? const Color(0xFF1E293B) : Colors.white;
  static Color get textDark => GlobalData.isDarkTheme.value ? const Color(0xFFF8FAFC) : const Color(0xFF2D3142);
  static Color get textLight => GlobalData.isDarkTheme.value ? const Color(0xFF94A3B8) : const Color(0xFF9094A6);
  static Color get border => GlobalData.isDarkTheme.value ? const Color(0xFF334155) : Colors.grey.shade300;
  static Color get shadow => GlobalData.isDarkTheme.value ? Colors.black.withOpacity(0.4) : const Color(0x0D000000);

  static ThemeData get theme {
    final isDark = GlobalData.isDarkTheme.value;
    
    return ThemeData(
      brightness: isDark ? Brightness.dark : Brightness.light,
      primaryColor: primaryBlue,
      scaffoldBackgroundColor: background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryBlue,
        primary: primaryBlue,
        secondary: accentGreen,
        background: background,
        brightness: isDark ? Brightness.dark : Brightness.light,
      ),
      fontFamily: 'Inter',
      dialogBackgroundColor: cardBackground,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: isDark ? Colors.white : primaryBlue),
        titleTextStyle: TextStyle(
          color: isDark ? Colors.white : primaryBlue,
          fontSize: 24,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      cardTheme: CardThemeData(
        elevation: isDark ? 4 : 2,
        shadowColor: shadow,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        color: cardBackground,
      ),
    );
  }
}

// ==========================================
// TRANSLATION ENGINE & GLOBAL STATE
// ==========================================
class GlobalData {
  // true = English, false = Romanian
  static ValueNotifier<bool> isEnglish = ValueNotifier(false);
  // true = Dark Theme, false = Light Theme
  static ValueNotifier<bool> isDarkTheme = ValueNotifier(false);
  // 1: Excellent, 2: Good, 3: Needs Improvement
  static ValueNotifier<int> qualityScoreNotifier = ValueNotifier(1);

  static AppUser currentUser = AppUser(
    name: "",
    email: "",
    university: "",
    faculty: "",
    yearOfStudyValue: 1, 
  );

  static List<Survey> activeSurveys = [
    Survey(
      id: "s1",
      rewardTitleRo: "Cafea Medie Gratuită",
      rewardTitleEn: "Free Medium Coffee",
      rewardValueTextRo: "Valoare 18 Lei",
      rewardValueTextEn: "18 Lei Value",
      brandCategoryRo: "Cafea & Băuturi Calde",
      brandCategoryEn: "Coffee & Hot Drinks",
      estimatedMinutes: 3,
      icon: Icons.coffee,
    ),
    Survey(
      id: "s2",
      rewardTitleRo: "Voucher Livrare 30 Lei",
      rewardTitleEn: "30 Lei Delivery Voucher",
      rewardValueTextRo: "Valoare 30 Lei",
      rewardValueTextEn: "30 Lei Value",
      brandCategoryRo: "Livrare Mâncare",
      brandCategoryEn: "Food Delivery",
      estimatedMinutes: 5,
      icon: Icons.delivery_dining,
      expiryTextRo: "Expiră în 5 ore",
      expiryTextEn: "Expiring in 5 hrs",
    ),
    Survey(
      id: "s3",
      rewardTitleRo: "15% Reducere Abonament",
      rewardTitleEn: "15% Off Digital Sub",
      rewardValueTextRo: "Valoare 25 Lei",
      rewardValueTextEn: "25 Lei Value",
      brandCategoryRo: "Abonamente Digitale",
      brandCategoryEn: "Digital Subscriptions",
      estimatedMinutes: 4,
      icon: Icons.headphones,
    ),
    Survey(
      id: "s4",
      rewardTitleRo: "Voucher Tech 100 Lei",
      rewardTitleEn: "100 Lei Tech Voucher",
      rewardValueTextRo: "Valoare 100 Lei",
      rewardValueTextEn: "100 Lei Value",
      brandCategoryRo: "Accesorii Tech",
      brandCategoryEn: "Tech Accessories",
      estimatedMinutes: 8,
      requiresExcellentQuality: true,
      icon: Icons.laptop_mac,
    ),
    Survey(
      id: "s5",
      rewardTitleRo: "Bilet de 1 Zi la Festival",
      rewardTitleEn: "1-Day Festival Ticket",
      rewardValueTextRo: "Valoare 350 Lei",
      rewardValueTextEn: "350 Lei Value",
      brandCategoryRo: "Divertisment & Evenimente",
      brandCategoryEn: "Entertainment & Events",
      estimatedMinutes: 12,
      requiresExcellentQuality: true,
      icon: Icons.confirmation_number,
    ),
  ];

  static List<Reward> walletRewards = [
    Reward(
      titleRo: "Cafea Medie Gratuită - 5 to go",
      titleEn: "Free Medium Coffee - 5 to go",
      valueTextRo: "18 Lei",
      valueTextEn: "18 Lei",
      code: "MNT-COF-8921",
      isActive: true,
      expiryDateRo: "Valabil 48h",
      expiryDateEn: "Valid for 48h",
      icon: Icons.coffee,
    ),
    Reward(
      titleRo: "Reducere Cursă Bolt",
      titleEn: "Bolt Ride Discount",
      valueTextRo: "20 Lei",
      valueTextEn: "20 Lei",
      code: "MNT-RIDE-441",
      isActive: false,
      expiryDateRo: "Utilizat pe 12 Oct",
      expiryDateEn: "Used on Oct 12",
      icon: Icons.local_taxi,
    ),
  ];
}

String tr(String ro, String en) {
  return GlobalData.isEnglish.value ? en : ro;
}

// A custom InheritedNotifier to seamlessly trigger route rebuilds on toggle
// without destroying the navigation stack.
class AppStateWatcher extends InheritedNotifier<Listenable> {
  const AppStateWatcher({super.key, required super.notifier, required super.child});
  static void watch(BuildContext context) {
    context.dependOnInheritedWidgetOfExactType<AppStateWatcher>();
  }
}

// ==========================================
// DATA MODELS
// ==========================================
class AppUser {
  String name;
  String email;
  String university;
  String faculty;
  int yearOfStudyValue; 
  int completedSurveys;
  double totalEarnedLei;

  AppUser({
    required this.name,
    required this.email,
    required this.university,
    required this.faculty,
    required this.yearOfStudyValue,
    this.completedSurveys = 14,
    this.totalEarnedLei = 340.0,
  });

  String get yearOfStudyStr {
    if (yearOfStudyValue <= 4) return tr("Anul $yearOfStudyValue", "Year $yearOfStudyValue");
    if (yearOfStudyValue == 5) return tr("Master", "Master's");
    return tr("Doctorat", "PhD");
  }

  String get qualityScoreStr {
    if (GlobalData.qualityScoreNotifier.value == 1) return tr("Excelent", "Excellent");
    if (GlobalData.qualityScoreNotifier.value == 2) return tr("Bun", "Good");
    return tr("Necesită Îmbunătățiri", "Needs Improvement");
  }
}

class Survey {
  final String id;
  final String rewardTitleRo;
  final String rewardTitleEn;
  final String rewardValueTextRo;
  final String rewardValueTextEn;
  final String brandCategoryRo;
  final String brandCategoryEn;
  final int estimatedMinutes;
  final bool requiresExcellentQuality;
  final String expiryTextRo;
  final String expiryTextEn;
  final IconData icon;

  Survey({
    required this.id,
    required this.rewardTitleRo,
    required this.rewardTitleEn,
    required this.rewardValueTextRo,
    required this.rewardValueTextEn,
    required this.brandCategoryRo,
    required this.brandCategoryEn,
    required this.estimatedMinutes,
    this.requiresExcellentQuality = false,
    this.expiryTextRo = "",
    this.expiryTextEn = "",
    required this.icon,
  });

  String get rewardTitle => tr(rewardTitleRo, rewardTitleEn);
  String get rewardValueText => tr(rewardValueTextRo, rewardValueTextEn);
  String get brandCategory => tr(brandCategoryRo, brandCategoryEn);
  String get expiryText => tr(expiryTextRo, expiryTextEn);
}

class Reward {
  final String titleRo;
  final String titleEn;
  final String valueTextRo;
  final String valueTextEn;
  final String code;
  bool isActive; 
  String expiryDateRo;
  String expiryDateEn;
  final IconData icon;

  Reward({
    required this.titleRo,
    required this.titleEn,
    required this.valueTextRo,
    required this.valueTextEn,
    required this.code,
    required this.isActive,
    required this.expiryDateRo,
    required this.expiryDateEn,
    required this.icon,
  });

  String get title => tr(titleRo, titleEn);
  String get valueText => tr(valueTextRo, valueTextEn);
  String get status => isActive ? tr("Activ", "Active") : tr("Utilizat", "Used");
  String get expiryDate => tr(expiryDateRo, expiryDateEn);
}

// ==========================================
// CUSTOM MENTIS LOGO WIDGET
// ==========================================
class MentisLogoPainter extends CustomPainter {
  final Color color;

  MentisLogoPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final w = size.width;
    final h = size.height;

    // Draw the outer 'M'
    final mPath = Path()
      ..moveTo(0, h)
      ..lineTo(0, 0)
      ..lineTo(w * 0.32, 0)
      ..lineTo(w * 0.5, h * 0.35)
      ..lineTo(w * 0.68, 0)
      ..lineTo(w, 0)
      ..lineTo(w, h)
      ..close();

    // Create the keyhole shape to subtract
    final keyholePath = Path();
    keyholePath.addOval(Rect.fromCircle(center: Offset(w * 0.5, h * 0.58), radius: w * 0.16));
    
    final basePath = Path()
      ..moveTo(w * 0.35, h)
      ..lineTo(w * 0.44, h * 0.58)
      ..lineTo(w * 0.56, h * 0.58)
      ..lineTo(w * 0.65, h)
      ..close();
    
    final combinedKeyhole = Path.combine(PathOperation.union, keyholePath, basePath);
    
    // Subtract keyhole from 'M'
    final finalLogoPath = Path.combine(PathOperation.difference, mPath, combinedKeyhole);

    canvas.drawPath(finalLogoPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return color != (oldDelegate as MentisLogoPainter).color;
  }
}

class MentisLogo extends StatelessWidget {
  final double size;
  final Color color;

  const MentisLogo({super.key, required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size * 0.85),
      painter: MentisLogoPainter(color: color),
    );
  }
}

// ==========================================
// APP ENTRY & NAVIGATION
// ==========================================
class MentisApp extends StatelessWidget {
  const MentisApp({super.key});

  @override
  Widget build(BuildContext context) {
    final combinedListenable = Listenable.merge([
      GlobalData.isEnglish, 
      GlobalData.isDarkTheme, 
      GlobalData.qualityScoreNotifier
    ]);
    
    return AppStateWatcher(
      notifier: combinedListenable,
      child: ListenableBuilder(
        listenable: combinedListenable,
        builder: (context, child) {
          return MaterialApp(
            title: 'Mentis',
            theme: MentisTheme.theme,
            debugShowCheckedModeBanner: false,
            home: const InitialSplashScreen(),
          );
        },
      ),
    );
  }
}

// ==========================================
// INITIAL SPLASH SCREEN
// ==========================================
class InitialSplashScreen extends StatefulWidget {
  const InitialSplashScreen({super.key});

  @override
  State<InitialSplashScreen> createState() => _InitialSplashScreenState();
}

class _InitialSplashScreenState extends State<InitialSplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SplashLoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    AppStateWatcher.watch(context);
    return Scaffold(
      backgroundColor: MentisTheme.primaryBlue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const MentisLogo(size: 100, color: Colors.white),
            const SizedBox(height: 24),
            const Text(
              "Mentis",
              style: TextStyle(
                color: Colors.white,
                fontSize: 48,
                fontWeight: FontWeight.w800,
                letterSpacing: -1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// ==========================================
// WIDGETS: TOGGLES
// ==========================================
class LanguageToggleButton extends StatelessWidget {
  final Color? color;
  const LanguageToggleButton({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    AppStateWatcher.watch(context);
    final textColor = color ?? MentisTheme.textDark;
    final borderColor = color ?? MentisTheme.border;
    
    return IconButton(
      icon: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          GlobalData.isEnglish.value ? "RO" : "EN",
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 12),
        ),
      ),
      onPressed: () {
        GlobalData.isEnglish.value = !GlobalData.isEnglish.value;
      },
    );
  }
}

class ThemeToggleButton extends StatelessWidget {
  final Color? color;
  const ThemeToggleButton({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    AppStateWatcher.watch(context);
    final iconColor = color ?? MentisTheme.textDark;
    
    return IconButton(
      icon: Icon(
        GlobalData.isDarkTheme.value ? Icons.light_mode : Icons.dark_mode,
        color: iconColor,
      ),
      onPressed: () {
        GlobalData.isDarkTheme.value = !GlobalData.isDarkTheme.value;
      },
    );
  }
}

// ==========================================
// 1. LOGIN & VERIFICARE DOMENII
// ==========================================
class SplashLoginScreen extends StatefulWidget {
  const SplashLoginScreen({super.key});

  @override
  State<SplashLoginScreen> createState() => _SplashLoginScreenState();
}

class _SplashLoginScreenState extends State<SplashLoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = "";

  void _verifyEmail() {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });

      String email = _emailController.text.trim().toLowerCase();
      String detectedUniversity = "";

      // Domains
      final Map<String, String> universityDomains = {
        '@stud.upb.ro': 'Universitatea Națională de Știință și Tehnologie POLITEHNICA București',
        '@s.unibuc.ro': 'Universitatea din București',
        '@stud.ase.ro': 'Academia de Studii Economice',
        '@umfcd.ro': 'Universitatea de Medicină și Farmacie „Carol Davila”',
        '@usamv.ro': 'Universitatea de Științe Agronomice și Medicină Veterinară',
        '@facultate.snspa.ro': 'Școala Națională de Studii Politice și Administrative SNSPA',
        '@uauim.ro': 'Universitatea de Arhitectură și Urbanism Ion Mincu',
        '@unarte.org': 'Universitatea Națională de Arte',
        '@unmb.ro': 'Universitatea Națională de Muzică',
      };

      for (var entry in universityDomains.entries) {
        if (email.endsWith(entry.key)) {
          detectedUniversity = entry.value;
          break;
        }
      }

      if (detectedUniversity.isNotEmpty) {
        GlobalData.currentUser.email = email;
        GlobalData.currentUser.university = detectedUniversity;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const AcademicProfileScreen(),
          ),
        );
      } else {
        setState(() {
          _errorMessage = tr(
            "Domeniu neacceptat. Folosește adresa oficială (ex. @stud.upb.ro, @stud.ase.ro).",
            "Domain not accepted. Use official address (e.g. @stud.upb.ro, @stud.ase.ro).",
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    AppStateWatcher.watch(context);
    return Scaffold(
      backgroundColor: MentisTheme.primaryBlue,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ThemeToggleButton(color: Colors.white),
                  SizedBox(width: 8),
                  LanguageToggleButton(color: Colors.white),
                ],
              ),
              const Spacer(),
              const MentisLogo(size: 80, color: Colors.white),
              const SizedBox(height: 16),
              const Text(
                "Mentis",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 42,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                tr("Insight-uri verificate.\nRecompense reale.", "Verified Student Insights.\nReal Rewards."),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  height: 1.4,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: MentisTheme.cardBackground,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      tr("Verificare Universitate", "University Verification"),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: MentisTheme.textDark,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      tr(
                        "Introdu adresa de email instituțională pentru a accesa recompense exclusive.",
                        "Enter your institutional email to access exclusive rewards.",
                      ),
                      style: TextStyle(color: MentisTheme.textLight, fontSize: 14),
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: MentisTheme.textDark),
                      decoration: InputDecoration(
                        hintText: "student@stud.ase.ro",
                        hintStyle: TextStyle(color: MentisTheme.textLight),
                        filled: true,
                        fillColor: MentisTheme.background,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        errorText: _errorMessage.isEmpty ? null : _errorMessage,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _isLoading ? null : _verifyEmail,
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                            )
                          : Text(tr("Verifică și Continuă", "Verify & Continue")),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

class AcademicProfileScreen extends StatefulWidget {
  const AcademicProfileScreen({super.key});

  @override
  State<AcademicProfileScreen> createState() => _AcademicProfileScreenState();
}

class _AcademicProfileScreenState extends State<AcademicProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _facultyController = TextEditingController();
  int _selectedYearValue = 1;

  void _saveAndProceed() {
    if (_nameController.text.trim().isEmpty || _facultyController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(tr("Te rugăm să completezi toate câmpurile.", "Please fill in all fields."))),
      );
      return;
    }

    GlobalData.currentUser.name = _nameController.text.trim();
    GlobalData.currentUser.faculty = _facultyController.text.trim();
    GlobalData.currentUser.yearOfStudyValue = _selectedYearValue;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainLayout()),
    );
  }

  @override
  Widget build(BuildContext context) {
    AppStateWatcher.watch(context);
    
    Map<int, String> getYearOptions() {
      return {
        1: tr("Anul 1", "Year 1"),
        2: tr("Anul 2", "Year 2"),
        3: tr("Anul 3", "Year 3"),
        4: tr("Anul 4", "Year 4"),
        5: tr("Master", "Master's"),
        6: tr("Doctorat", "PhD"),
      };
    }
    
    final yearOptions = getYearOptions();

    return Scaffold(
      appBar: AppBar(
        title: Text(tr("Profilul Tău Academic", "Your Academic Profile")),
        actions: const [
          ThemeToggleButton(),
          LanguageToggleButton(),
          SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              tr(
                "Am detectat detaliile tale pe baza domeniului de email. Te rugăm să configurezi restul profilului tău.",
                "We detected your details based on your email domain. Please configure the rest of your profile.",
              ),
              style: TextStyle(fontSize: 16, color: MentisTheme.textLight, height: 1.5),
            ),
            const SizedBox(height: 32),
            
            _buildReadOnlyField(
              tr("Universitate", "University"), 
              GlobalData.currentUser.university, 
              Icons.account_balance
            ),
            const SizedBox(height: 16),
            
            _buildInputField(
              tr("Numele Complet", "Full Name"),
              _nameController,
              Icons.person,
              tr("ex. Popescu Ion", "e.g. John Doe"),
            ),
            const SizedBox(height: 16),
            
            _buildInputField(
              tr("Facultate", "Faculty"),
              _facultyController,
              Icons.school,
              tr("ex. CSIE", "e.g. Business Administration"),
            ),
            const SizedBox(height: 16),
            
            Text(
              tr("Anul de Studiu", "Year of Study"),
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: MentisTheme.textDark),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: MentisTheme.cardBackground,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: MentisTheme.border),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<int>(
                  isExpanded: true,
                  value: _selectedYearValue,
                  dropdownColor: MentisTheme.cardBackground,
                  icon: const Icon(Icons.arrow_drop_down, color: MentisTheme.primaryBlue),
                  onChanged: (int? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedYearValue = newValue;
                      });
                    }
                  },
                  items: yearOptions.entries.map<DropdownMenuItem<int>>((entry) {
                    return DropdownMenuItem<int>(
                      value: entry.key,
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_today, color: MentisTheme.primaryBlue, size: 20),
                          const SizedBox(width: 12),
                          Text(entry.value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: MentisTheme.textDark)),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: _saveAndProceed,
              child: Text(tr("Confirmă și Intră", "Confirm & Enter")),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReadOnlyField(String label, String value, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600, color: MentisTheme.textDark),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: MentisTheme.background,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: MentisTheme.border),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.grey, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  value,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.check_circle, color: MentisTheme.accentGreen, size: 20),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInputField(String label, TextEditingController controller, IconData icon, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600, color: MentisTheme.textDark),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          style: TextStyle(color: MentisTheme.textDark),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: MentisTheme.textLight),
            prefixIcon: Icon(icon, color: MentisTheme.primaryBlue, size: 20),
            filled: true,
            fillColor: MentisTheme.cardBackground,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: MentisTheme.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: MentisTheme.primaryBlue, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}

// ==========================================
// LAYOUT PRINCIPAL (NAVIGAȚIE JOS)
// ==========================================
class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const FeedScreen(),
    const WalletScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    AppStateWatcher.watch(context);
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => setState(() => _currentIndex = index),
        backgroundColor: MentisTheme.cardBackground,
        elevation: 10,
        indicatorColor: MentisTheme.primaryBlue.withOpacity(0.1),
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined, color: MentisTheme.textLight),
            selectedIcon: const Icon(Icons.dashboard, color: MentisTheme.primaryBlue),
            label: tr('Sondaje', 'Surveys'),
          ),
          NavigationDestination(
            icon: Icon(Icons.account_balance_wallet_outlined, color: MentisTheme.textLight),
            selectedIcon: const Icon(Icons.account_balance_wallet, color: MentisTheme.primaryBlue),
            label: tr('Portofel', 'Wallet'),
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline, color: MentisTheme.textLight),
            selectedIcon: const Icon(Icons.person, color: MentisTheme.primaryBlue),
            label: tr('Profil', 'Profile'),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 2. FEED SONDAJE (ECRAN PRINCIPAL)
// ==========================================
class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  String? _selectedCategoryKey;

  Map<String, String> get _availableCategories {
    final Map<String, String> cats = {};
    for (var s in GlobalData.activeSurveys) {
      // Key is the internal English identifier, value is the translated string
      cats[s.brandCategoryEn] = s.brandCategory;
    }
    return cats;
  }

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: MentisTheme.cardBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        final categories = _availableCategories;
        
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    tr("Filtrează după Categorie", "Filter by Category"),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: MentisTheme.textDark,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 24.0),
                  title: Text(tr("Toate categoriile", "All Categories"), style: TextStyle(color: MentisTheme.textDark, fontWeight: FontWeight.w600)),
                  trailing: _selectedCategoryKey == null ? const Icon(Icons.check, color: MentisTheme.primaryBlue) : null,
                  onTap: () {
                    setState(() => _selectedCategoryKey = null);
                    Navigator.pop(context);
                  },
                ),
                ...categories.entries.map((entry) {
                  final isSelected = _selectedCategoryKey == entry.key;
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 24.0),
                    title: Text(entry.value, style: TextStyle(color: MentisTheme.textDark)),
                    trailing: isSelected ? const Icon(Icons.check, color: MentisTheme.primaryBlue) : null,
                    onTap: () {
                      setState(() => _selectedCategoryKey = entry.key);
                      Navigator.pop(context);
                    },
                  );
                }),
              ],
            ),
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    AppStateWatcher.watch(context);
    
    // Filter the surveys
    final displayedSurveys = _selectedCategoryKey == null 
        ? GlobalData.activeSurveys 
        : GlobalData.activeSurveys.where((s) => s.brandCategoryEn == _selectedCategoryKey).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(tr("Recompense Disponibile", "Available Rewards")),
        actions: [
          IconButton(
            icon: Icon(
              Icons.filter_list, 
              color: _selectedCategoryKey != null ? MentisTheme.accentGreen : null, // Highlight if active
            ),
            onPressed: () => _showFilterSheet(context),
          )
        ],
      ),
      body: displayedSurveys.isEmpty 
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.inbox_outlined, size: 64, color: MentisTheme.border),
                const SizedBox(height: 16),
                Text(
                  tr("Niciun sondaj disponibil în această categorie.", "No surveys available in this category."),
                  style: TextStyle(color: MentisTheme.textLight, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )
        : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: displayedSurveys.length,
            itemBuilder: (context, index) {
              final survey = displayedSurveys[index];
              return _buildSurveyCard(context, survey);
            },
          ),
    );
  }

  Widget _buildSurveyCard(BuildContext context, Survey survey) {
    // Quality check lock logic
    final bool isHighValue = survey.requiresExcellentQuality;
    final bool hasExcellentScore = GlobalData.qualityScoreNotifier.value == 1;
    final bool isLocked = isHighValue && !hasExcellentScore;

    return Opacity(
      opacity: isLocked ? 0.6 : 1.0,
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        child: InkWell(
          onTap: () {
            if (isLocked) {
              _showQualityDialog(context);
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SurveyFlowScreen(survey: survey)),
              );
            }
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: MentisTheme.primaryBlue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(survey.icon, color: MentisTheme.primaryBlue, size: 32),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            survey.rewardTitle,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: MentisTheme.textDark,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            survey.rewardValueText,
                            style: const TextStyle(
                              fontSize: 14,
                              color: MentisTheme.accentGreen,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Divider(height: 1, color: MentisTheme.border),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.timer_outlined, size: 16, color: MentisTheme.textLight),
                        const SizedBox(width: 4),
                        Text(
                          "~${survey.estimatedMinutes} min",
                          style: TextStyle(color: MentisTheme.textLight, fontSize: 13),
                        ),
                      ],
                    ),
                    Text(
                      survey.brandCategory,
                      style: TextStyle(color: MentisTheme.textLight, fontSize: 13),
                    ),
                  ],
                ),
                if (survey.expiryText.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        survey.expiryText,
                        style: const TextStyle(color: Colors.orange, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
                // EXCELLENT QUALITY BADGE
                if (isHighValue) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                      color: MentisTheme.premiumGold.withOpacity(isLocked ? 0.1 : 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(isLocked ? Icons.lock_outline : Icons.verified, size: 16, color: MentisTheme.premiumGold),
                        const SizedBox(width: 8),
                        Text(
                          isLocked 
                              ? tr("Necesită scor 'Excelent'", "Requires 'Excellent' score") 
                              : tr("Deblocat: Calitate Excelentă", "Unlocked: Excellent Quality"),
                          style: const TextStyle(color: MentisTheme.premiumGold, fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showQualityDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.lock, color: MentisTheme.premiumGold),
            const SizedBox(width: 8),
            Text(tr("Recompensă Blocată", "Locked Reward"), style: TextStyle(color: MentisTheme.textDark)),
          ],
        ),
        content: Text(
          tr(
            "Această recompensă de valoare mare este disponibilă doar studenților cu un scor de calitate 'Excelent'. Răspunde cu atenție la viitoarele sondaje pentru a-ți crește scorul!",
            "This high-value reward is only available to students with an 'Excellent' quality score. Answer upcoming surveys carefully to improve your score!",
          ),
          style: TextStyle(color: MentisTheme.textDark, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(tr("Am înțeles", "Got it")),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 3. EXPERIENȚA SONDAJULUI
// ==========================================
class SurveyFlowScreen extends StatefulWidget {
  final Survey survey;

  const SurveyFlowScreen({super.key, required this.survey});

  @override
  State<SurveyFlowScreen> createState() => _SurveyFlowScreenState();
}

class _SurveyFlowScreenState extends State<SurveyFlowScreen> {
  int _currentQuestionIndex = 0;
  
  List<Map<String, dynamic>> get _questions {
    switch (widget.survey.id) {
      case "s1": // Coffee & Hot Drinks
        return [
          {
            "type": "single",
            "question": tr("Cât de des cumperi cafea pe drum spre facultate?", "How often do you buy coffee on your way to university?"),
            "options": [tr("Zilnic", "Daily"), tr("De 2-3 ori pe săptămână", "2-3 times a week"), tr("Rar", "Rarely"), tr("Niciodată", "Never")],
          },
          {
            "type": "likert",
            "question": tr("Pe o scară de la 1 la 5, cât de mult contează prețul când alegi o cafenea?", "On a scale of 1-5, how much does price matter when choosing a café?"),
          },
          {
            "type": "single",
            "question": tr("Pentru a ne asigura că ești atent, selectează a doua opțiune.", "To ensure you are paying attention, select the second option."),
            "options": [tr("Prima opțiune", "First option"), tr("A doua opțiune", "Second option"), tr("A treia opțiune", "Third option"), tr("A patra opțiune", "Fourth option")],
            "isAttentionCheck": true,
            "correctOptionIndex": 1,
          }
        ];
      case "s2": // Food Delivery
        return [
          {
            "type": "single",
            "question": tr("Care este platforma ta principală pentru comenzi de mâncare?", "What is your main platform for food delivery?"),
            "options": ["Tazz", "Glovo", "Bolt Food", tr("Altul / Niciuna", "Other / None")],
          },
          {
            "type": "likert",
            "question": tr("Cât de important este timpul de livrare (5 = foarte important)?", "How important is delivery time (5 = very important)?"),
          },
          {
            "type": "single",
            "question": tr("Pentru calibrare, te rugăm să selectezi opțiunea trei.", "For calibration, please select option three."),
            "options": ["Tazz", "Glovo", "Bolt Food", "Uber Eats"],
            "isAttentionCheck": true,
            "correctOptionIndex": 2,
          }
        ];
      case "s3": // Digital Subscriptions
        return [
          {
            "type": "single",
            "question": tr("Câte abonamente digitale plătești lunar (Spotify, Netflix, etc.)?", "How many digital subscriptions do you pay for monthly?"),
            "options": ["0", "1-2", "3-4", "5+"],
          },
          {
            "type": "likert",
            "question": tr("Pe o scară de la 1 la 5, cât de probabil este să renunți la un abonament dacă se scumpește?", "On a scale from 1 to 5, how likely are you to cancel a subscription if the price increases?"),
          },
          {
            "type": "single",
            "question": tr("Bifează ultima opțiune pentru a continua.", "Check the last option to continue."),
            "options": ["A", "B", "C", tr("Această opțiune", "This option")],
            "isAttentionCheck": true,
            "correctOptionIndex": 3,
          }
        ];
      case "s5": // Festivals (High Value)
        return [
          {
            "type": "single",
            "question": tr("Care este festivalul tău preferat din România?", "What is your favorite festival in Romania?"),
            "options": ["Untold", "Electric Castle", "Summer Well", "SAGA"],
          },
          {
            "type": "likert",
            "question": tr("Cât de probabil este să cumperi bilete early-bird anul viitor?", "How likely are you to buy early-bird tickets next year?"),
          },
          {
            "type": "single",
            "question": tr("Verificare atenție: Alege ultima opțiune.", "Attention check: Choose the last option."),
            "options": ["A", "B", "C", "D"],
            "isAttentionCheck": true,
            "correctOptionIndex": 3,
          }
        ];
      case "s4": // Tech Accessories (High Value)
      default:
        return [
          {
            "type": "single",
            "question": tr("Când plănuiești să îți schimbi laptopul sau telefonul principal?", "When do you plan to upgrade your main laptop or phone?"),
            "options": [tr("În 6 luni", "In 6 months"), tr("În 1 an", "In 1 year"), tr("Peste 2 ani", "In 2+ years"), tr("Nu știu", "I don't know")],
          },
          {
            "type": "likert",
            "question": tr("Cât de mult contează brandul când cumperi un accesoriu (căști, încărcător)?", "How much does brand matter when buying an accessory?"),
          },
          {
            "type": "single",
            "question": tr("Selectează prima opțiune pentru a finaliza.", "Select the first option to finish."),
            "options": [tr("Opțiunea Corectă", "Correct Option"), "Opțiunea 2", "Opțiunea 3", "Opțiunea 4"],
            "isAttentionCheck": true,
            "correctOptionIndex": 0,
          }
        ];
    }
  }

  String? _selectedOption;
  int? _likertScore;

  void _nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedOption = null;
        _likertScore = null;
      });
    } else {
      _finishSurvey();
    }
  }

  void _finishSurvey() {
    final newReward = Reward(
      titleRo: widget.survey.rewardTitleRo,
      titleEn: widget.survey.rewardTitleEn,
      valueTextRo: widget.survey.rewardValueTextRo,
      valueTextEn: widget.survey.rewardValueTextEn,
      code: "MNT-${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}",
      isActive: true,
      expiryDateRo: "Valabil 48h",
      expiryDateEn: "Valid for 48h",
      icon: widget.survey.icon,
    );

    setState(() {
      GlobalData.walletRewards.insert(0, newReward);
      GlobalData.currentUser.completedSurveys++;
      GlobalData.activeSurveys.removeWhere((s) => s.id == widget.survey.id);
    });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => RewardRevealScreen(reward: newReward),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    AppStateWatcher.watch(context);
    final question = _questions[_currentQuestionIndex];
    final progress = (_currentQuestionIndex + 1) / _questions.length;

    bool canProceed = false;
    if (question["type"] == "single" && _selectedOption != null) canProceed = true;
    if (question["type"] == "likert" && _likertScore != null) canProceed = true;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => _showExitWarning(context),
        ),
        title: Text(tr(
          "Întrebarea ${_currentQuestionIndex + 1} din ${_questions.length}",
          "Question ${_currentQuestionIndex + 1} of ${_questions.length}"
        )),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: MentisTheme.border,
            valueColor: const AlwaysStoppedAnimation<Color>(MentisTheme.accentGreen),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            Text(
              question["question"],
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: MentisTheme.textDark,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 40),
            if (question["type"] == "single")
              ...List.generate(question["options"].length, (index) {
                final option = question["options"][index];
                final isSelected = _selectedOption == option;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: InkWell(
                    onTap: () => setState(() => _selectedOption = option),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: isSelected 
                          ? MentisTheme.primaryBlue.withOpacity(GlobalData.isDarkTheme.value ? 0.2 : 0.05) 
                          : MentisTheme.cardBackground,
                        border: Border.all(
                          color: isSelected ? MentisTheme.primaryBlue : MentisTheme.border,
                          width: isSelected ? 2 : 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                            color: isSelected ? MentisTheme.primaryBlue : Colors.grey,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              option,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                color: isSelected ? MentisTheme.primaryBlue : MentisTheme.textDark,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            if (question["type"] == "likert")
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(5, (index) {
                  final score = index + 1;
                  final isSelected = _likertScore == score;
                  return InkWell(
                    onTap: () => setState(() => _likertScore = score),
                    child: Container(
                      width: 50,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected ? MentisTheme.primaryBlue : MentisTheme.cardBackground,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected ? MentisTheme.primaryBlue : MentisTheme.border,
                        ),
                      ),
                      child: Text(
                        score.toString(),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : MentisTheme.textDark,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            const Spacer(),
            ElevatedButton(
              onPressed: canProceed ? _nextQuestion : null,
              child: Text(_currentQuestionIndex == _questions.length - 1 
                ? tr("Trimite și Obține Recompensa", "Submit & Get Reward") 
                : tr("Următoarea", "Next")
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showExitWarning(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(tr("Părăsești sondajul?", "Leave survey?"), style: TextStyle(color: MentisTheme.textDark)),
        content: Text(
          tr(
            "Dacă ieși acum, progresul tău va fi pierdut și recompensa nu va fi emisă.",
            "If you exit now, your progress will be lost and the reward will not be issued."
          ),
          style: TextStyle(color: MentisTheme.textDark)
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(tr("Anulează", "Cancel")),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text(tr("Ieși", "Exit"), style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 4. AFIȘARE RECOMPENSĂ
// ==========================================
class RewardRevealScreen extends StatelessWidget {
  final Reward reward;

  const RewardRevealScreen({super.key, required this.reward});

  @override
  Widget build(BuildContext context) {
    AppStateWatcher.watch(context);
    return Scaffold(
      backgroundColor: MentisTheme.primaryBlue,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.celebration, color: Colors.white, size: 80),
              const SizedBox(height: 24),
              Text(
                tr("Sondaj Finalizat!", "Survey Complete!"),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                tr("Recompensa ta este gata de utilizare.", "Your reward is ready to use."),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70, fontSize: 16),
              ),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: MentisTheme.cardBackground,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 20, offset: const Offset(0, 10)),
                  ],
                ),
                child: Column(
                  children: [
                    Icon(reward.icon, size: 64, color: MentisTheme.primaryBlue),
                    const SizedBox(height: 16),
                    Text(
                      reward.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: MentisTheme.textDark),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      reward.valueText,
                      style: const TextStyle(fontSize: 16, color: MentisTheme.accentGreen, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 24),
                    
                    // QR Code Generated via Network
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white, // Always white background for reliable scanning
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Image.network(
                        'https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=${Uri.encodeComponent(reward.code)}',
                        width: 150,
                        height: 150,
                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.qr_code_2, size: 150, color: Colors.black),
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    Text(
                      tr("COD PROMO", "PROMO CODE"),
                      style: TextStyle(fontSize: 12, color: MentisTheme.textLight, letterSpacing: 1.5, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                      decoration: BoxDecoration(
                        color: MentisTheme.background,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: MentisTheme.border, style: BorderStyle.solid),
                      ),
                      child: Text(
                        reward.code,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 2, color: MentisTheme.textDark),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      reward.expiryDate,
                      style: const TextStyle(color: Colors.orange, fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: MentisTheme.primaryBlue,
                ),
                child: Text(tr("Mergi la Portofel", "Go to Wallet")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 5. PORTOFEL RECOMPENSE
// ==========================================
class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {

  void _showQrDialog(BuildContext context, String code) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: MentisTheme.cardBackground,
        title: Text(
          tr("Cod QR", "QR Code"), 
          style: TextStyle(color: MentisTheme.textDark, fontWeight: FontWeight.bold), 
          textAlign: TextAlign.center
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white, // Keep QR background white for scannability
                borderRadius: BorderRadius.circular(16),
              ),
              child: Image.network(
                'https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=${Uri.encodeComponent(code)}',
                width: 200,
                height: 200,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.qr_code_2, size: 200, color: Colors.black),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              code, 
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 2, color: MentisTheme.textDark)
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(tr("Închide", "Close")),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    AppStateWatcher.watch(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(tr("Portofelul Meu", "My Wallet")),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: GlobalData.walletRewards.length,
        itemBuilder: (context, index) {
          final reward = GlobalData.walletRewards[index];
          final isActive = reward.isActive;

          return Opacity(
            opacity: isActive ? 1.0 : 0.6,
            child: Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(reward.icon, color: isActive ? MentisTheme.primaryBlue : Colors.grey, size: 32),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                reward.title,
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: MentisTheme.textDark),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                reward.valueText,
                                style: TextStyle(
                                  color: isActive ? MentisTheme.accentGreen : Colors.grey,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: isActive ? MentisTheme.accentGreen.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            reward.status,
                            style: TextStyle(
                              color: isActive ? MentisTheme.accentGreen : Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(
                        color: MentisTheme.background,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            isActive ? reward.code : "••••-••••-••••",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1.5, color: MentisTheme.textDark),
                          ),
                          if (isActive)
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.qr_code_2, color: MentisTheme.primaryBlue),
                                  onPressed: () => _showQrDialog(context, reward.code),
                                  tooltip: tr("Arată cod QR", "Show QR Code"),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.copy, color: MentisTheme.primaryBlue),
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(tr("Cod copiat în clipboard!", "Code copied to clipboard!"))),
                                    );
                                  },
                                  tooltip: tr("Copiază", "Copy"),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          reward.expiryDate,
                          style: TextStyle(
                              color: isActive ? Colors.orange : Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        ),
                        if (isActive)
                          TextButton(
                            onPressed: () {
                              setState(() {
                                reward.isActive = false;
                                reward.expiryDateRo = "Utilizat acum";
                                reward.expiryDateEn = "Used just now";
                              });
                            },
                            child: Text(tr("Marchează ca Utilizat", "Mark as Used")),
                          )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ==========================================
// 6. PROFIL STUDENȚESC 
// ==========================================
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppStateWatcher.watch(context);
    final user = GlobalData.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(tr("Profil", "Profile")),
        actions: const [
          ThemeToggleButton(),
          LanguageToggleButton(),
          SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Avatar & Info de bază
            const CircleAvatar(
              radius: 40,
              backgroundColor: MentisTheme.primaryBlue,
              child: Icon(Icons.person, size: 40, color: Colors.white),
            ),
            const SizedBox(height: 16),
            Text(user.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: MentisTheme.textDark)),
            Text(user.email, style: TextStyle(color: MentisTheme.textLight)),
            
            const SizedBox(height: 32),

            // Statistici
            Row(
              children: [
                _buildStatCard(tr("Sondaje Completate", "Surveys Done"), user.completedSurveys.toString(), Icons.check_circle_outline),
                const SizedBox(width: 16),
                _buildStatCard(tr("Valoare Câștigată", "Value Earned"), "${user.totalEarnedLei.toStringAsFixed(0)} Lei", Icons.payments_outlined),
              ],
            ),
            
            const SizedBox(height: 24),

            // Scor de Calitate (Gamificare)
            // Wrapped in an InkWell to allow manual toggling for prototyping!
            Tooltip(
              message: tr("Apasă pentru a testa modificarea scorului", "Tap to test score change"),
              child: InkWell(
                onTap: () {
                  // Cycle through scores 1 -> 2 -> 3 -> 1
                  GlobalData.qualityScoreNotifier.value = (GlobalData.qualityScoreNotifier.value % 3) + 1;
                },
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: MentisTheme.cardBackground,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: GlobalData.qualityScoreNotifier.value == 1 
                          ? MentisTheme.accentGreen 
                          : MentisTheme.border,
                      width: GlobalData.qualityScoreNotifier.value == 1 ? 2 : 1,
                    ),
                    boxShadow: [BoxShadow(color: MentisTheme.shadow, blurRadius: 10)],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: GlobalData.qualityScoreNotifier.value == 1 
                              ? MentisTheme.accentGreen.withOpacity(0.1) 
                              : (GlobalData.qualityScoreNotifier.value == 2 ? Colors.orange.withOpacity(0.1) : Colors.red.withOpacity(0.1)),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          GlobalData.qualityScoreNotifier.value == 1 
                              ? Icons.verified_user 
                              : (GlobalData.qualityScoreNotifier.value == 2 ? Icons.thumbs_up_down : Icons.warning), 
                          color: GlobalData.qualityScoreNotifier.value == 1 
                              ? MentisTheme.accentGreen 
                              : (GlobalData.qualityScoreNotifier.value == 2 ? Colors.orange : Colors.red), 
                          size: 28
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(tr("Calitatea Răspunsurilor", "Response Quality"), style: TextStyle(fontSize: 14, color: MentisTheme.textLight)),
                            const SizedBox(height: 4),
                            Text(
                              user.qualityScoreStr,
                              style: TextStyle(
                                fontSize: 18, 
                                fontWeight: FontWeight.bold, 
                                color: GlobalData.qualityScoreNotifier.value == 1 
                                    ? MentisTheme.accentGreen 
                                    : (GlobalData.qualityScoreNotifier.value == 2 ? Colors.orange : Colors.red),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.ads_click, color: Colors.grey, size: 20), // Hint that it's clickable
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Profil Academic
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: MentisTheme.background,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(tr("Profil Academic Verificat", "Verified Academic Profile"), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: MentisTheme.textDark)),
                  const SizedBox(height: 16),
                  _buildProfileRow(tr("Universitate", "University"), user.university),
                  const SizedBox(height: 8),
                  _buildProfileRow(tr("Facultate", "Faculty"), user.faculty),
                  const SizedBox(height: 8),
                  _buildProfileRow(tr("An", "Year"), user.yearOfStudyStr),
                ],
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: MentisTheme.cardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: MentisTheme.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: MentisTheme.primaryBlue, size: 28),
            const SizedBox(height: 16),
            Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: MentisTheme.textDark)),
            const SizedBox(height: 4),
            Text(title, style: TextStyle(fontSize: 12, color: MentisTheme.textLight)),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: MentisTheme.textLight)),
          Expanded(
            child: Text(
              value, 
              textAlign: TextAlign.right,
              style: TextStyle(fontWeight: FontWeight.w600, color: MentisTheme.textDark)
            ),
          ),
        ],
      ),
    );
  }
}