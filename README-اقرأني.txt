طريقة التركيب:
1) فك الضغط داخل مجلد مشروعك الرئيسي (بجانب pubspec.yaml) واختر استبدال الملفات الموجودة.
2) الملفات المضمنة:
   - lib/main.dart و lib/data.dart  (الكود، لا يحتاج أي مكتبة إضافية)
   - android/app/src/main/AndroidManifest.xml  (صلاحية الإنترنت + اسم التطبيق SHULTNA)
   - android/app/src/main/res/mipmap-*/ic_launcher.png  (الأيقونة)
3) عدّل رابط السيرفر في lib/data.dart (apiUrl) والأسعار في قائمة categories.
4) commit ثم push وانتظر البناء.
