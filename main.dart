import 'package:flutter/material.dart';

void main() {
  runApp(const NetMesaiApp());
}

class NetMesaiApp extends StatelessWidget {
  const NetMesaiApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NetMesai',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: const Color(0xFFF7F8FA),
        fontFamily: 'sans-serif',
      ),
      home: const LoginScreen(),
    );
  }
}

// Global Veri Tabanı Simülasyonu
class AppDatabase {
  static List<Map<String, dynamic>> users = [
    {"name": "Ahmet Yılmaz", "role": "Personel", "phone": "5551112233", "status": "Giriş Yapmadı"},
    {"name": "Mehmet Demir", "role": "Yönetici", "phone": "5552223344", "status": "Çalışıyor"},
  ];
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool _rememberMe = false;

  void _login() {
    String input = _idController.text.trim();
    String pass = _passController.text.trim();

    if (input == "admin" && pass == "1234") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardScreen(userRole: "Patron", userName: "Sistem Patronu")),
      );
    } else if (input.isNotEmpty && pass.isNotEmpty) {
      // Normal personel/yönetici simülasyonu
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardScreen(userRole: "Personel", userName: "Ahmet Yılmaz")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Lütfen alanları doldurun! (Patron için: admin / 1234)")),
      );
    }
  }

  void _showBossLoginDialog() {
    final TextEditingController bossUserCtrl = TextEditingController();
    final TextEditingController bossPassCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Patron / Admin Girişi"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: bossUserCtrl, decoration: const InputDecoration(labelText: "Kullanıcı Adı (admin)")),
            TextField(controller: bossPassCtrl, decoration: const InputDecoration(labelText: "Şifre (1234)"), obscureText: true),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("İptal")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF163C38)),
            onPressed: () {
              if (bossUserCtrl.text == "admin" && bossPassCtrl.text == "1234") {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const DashboardScreen(userRole: "Patron", userName: "Şirket Patronu")),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Hatalı Bilgi!")));
              }
            },
            child: const Text("Giriş Yap", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo ve Desen Alanı
              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF163C38).withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.all_inclusive, color: Color(0xFF163C38), size: 36),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          "NetMesai",
                          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF163C38)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text("Yeni Nesil İK ve PDKS Çözümü", style: TextStyle(color: Colors.grey, fontSize: 13)),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("Giriş Yap", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _idController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email_outlined),
                  labelText: "E-Posta veya Telefon",
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passController,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: const Icon(Icons.visibility_off),
                  labelText: "Parola",
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Switch(value: _rememberMe, onChanged: (val) => setState(() => _rememberMe = val)),
                      const Text("Beni Hatırla", style: TextStyle(fontSize: 14)),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text("Şifre Al / Yenile", style: TextStyle(color: Color(0xFF163C38))),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF222222),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: _login,
                  child: const Text("Giriş Yap", style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF163C38)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: _showBossLoginDialog,
                  child: const Text("Patron Girişi", style: TextStyle(color: Color(0xFF163C38), fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  final String userRole; // "Patron", "Yönetici", "Personel"
  final String userName;

  const DashboardScreen({Key? key, required this.userRole, required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF163C38),
        title: Text("NetMesai ($userRole Paneli)"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFFE0F2F1), Color(0xFFB2DFDB)]),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const CircleAvatar(backgroundColor: Color(0xFF163C38), child: Icon(Icons.person, color: Colors.white)),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hoşgeldin, $userName", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text("Yetki Seviyesi: $userRole", style: TextStyle(color: Colors.grey.shade700)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  DashboardCard(
                    title: "PDKS Giriş/Çıkış",
                    icon: Icons.qr_code_scanner,
                    color: Colors.orange.shade100,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const PdksScreen()));
                    },
                  ),
                  DashboardCard(
                    title: "Vardiya Programım",
                    icon: Icons.calendar_today,
                    color: Colors.blue.shade100,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Vardiya ekranı açılıyor...")));
                    },
                  ),
                  if (userRole == "Patron" || userRole == "Yönetici")
                    DashboardCard(
                      title: "Personel Yönetimi",
                      icon: Icons.group_add,
                      color: Colors.green.shade100,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const PersonnelManagementScreen()));
                      },
                    ),
                  DashboardCard(
                    title: "İzin Talebi",
                    icon: Icons.description,
                    color: Colors.purple.shade100,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const DashboardCard({Key? key, required this.title, required this.icon, required this.color, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: const Color(0xFF163C38)),
            const SizedBox(height: 12),
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF163C38))),
          ],
        ),
      ),
    );
  }
}

// PDKS Ekranı ("123" Kodu Doğrulama)
class PdksScreen extends StatefulWidget {
  const PdksScreen({Key? key}) : super(key: key);

  @override
  State<PdksScreen> createState() => _PdksScreenState();
}

class _PdksScreenState extends State<PdksScreen> {
  final TextEditingController _qrCodeController = TextEditingController();
  String _message = "Lütfen QR kodunu okutun veya '123' girin.";

  void _verifyCode() {
    if (_qrCodeController.text.trim() == "123") {
      setState(() {
        _message = "✅ Başarılı! Giriş/Çıkış onaylandı.";
      });
    } else {
      setState(() {
        _message = "❌ Geçersiz Kod! Doğru kod: 123";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color(0xFF163C38), title: const Text("PDKS QR Okuyucu")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF163C38), width: 3),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Icon(Icons.qr_code_2, size: 100, color: Color(0xFF163C38)),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _qrCodeController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: "QR Kodu Girin (Örn: 123)",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF163C38), minimumSize: const Size(double.infinity, 50)),
              onPressed: _verifyCode,
              child: const Text("Kodu Doğrula", style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 20),
            Text(_message, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

// Personel ve Yetki Yönetim Ekranı (Patron ve Yönetici İçin)
class PersonnelManagementScreen extends StatefulWidget {
  const PersonnelManagementScreen({Key? key}) : super(key: key);

  @override
  State<PersonnelManagementScreen> createState() => _PersonnelManagementScreenState();
}

class _PersonnelManagementScreenState extends State<PersonnelManagementScreen> {
  void _addPersonnelDialog() {
    final TextEditingController nameCtrl = TextEditingController();
    String selectedRole = "Personel";

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text("Yeni Personel Ekle"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: "Personel Adı Soyadı")),
              const SizedBox(height: 10),
              DropdownButton<String>(
                value: selectedRole,
                isExpanded: true,
                items: ["Personel", "Yönetici"].map((role) {
                  return DropdownMenuItem(value: role, child: Text(role));
                }).toList,
                onChanged: (val) {
                  setDialogState(() => selectedRole = val!);
                },
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("İptal")),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF163C38)),
              onPressed: () {
                if (nameCtrl.text.isNotEmpty) {
                  setState(() {
                    AppDatabase.users.add({"name": nameCtrl.text, "role": selectedRole, "phone": "5550000000", "status": "Aktif Değil"});
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text("Ekle", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color(0xFF163C38), title: const Text("Personel ve Yetki Yönetimi")),
      body: ListView.builder(
        itemCount: AppDatabase.users.length,
        itemBuilder: (context, index) {
          var user = AppDatabase.users[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: CircleAvatar(child: Text(user["name"][0])),
              title: Text(user["name"], style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("Rol: ${user["role"]} | Durum: ${user["status"]}"),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  setState(() {
                    AppDatabase.users.removeAt(index);
                  });
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF163C38),
        onPressed: _addPersonnelDialog,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
