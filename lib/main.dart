import 'package:flutter/material.dart';

Map<String, String> db = {'test@esih.edu': '12345678'};

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  title: 'ESIH Projet 3', // Non ki parèt sou telefòn nan
  home: SplashScreen(),
));

// ============================================================
// KLAVYE VIZYEL
// ============================================================
class VirtualKeyboard extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onDone;
  VirtualKeyboard({required this.controller, required this.onDone});

  @override
  State<VirtualKeyboard> createState() => _VKState();
}

class _VKState extends State<VirtualKeyboard> {
  bool _caps = false;
  bool _nums = false;

  final _letters = [
    ['q','w','e','r','t','y','u','i','o','p'],
    ['a','s','d','f','g','h','j','k','l'],
    ['z','x','c','v','b','n','m'],
  ];

  void _tap(String c) {
    final t = widget.controller;
    t.text += _caps ? c.toUpperCase() : c;
    t.selection = TextSelection.collapsed(offset: t.text.length);
  }

  void _backspace() {
    final t = widget.controller;
    if (t.text.isNotEmpty) {
      t.text = t.text.substring(0, t.text.length - 1);
      t.selection = TextSelection.collapsed(offset: t.text.length);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFE8E8E8),
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        _row(_nums ? ['1','2','3','4','5','6','7','8','9','0'] : ['@','.','-','_','.com','.edu']),
        ..._letters.map((r) => _row(r)),
        Padding(padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
          child: Row(children: [
            _key("⇧", () => setState(() => _caps = !_caps), flex: 1, on: _caps),
            _key("123", () => setState(() => _nums = !_nums), flex: 1, on: _nums),
            Expanded(flex: 4, child: Padding(padding: EdgeInsets.all(2),
              child: GestureDetector(onTap: () => _tap(' '),
                child: Container(height: 38, alignment: Alignment.center,
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
                  child: Text("espas"))))),
            _key("⌫", _backspace, flex: 1),
            _key("OK", widget.onDone, flex: 1, on: true),
          ])),
      ]),
    );
  }

  Widget _row(List<String> keys) => Padding(padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
    child: Row(mainAxisAlignment: MainAxisAlignment.center,
      children: keys.map((k) => _key(_caps ? k.toUpperCase() : k, () => _tap(k))).toList()));

  Widget _key(String label, VoidCallback onTap, {int flex = 1, bool on = false}) {
    return Expanded(flex: flex, child: Padding(padding: EdgeInsets.all(2),
      child: GestureDetector(onTap: onTap,
        child: Container(height: 38, alignment: Alignment.center,
          decoration: BoxDecoration(
            color: on ? Color(0xFF1B2A4A) : Colors.white,
            borderRadius: BorderRadius.circular(4)),
          child: Text(label, style: TextStyle(fontSize: 14,
              color: on ? Colors.white : Colors.black))))));
  }
}

// ============================================================
// LOGO WIDGET (reyitilizab)
// ============================================================
Widget logo({double size = 60, Color bg = Colors.white, Color fg = const Color(0xFF1B2A4A)}) {
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Container(
      width: size, height: size,
      decoration: BoxDecoration(color: bg, shape: BoxShape.circle,
        border: Border.all(color: fg, width: 2)),
      child: Center(child: Text("E", style: TextStyle(fontSize: size * 0.5,
          fontWeight: FontWeight.bold, color: fg))),
    ),
    SizedBox(height: 8),
    Text("ESIH", style: TextStyle(fontSize: size * 0.3, fontWeight: FontWeight.bold,
        color: bg == Colors.white ? fg : bg, letterSpacing: 4)),
  ]);
}

// ============================================================
// SPLASH
// ============================================================
class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashState();
}

class _SplashState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1B2A4A),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          logo(size: 100, bg: Colors.white, fg: Color(0xFF1B2A4A)),
          SizedBox(height: 12),
          Text("Projet 3", style: TextStyle(fontSize: 14, color: Colors.white54, letterSpacing: 2)),
        ]),
      ),
    );
  }
}

