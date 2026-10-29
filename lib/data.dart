class Category {
  final String name, hint;
  final List<List<String>> products;
  const Category(this.name, this.hint, this.products);
}

const String apiUrl = 'https://serverix.cloud/api/order';
const String appName = 'SHULTNA';

const categories = <Category>[
  Category('⭐ نجوم تلجرام', 'يوزر تلجرام (@username)',
      [['50 نجمة', '1.5\$'], ['100 نجمة', '2.9\$'], ['500 نجمة', '14\$']]),
  Category('💎 تلجرام بريميوم', 'يوزر تلجرام (@username)',
      [['3 شهور', '15\$'], ['6 شهور', '28\$'], ['12 شهر', '50\$']]),
  Category('🔫 شدات ببجي', 'Player ID', [
    ['60 UC', '1\$'],
    ['325 UC', '5\$'],
    ['660 UC', '10\$'],
    ['1800 UC', '25\$']
  ]),
  Category('🎵 عملات تيك توك', 'يوزر تيك توك',
      [['70 عملة', '1\$'], ['350 عملة', '5\$'], ['700 عملة', '10\$']]),
  Category('✨ اشتراكات Gemini', 'الإيميل', [
    ['شهر', '-'],
    ['سنة', '-']
  ]),
  Category('🧠 اشتراكات Claude', 'الإيميل', [
    ['Pro - شهر', '-']
  ]),
  Category('💬 ChatGPT', 'الإيميل', [
    ['Plus - شهر', '-']
  ]),
];
