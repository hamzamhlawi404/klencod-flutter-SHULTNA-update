import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'data.dart';

void main() => runApp(const StoreApp());

class StoreApp extends StatelessWidget {
  const StoreApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(useMaterial3: true),
        builder: (c, child) =>
            Directionality(textDirection: TextDirection.rtl, child: child!),
        home: const HomePage(),
      );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _showProducts(BuildContext context, Category cat) {
    showModalBottomSheet(
      context: context,
      builder: (_) => ListView(
        shrinkWrap: true,
        children: [
          ListTile(title: Text(cat.name, style: const TextStyle(fontSize: 20))),
          for (final p in cat.products)
            ListTile(
              title: Text(p[0]),
              trailing: Text(p[1]),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => OrderPage(cat, p[0], p[1])));
              },
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text(appName), centerTitle: true),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            for (final c in categories)
              Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  title: Text(c.name, style: const TextStyle(fontSize: 18)),
                  trailing: const Icon(Icons.chevron_left),
                  onTap: () => _showProducts(context, c),
                ),
              ),
          ],
        ),
      );
}

class OrderPage extends StatefulWidget {
  final Category cat;
  final String product, price;
  const OrderPage(this.cat, this.product, this.price, {super.key});
  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final account = TextEditingController();
  final contact = TextEditingController();
  bool sending = false;

  Future<void> _send() async {
    if (account.text.trim().isEmpty || contact.text.trim().isEmpty) {
      _dialog('املا كل الحقول');
      return;
    }
    setState(() => sending = true);
    String msg;
    try {
      final client = HttpClient()
        ..connectionTimeout = const Duration(seconds: 15);
      final req = await client.postUrl(Uri.parse(apiUrl));
      req.headers.contentType = ContentType.json;
      req.add(utf8.encode(jsonEncode({
        'category': widget.cat.name,
        'product': widget.product,
        'price': widget.price,
        'account': account.text.trim(),
        'contact': contact.text.trim(),
      })));
      final res = await req.close().timeout(const Duration(seconds: 15));
      msg = await res.transform(utf8.decoder).join();
      client.close();
    } catch (e) {
      msg = 'تعذر الاتصال بالسيرفر: $e';
    }
    if (!mounted) return;
    setState(() => sending = false);
    _dialog(msg);
  }

  void _dialog(String m) => showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Text(m),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('تمام'))
          ],
        ),
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(widget.cat.name)),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            Text('${widget.product} - ${widget.price}',
                style: const TextStyle(fontSize: 22)),
            const SizedBox(height: 24),
            TextField(
                controller: account,
                decoration: InputDecoration(labelText: widget.cat.hint)),
            TextField(
                controller: contact,
                decoration: const InputDecoration(
                    labelText: 'واتساب أو تلجرام للتواصل')),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: sending ? null : _send,
                child: Text(sending ? 'جاري الإرسال...' : 'تأكيد الطلب'),
              ),
            ),
          ]),
        ),
      );
}