// ============================================================
// LOGIN
// ============================================================
class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  final _form = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _pass = TextEditingController();
  bool _hide = true;
  TextEditingController? _active;

  void _focus(TextEditingController c) => setState(() => _active = c);
  void _done() => setState(() => _active = null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Expanded(child: SingleChildScrollView(padding: EdgeInsets.all(32),
            child: Form(key: _form, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(height: 30),
              Center(child: logo(size: 60)),
              SizedBox(height: 30),
              Text("Bonjou!", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              Text("Konekte pou kontinye", style: TextStyle(color: Colors.grey)),
              SizedBox(height: 30),

              TextFormField(
                controller: _email, readOnly: true, onTap: () => _focus(_email),
                decoration: InputDecoration(hintText: "Imel"),
                validator: (v) => v != null && v.contains('@') ? null : "Imel pa bon",
              ),
              SizedBox(height: 12),

              TextFormField(
                controller: _pass, readOnly: true, onTap: () => _focus(_pass),
                obscureText: _hide,
                decoration: InputDecoration(hintText: "Modpas",
                    suffixIcon: IconButton(icon: Icon(_hide ? Icons.visibility_off : Icons.visibility, size: 20),
                        onPressed: () => setState(() => _hide = !_hide))),
                validator: (v) => v != null && v.isNotEmpty ? null : "Antre modpas ou",
              ),
              SizedBox(height: 28),

              SizedBox(width: double.infinity, height: 48,
                child: FilledButton(
                  onPressed: () {
                    _done();
                    if (!_form.currentState!.validate()) return;
                    if (db[_email.text.trim()] == _pass.text) {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage(email: _email.text.trim())));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Imel oswa modpas pa korek")));
                    }
                  },
                  child: Text("Konekte"),
                ),
              ),
              SizedBox(height: 12),

              Center(child: GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SignupPage())),
                  child: Text("Ou poko gen kont? Kreye youn", style: TextStyle(fontWeight: FontWeight.bold)))),
            ])),
          )),
          if (_active != null) VirtualKeyboard(controller: _active!, onDone: _done),
        ]),
      ),
    );
  }
}

// ============================================================
// SIGNUP
// ============================================================
class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => _SignupState();
}

class _SignupState extends State<SignupPage> {
  final _form = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _pass = TextEditingController();
  final _confirm = TextEditingController();
  bool _hide = true;
  TextEditingController? _active;

  void _focus(TextEditingController c) => setState(() => _active = c);
  void _done() => setState(() => _active = null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Expanded(child: SingleChildScrollView(padding: EdgeInsets.all(32),
            child: Form(key: _form, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(height: 20),
              GestureDetector(onTap: () => Navigator.pop(context), child: Icon(Icons.arrow_back)),
              SizedBox(height: 16),
              Center(child: logo(size: 50)),
              SizedBox(height: 20),
              Text("Kreye kont ou", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              Text("Antre enfomasyon ou", style: TextStyle(color: Colors.grey)),
              SizedBox(height: 30),

              TextFormField(
                controller: _email, readOnly: true, onTap: () => _focus(_email),
                decoration: InputDecoration(hintText: "Imel"),
                validator: (v) => v != null && v.contains('@') ? null : "Imel pa bon",
              ),
              SizedBox(height: 12),

              TextFormField(
                controller: _pass, readOnly: true, onTap: () => _focus(_pass),
                obscureText: _hide,
                decoration: InputDecoration(hintText: "Modpas (8+ karakte)",
                    suffixIcon: IconButton(icon: Icon(_hide ? Icons.visibility_off : Icons.visibility, size: 20),
                        onPressed: () => setState(() => _hide = !_hide))),
                validator: (v) => v != null && v.length >= 8 ? null : "Omwen 8 karakte",
              ),
              SizedBox(height: 12),

              TextFormField(
                controller: _confirm, readOnly: true, onTap: () => _focus(_confirm),
                obscureText: true,
                decoration: InputDecoration(hintText: "Konfime modpas"),
                validator: (v) => v == _pass.text ? null : "Modpas yo pa menm",
              ),
              SizedBox(height: 28),

              SizedBox(width: double.infinity, height: 48,
                child: FilledButton(
                  onPressed: () {
                    _done();
                    if (!_form.currentState!.validate()) return;
                    if (db.containsKey(_email.text.trim())) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Imel sa deja egziste!")));
                      return;
                    }
                    db[_email.text.trim()] = _pass.text;
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Kont kreye!")));
                    Navigator.pop(context);
                  },
                  child: Text("Kreye kont"),
                ),
              ),
              SizedBox(height: 12),

              Center(child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Text("Ou deja gen kont? Konekte", style: TextStyle(fontWeight: FontWeight.bold)))),
            ])),
          )),
          if (_active != null) VirtualKeyboard(controller: _active!, onDone: _done),
        ]),
      ),
    );
  }
}

// ============================================================
// HOME (Statik)
// ============================================================
class HomePage extends StatelessWidget {
  final String email;
  HomePage({required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(padding: EdgeInsets.all(24), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(email, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            GestureDetector(
              onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginPage())),
              child: Icon(Icons.logout, color: Colors.red)),
          ]),
          SizedBox(height: 30),
          Center(child: logo(size: 50)),
          SizedBox(height: 24),
          Text("Byenveni nan ESIH App", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text("Ou konekte avek sikse.", style: TextStyle(color: Colors.grey)),
        ])),
      ),
    );
  }
}