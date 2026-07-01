# 🛒 دليل نشر المتجر — خطوة بخطوة

عندك 5 ملفات ف فولدر `store-site`:

```
store-site/
├── index.html          ← صفحة الزبون
├── admin.html          ← لوحة التحكم
├── config.js           ← المفاتيح (غادي تعمّرها)
├── database-setup.sql  ← كود قاعدة البيانات
└── GUIDE.md            ← هاد الدليل
```

الكل **مجاني**. الوقت اللازم: ~20 دقيقة. اتبع بالترتيب.

---

## 1️⃣ صاوب قاعدة البيانات (Supabase)

1. سير لـ **https://supabase.com** → **Start your project** → دخل بـ GitHub أو Email.
2. **New project** → اختار اسم، وحط **Database Password** (سجّلها عندك)، اختار région **West EU (Ireland)** قريبة للمغرب → **Create**.
3. تسنّى ~2 دقائق حتى يوجد المشروع.

### أ) أنشئ الجداول
- ف القائمة اليسرى: **SQL Editor** → **New query**.
- حلّ الملف `database-setup.sql`، نسخ **كلشي** اللي فيه، ألصقو، ثم **Run** ▶.
- خاص يطلع لك **Success**. (هاد الخطوة كتصاوب جداول المنتجات والطلبات + مكان الصور.)

### ب) جيب المفاتيح
- **Project Settings** (الترس ⚙️ تحت) → **API**.
- نسخ:
  - **Project URL** (مثال: `https://abcdxyz.supabase.co`)
  - **anon public** key (مفتاح طويل).

### ت) أنشئ حساب الـ admin ديالك
- **Authentication** → **Users** → **Add user** → **Create new user**.
- حط **Email** و **Password** ديالك (هادو غادي تدخل بيهم لـ admin) → **Create**.
- ⚠️ إلا كان فيه خيار "Auto Confirm User" خليه مفعّل، أو من **Authentication → Providers → Email** طفّي "Confirm email" باش تدخل دغيا.

---

## 2️⃣ عمّر ملف `config.js`

حلّ `config.js` بأي محرّر (Notepad / VS Code)، وبدّل غير هاد جوج سطور:

```js
SUPABASE_URL: "https://abcdxyz.supabase.co",       // ← Project URL ديالك
SUPABASE_ANON_KEY: "eyJhbGci....",                 // ← anon public key
```

تقدر تبدّل تا سمية المتجر ف `BRAND`. سجّل الملف.

---

## 3️⃣ نشر الموقع (Netlify — بسحب وإفلات)

1. سير لـ **https://app.netlify.com/drop**
2. **اسحب الفولدر `store-site` كامل** وأفلتو ف الصفحة.
3. تسنّى ثواني… يعطيك رابط بحال `https://random-name-123.netlify.app` ✅

**صفحة الزبون:** الرابط هو هو.
**لوحة التحكم:** زيد `/admin.html` ف الأخير → `https://....netlify.app/admin.html`

> باش تبدّل الاسم العشوائي: ف Netlify → **Site configuration → Change site name**.

---

## 4️⃣ جرّب 🎉

1. حل **/admin.html** → دخل بـ Email/Password ديالك → **إدارة المنتجات** → **إضافة منتج** → حط الاسم، الوصف، الثمن، وارفع الصور من جهازك → **حفظ**.
2. حل الموقع الرئيسي → المنتج بان مع الصورة.
3. دير commande بحال زبون.
4. رجع لـ **/admin.html → الطلبات** → الطلب بان بعلامة **جديد** ✅.

دابا الزبون والـ admin كيتقاسمو **نفس قاعدة البيانات الحقيقية**.

---

## 5️⃣ (اختياري) دومين خاص بيك `.ma` / `.com`

- شري دومين من Namecheap / GoDaddy / أي مزوّد.
- ف Netlify: **Domain management → Add a domain** → اتبع التعليمات (تبديل DNS).
- باش `monsite.ma/admin` تخدم بلا `.html`: صاوب ملف `_redirects` فيه:
  ```
  /admin    /admin.html   200
  ```
  وزيدو ف الفولدر قبل ما تنشر.

---

## 🔧 إصلاح المشاكل

| المشكل | الحل |
|---|---|
| الموقع خاوي / "Loading…" مكتعلق | تأكد `config.js` فيه URL و KEY صحيحين (بلا مسافات). |
| ماقدرتش تدخل لـ admin | تأكد أنشأتي اليوزر ف Authentication، وأن "Confirm email" مطفّي. |
| الصور ماكتطلعش | تأكد شغّلتي `database-setup.sql` كامل (كيصاوب الـ bucket). |
| المنتج ماكيتسجلش | راجع كلمة السر/الإيميل وأن SQL تشغّل بنجاح. |

---

## 🔐 ملاحظة أمان مهمة

- مفتاح `anon` آمن باش يكون ف الموقع — الحماية كتجي من **سياسات RLS** اللي صاوبناها (الزبناء ميقدروش يقراو الطلبات ولا يبدّلو المنتجات).
- **متخبّيش** الـ Database Password، خليه عندك بوحدك.
- إلا بغيتي تزيد admin آخر، زيد user ف Supabase Authentication.

مبروك متجرك! 🥳
