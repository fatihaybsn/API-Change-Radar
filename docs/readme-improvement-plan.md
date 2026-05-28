# README Improvement Plan

Bu doküman API Change Radar projesinin teknik analizini, mevcut README.md dosyasının değerlendirmesini ve iyileştirme planını içerir. README doğrudan değiştirilmemiştir; bu doküman bir sonraki adımda yapılacak düzenleme için yol haritasıdır.

---

## 1. Project Positioning

### Proje şu anda nasıl algılanıyor?

Mevcut haliyle README, projeyi "production-minded backend portfolio project" olarak tanıtıyor. Bu iyi bir niyet ama README'nin genel tonu ve yapısı bunu tam olarak desteklemiyor. İlk izlenim:

- "Bir öğrenci projesi ama düzgün yapılmış" — bu kötü değil ama yeterli de değil.
- README çok uzun (621 satır). Bilgi var ama hiyerarşi ve odak eksik.
- Bir recruiter veya teknik müdür ilk 10 saniyede ne gördüğünde karar verir: proje ne yapıyor, canlı mı, gerçek mi? Mevcut README bunu yeterince hızlı iletmiyor.
- "pre-MVP / active build" ifadesi projenin yarım, deneysel ve güvenilmez olduğu izlenimini veriyor.

### Nasıl algılanmalı?

"Gerçek bir problemi çözen, production kalitesinde tasarlanmış, canlı demo üzerinden doğrudan test edilebilen bir backend servis."

Mesaj net olmalı: bu bir toy project değil, backend mühendisliğinin temel konularını (API design, persistence, observability, CI, Docker, deploy) gerçek bir iş akışı üzerinde gösteren çalışan bir sistem.

### Hedef kitle kim?

- Birincil: Staj veya junior backend pozisyonu için başvuru yapan bilgisayar mühendisliği öğrencisi/mezunu.
- İkincil: Bu başvuruyu değerlendiren teknik müdür, senior backend geliştirici veya recruiter.
- Üçüncül: Portfolyo sitesi veya LinkedIn üzerinden projeye denk gelen sektör profesyonelleri.

---

## 2. Current README Assessment

### Güçlü taraflar

1. **Açık problem tanımı.** "What this project does" bölümü projenin çözdüğü sorunu iyi açıklıyor. API değişikliklerinin neden düz diff ile yetinilemeyeceğini anlatıyor.
2. **Architecture summary doğru ve net.** 8 bileşen temiz şekilde listelenmiş. Bir backend mühendisi buna bakarak projenin iç yapısını hızlıca anlayabilir.
3. **Tech stack listesi tam.** Python 3.12, FastAPI, PostgreSQL, SQLAlchemy, Alembic, Docker, Pytest, OpenTelemetry, GitHub Actions — eksik yok.
4. **Docker akışı iyi düşünülmüş.** Docker Hub image + release compose + dev compose ayrımı profesyonel bir dağıtım anlayışı gösteriyor.
5. **Swagger ile test akışı var.** Hem canlı demo hem local için adım adım anlatılmış.
6. **Design principles bölümü var.** "Deterministic logic first", "AI is optional and non-authoritative" gibi ilkeler, bilinçli tasarım kararları gösteriyor.
7. **Troubleshooting bölümü var.** Basit ama gerçekçi.
8. **Canlı demo linkleri mevcut.** Swagger UI, healthz ve API base URL verilmiş.
9. **curl örnekleri var.** Swagger dışında komut satırından da test akışı gösterilmiş.
10. **Örnek dosyalar (examples/) dahil edilmiş.** v1.yaml, v2.yaml ve sample-report.md dosyaları projeyi denemek için hazır.

### Zayıf taraflar

1. **README 621 satır — çok uzun.** Bilgi tekrarı var, öncelik sıralaması eksik. Bir recruiter bunu okumaz, scroll eder ve çıkar.
2. **Canlı demo yeterince öne çıkmıyor.** Swagger linkleri var ama "Live Demo" bölümü küçük ve sıradan görünüyor. Badge veya dikkat çekici format yok.
3. **"pre-MVP / active build" ifadesi projeye zarar veriyor.** Proje aslında çalışıyor: ingestion → diff → severity → persist → report akışı tamamlanmış, 16 test dosyası var, CI çalışıyor, Render'da deploy edilmiş. Bu "pre-MVP" değil.
4. **Cold start uyarısı yeterince açık değil.** "may take around one minute" yazıyor ama bu canlı demo için kritik bir bilgi. Recruiter linke tıklayıp hata aldığını düşünebilir.
5. **"Normal user flow" ve "Distribution model" bölümleri gereksiz uzun.** Bu bilgi Docker Compose kullanan birisi için zaten açık. Bir portfolio projesi için "normal user" kavramı zorlama.
6. **Docker Hub image bilgisi çok üstte ve çok belirgin.** Proje bir Docker image olarak dağıtılmıyor aslında; herkes kendi Docker'ını build edecek ya da canlı demoyu kullanacak. Docker Hub bilgisi önemli ama mevcut konumda mesajı karıştırıyor.
7. **"How to use the application" ve "Fastest manual test via Swagger UI" bölümleri büyük oranda tekrar ediyor.** İkisi arasında ciddi overlap var. Aynı endpoint'ler farklı tonlarla iki kez anlatılıyor.
8. **API surface summary gereksiz.** Bu bilgi zaten Swagger UI'da mevcut. README'de tekrar etmek değer katmıyor.
9. **Environment variables tablosu çok detaylı.** Normal kullanıcının çoğu değişkeni değiştirmesi gerekmez. `.env.example` zaten var.
10. **Markdown format sorunları.** `\\---` (kaçış karakterli ayraçlar), `\\_` (gereksiz underscore escape), `<YOUR\_GITHUB\_REPOSITORY\_URL>` gibi bozuk placeholder'lar var.
11. **MVP scope bölümü README'de gerekli mi?** Bu bilgi `docs/adr/ADR-0001-mvp-scope.md` dosyasında zaten var. README'de tekrar etmek gereksiz.
12. **Author bölümü çok kısa.** LinkedIn, GitHub profili veya kişisel site linki yok.

### Riskli / kafa karıştırıcı ifadeler

| İfade | Sorun | Öneri |
|-------|-------|-------|
| `pre-MVP / active build` | Projenin yarım olduğu izlenimini veriyor. | Kaldır. "Early release" veya hiç status yazmamak daha iyi. |
| `Normal user flow` | Portfolio projelerinde "normal user" tanımı zorlama. | Bu bölümü kaldır, Docker setup'a entegre et. |
| `<YOUR_GITHUB_REPOSITORY_URL>` | Gerçek URL girilmemiş. Projenin "unfinished" görünmesine neden oluyor. | Gerçek GitHub repo URL'si ile değiştir. |
| `This project is designed as a production-minded backend portfolio project.` | Doğru ama README'nin ilk satırlarında olması gerekmez. "Portfolio project" demek yerine teknik değeri göstermek daha etkili. | Description'dan çıkar, teknik yetenekler ile göster. |
| `report_id is the same UUID as the run_id` | Bu bir implementasyon detayı. README'de olmamalı. | Kaldır veya dipnot yap. |
| `ENABLE_LLM_CHANGELOG` env variable | AI feature flag'i çok detaylı anlatılmış. Bu feature henüz aktif değilse README'de bu kadar yer kaplamamalı. | Kısalt, sadece "optional AI enrichment, disabled by default" yeterli. |

---

## 3. Recommended Publishing Strategy

### GitHub repo + README

| Kriter | Değerlendirme |
|--------|---------------|
| Recruiter etkisi | **Yüksek** — recruiter'lar GitHub linkine tıklar, README okur. |
| Teknik müdür etkisi | **Yüksek** — kod kalitesi, test coverage, CI, commit history. |
| Kullanım kolaylığı | **Yüksek** — zaten mevcut. |
| Bakım maliyeti | **Düşük** — sadece README güncellemeleri. |
| Gerçekçi fayda | **Çok yüksek** — temel vitrin. |
| Gereksiz karmaşıklık riski | **Düşük.** |

**Karar:** ✅ Birincil vitrin. README kalitesi kritik.

### GitHub repo + canlı Swagger UI linki

| Kriter | Değerlendirme |
|--------|---------------|
| Recruiter etkisi | **Çok yüksek** — "Canlı link → tıkla → çalışıyor" en güçlü demo. |
| Teknik müdür etkisi | **Yüksek** — gerçek çalışan servis, API tasarımını doğrudan görür. |
| Kullanım kolaylığı | **Çok yüksek** — tek tıklama. |
| Bakım maliyeti | **Düşük** — Render free tier, zaten deploy edilmiş. |
| Gerçekçi fayda | **Çok yüksek** — diğer portfolio projelerinden ayrıştıran ana faktör. |
| Gereksiz karmaşıklık riski | **Düşük.** Cold start sorunu var ama açıklama ile yönetilebilir. |

**Karar:** ✅ README'de en üstte, dikkat çekici şekilde gösterilmeli. Ana diferansiyatör.

### Kişisel portfolio sitesinde proje kartı

| Kriter | Değerlendirme |
|--------|---------------|
| Recruiter etkisi | **Orta-yüksek** — profesyonel görünüm. |
| Teknik müdür etkisi | **Orta** — genelde GitHub'a yönlendirir. |
| Kullanım kolaylığı | **Yüksek** — kart + link. |
| Bakım maliyeti | **Düşük** — statik içerik. |
| Gerçekçi fayda | **Orta-yüksek** — projeyi bir bağlam içinde sunar. |
| Gereksiz karmaşıklık riski | **Düşük.** |

**Karar:** ✅ Yapılmalı. Kısa açıklama + tech stack + canlı demo linki + GitHub linki. Ama öncelik README.

### AI Lab altında kullanıma açma

| Kriter | Değerlendirme |
|--------|---------------|
| Recruiter etkisi | **Düşük** — "AI Lab" etiketi bu projenin doğasına uymuyor. |
| Teknik müdür etkisi | **Nötr-negatif** — "AI" etiketini görüp asıl deterministic değeri gözden kaçırabilir. |
| Kullanım kolaylığı | **Orta.** |
| Bakım maliyeti | **Düşük.** |
| Gerçekçi fayda | **Düşük** — proje backend engineering projesi, AI projesi değil. |
| Gereksiz karmaşıklık riski | **Orta** — yanıltıcı konumlandırma riski. |

**Karar:** ❌ Yapılmamalı. Bu proje "AI Lab" kapsamına uymuyor. LLM changelog özelliği opsiyonel ve ikincil. Projeyi AI olarak sunmak hem yanlış hem zararlı. Backend engineering portfolio projesi olarak konumlandır.

### Docker Hub image ile dağıtım

| Kriter | Değerlendirme |
|--------|---------------|
| Recruiter etkisi | **Düşük** — recruiter Docker Hub kullanmaz. |
| Teknik müdür etkisi | **Orta** — image pipeline gösterir ama tek başına yeterli değil. |
| Kullanım kolaylığı | **Orta** — hâlâ compose + .env setup gerekiyor. |
| Bakım maliyeti | **Orta** — her değişiklikte push gerekir. |
| Gerçekçi fayda | **Düşük-orta** — canlı demo varken gereksiz. |
| Gereksiz karmaşıklık riski | **Orta** — bakım yükü getiriyor, README'de açıklama gerektiriyor. |

**Karar:** ⚠️ Image Docker Hub'da kalsın ama README'de aşağıda, "Local Setup (Docker)" bölümünde kısa referans verilsin. Üstte öne çıkarılmasın. Ana demo kanalı canlı Swagger.

### Blog / LinkedIn teknik yazısı ile destekleme

| Kriter | Değerlendirme |
|--------|---------------|
| Recruiter etkisi | **Yüksek** — teknik düşünce sürecini gösterir. |
| Teknik müdür etkisi | **Çok yüksek** — "neden bu kararı aldı?" sorusuna cevap verir. |
| Kullanım kolaylığı | **Yüksek** — okumak kolay. |
| Bakım maliyeti | **Çok düşük** — bir kez yaz. |
| Gerçekçi fayda | **Yüksek** — projeye derinlik katar. |
| Gereksiz karmaşıklık riski | **Düşük.** |

**Karar:** ✅ Önerilir ama README'den bağımsız, ayrı bir iş. README'de "Written about this project" bağlantısı olabilir. Şu an zorunlu değil.

### Strateji özeti

| Kanal | Öneri | README'deki yeri |
|-------|-------|-----------------|
| GitHub repo + README | ✅ Temel vitrin | — |
| Canlı Swagger UI | ✅ Ana diferansiyatör | En üstte, badge ile |
| Portfolio site kartı | ✅ Yapılmalı | README'ye bağlantı opsiyonel |
| AI Lab | ❌ Uygun değil | Hiç referans verme |
| Docker Hub | ⚠️ Mevcut ama aşağıda | "Local Setup" bölümünde kısa referans |
| Blog/LinkedIn | ✅ Önerilir | Opsiyonel bağlantı |

### Repo About alanı önerisi

```
Backend service that compares OpenAPI specs, detects breaking changes, classifies risk, and produces structured reports. Live demo available.
```

Topics: `fastapi`, `openapi`, `backend`, `docker`, `postgresql`, `python`

### Portfolio sitesinde konumlandırma önerisi

Proje kartı şu bilgileri içermeli:
- Proje adı: API Change Radar
- Tek cümle: "İki OpenAPI spec'i karşılaştır, kırılma risklerini sınıflandır, yapılandırılmış rapor al."
- Tech stack: FastAPI · PostgreSQL · Docker · OpenTelemetry
- Linkler: [Canlı Demo (Swagger)] [GitHub]
- "AI Lab" altında değil, "Backend Engineering" veya "Projects" altında.

---

## 4. Recommended README Structure

### Mevcut sıralama

```
1.  Başlık + açıklama (2 paragraf)
2.  Live Demo (3 link + Swagger test adımları)
3.  What this project does
4.  Key features
5.  Project status (pre-MVP / active build)
6.  Architecture summary
7.  Tech stack
8.  Distribution model (Normal user flow, Docker Hub, Compose files)
9.  Quick start for normal users (Prerequisites → git clone → .env → docker compose → verify → stop)
10. Updating to a newer image version
11. Development setup
12. How to use the application (Main usage flow, supported formats, upload limits)
13. Fastest manual test via Swagger UI (5 endpoint adımı)
14. Example test files
15. Example usage with curl
16. One-shot smoke test
17. API surface summary
18. Environment variables (büyük tablo + .env örneği)
19. Local database and migrations
20. CI summary (tek paragraf)
21. Design principles
22. MVP scope (included + non-goals)
23. Demo / portfolio notes
24. Troubleshooting
25. Author
```

### Önerilen yeni sıralama

```
1.  Başlık + tek cümle açıklama + badge'ler
2.  ⚡ Live Demo (dikkat çekici kutu, cold start notu dahil)
3.  What it does (kısa, 4-5 madde)
4.  Key features (öne çıkanlar)
5.  Architecture overview (mevcut özet, belki basit metin diyagramı)
6.  Tech stack
7.  Try it yourself — Live Swagger (kısa Swagger test akışı, 5-6 adım)
8.  Local setup with Docker (compose pull + up, en kısa yol)
9.  Development setup (dev compose, kısa)
10. Example usage with curl (kısa, 2-3 komut)
11. Design principles (kısa, mevcut hali iyi)
12. CI & testing (kısa özet, test sayısı veya coverage bilgisi)
13. Project structure (opsiyonel, kısa klasör ağacı)
14. Troubleshooting (mevcut, kısa)
15. Author + linkler
```

### Çıkarılacak/birleştirilecek bölümler

- **Distribution model** → "Local setup with Docker" içine kısa referans olarak entegre et.
- **Normal user flow** → Kaldır. Docker setup bölümü yeterli.
- **Docker Hub image** (ayrı bölüm olarak) → Kaldır. Docker setup'ta `docker compose pull` komutu içinde image adı zaten görünüyor.
- **Which Compose file is for what?** → "Local setup" ve "Development setup" bölümlerinde birer satırla belirt.
- **How to use the application** → "Try it yourself — Live Swagger" ile birleştir.
- **Fastest manual test via Swagger UI** → "Try it yourself — Live Swagger" ile birleştir.
- **API surface summary** → Kaldır. Swagger zaten bunu yapıyor.
- **Environment variables** (büyük tablo) → Çok kısalt. "See `.env.example` for all options" yeterli, sadece 3-4 kritik değişkeni listele.
- **MVP scope** → Kaldır. Bu bilgi `docs/adr/ADR-0001-mvp-scope.md` dosyasında zaten var. İsteyen oraya baksın.
- **Updating to a newer image version** → Kaldır veya Docker setup dipnotuna taşı.
- **Demo / portfolio notes** → Kaldır. README'nin tamamı zaten demo/portfolio amacıyla yazılıyor.
- **Example test files** → "Try it yourself" bölümü içinde tek satırla referans ver.
- **One-shot smoke test** → "CI & testing" bölümü içinde tek satırla referans ver.
- **Local database and migrations** → "Development setup" bölümünde tek satır.

---

## 5. Section-by-Section Change Plan

### Başlık + açıklama (satır 1-6)

**Karar: REWRITE**

Gerekçe: İlk paragraf "production-minded backend portfolio project" diyor. Bu self-referential. Projenin ne yaptığını söyle, ne olduğunu değil. İkinci paragraf ("The goal is not to ship a toy diff script...") savunmacı ton taşıyor. Bu cümle README'nin giriş paragrafında olmamalı.

Önerilen yaklaşım: Tek cümle açıklama + badge satırı. "Portfolio project" ifadesini kaldır; projenin teknik değeri kendini göstersin.

---

### Live Demo (satır 9-33)

**Karar: REWRITE + MOVE UP**

Gerekçe: Canlı demo bu projenin en güçlü silahı. Şu an düz metin olarak 3 link + 8 adımlık Swagger akışı var. Bu yeterince dikkat çekmiyor. Cold start notu var ama küçük ve yeterince net değil.

Önerilen yaklaşım:
- Badge satırının hemen altına taşı.
- Callout/kutu formatında dikkat çekici bir blok oluştur (markdown blockquote veya tablo ile).
- Cold start notunu ayrı bir uyarı satırı olarak ekle.
- Swagger test adımlarını buradan çıkar, ayrı bir "Try it yourself" bölümüne taşı.

---

### What this project does (satır 35-45)

**Karar: KEEP + SHORTEN**

Gerekçe: İçerik iyi ama biraz uzun. 4 maddelik soru listesi efektif. Öncesindeki paragraf ("API changes often create silent breakage...") iyi ama daha kısa olabilir.

---

### Key features (satır 48-61)

**Karar: KEEP + SHORTEN**

Gerekçe: 11 madde çok. En önemli 6-7 maddeye indir. "Accept JSON or YAML spec uploads" gibi detaylar başlı başına feature değil.

---

### Project status (satır 64-68)

**Karar: REWRITE**

Gerekçe: `pre-MVP / active build` ifadesi yanlış ve zararlı.

Gerçek durum:
- Core akış çalışıyor (ingest → parse → normalize → diff → severity → persist → report).
- 16 test dosyası mevcut (~155K byte toplam test kodu).
- CI pipeline çalışıyor (lint + format + migration + test + container build + smoke test).
- Render'da canlı deploy var.
- 3 migration dosyası var (persistence foundation, run lifecycle, LLM fields).
- Docker Hub image yayınlanmış.

Bu proje "pre-MVP" değil. Minimum çalışan ürün fazlasıyla tamamlanmış. "MVP complete — actively maintained" veya sadece versiyon numarası (`v0.1.0`) ile durumu belirtmek daha doğru.

---

### Architecture summary (satır 72-86)

**Karar: KEEP**

Gerekçe: Net, doğru ve faydalı. 8 bileşen temiz listeleniyor. Bir teknik müdür bunu okuyunca projenin nasıl düşünüldüğünü anlıyor. `docs/architecture.md` referansı da iyi.

Tek ekleme önerisi: Basit bir text-based akış diyagramı (mermaid veya ASCII) eklemek görselliği artırabilir ama zorunlu değil.

---

### Tech stack (satır 89-99)

**Karar: KEEP**

Gerekçe: Kısa, doğru, tam. Değiştirmeye gerek yok. Opsiyonel olarak badge formatına dönüştürülebilir.

---

### Distribution model + Normal user flow + Docker Hub image + Which Compose file (satır 102-138)

**Karar: REMOVE / MERGE**

Gerekçe: Bu 4 alt bölüm toplam ~40 satır tutuyor ve gereksiz karmaşıklık yaratıyor. "Normal user" kavramı bir portfolio projesi için zorlama. Bu bilginin çoğu Docker setup bölümünde 5-6 satırla verilebilir.

Docker Hub image adı → Docker setup bölümünde `docker-compose.yml` kullanımı sırasında doğal olarak görünür.
Compose dosyası ayrımı → "Local setup" (docker-compose.yml) ve "Development" (docker-compose.dev.yml) bölümlerinde birer satır açıklama yeterli.

---

### Quick start for normal users (satır 141-219)

**Karar: REWRITE + SHORTEN**

Gerekçe: "Normal users" başlığını kaldır. "Local Setup with Docker" olarak yeniden adlandır. İçerik doğru ama çok uzun. Özellikle:
- `git clone <YOUR_GITHUB_REPOSITORY_URL>` → Gerçek URL girilmeli.
- PowerShell vs Linux/macOS ayrımı → Gereksiz detay. Tek yol göster, alternatifi dipnot olarak ekle.
- "Verify that the service is running" bölümünde 5 URL listeleniyor → `/healthz` ve `/docs` yeterli.
- "What this does" listesi gereksiz (pull postgres, pull image, start...) → Compose bunu yapıyor, açıklamaya gerek yok.

---

### Updating to a newer image version (satır 222-230)

**Karar: REMOVE**

Gerekçe: 2 komutluk bir bölüm, Docker setup dipnotuna eklenebilir. Ayrı bölüm olamayacak kadar kısa ve düşük öncelikli.

---

### Development setup (satır 233-248)

**Karar: KEEP + SHORTEN**

Gerekçe: Doğru içerik. 2 komut. "Use `docker-compose.dev.yml` only for development work" cümlesi gereksiz tekrar. Kısaltılabilir.

---

### How to use the application (satır 251-283)

**Karar: MERGE into "Try it yourself"**

Gerekçe: Bu bölüm "Fastest manual test via Swagger UI" ile büyük oranda örtüşüyor. İkisini birleştirip tek bir akış haline getirmek daha temiz.

"Supported spec formats" (JSON / YAML) ve "Upload limits" gibi detaylar footnote olarak kalabilir.

---

### Fastest manual test via Swagger UI (satır 286-355)

**Karar: MERGE into "Try it yourself"**

Gerekçe: Yukarıdaki bölümle birleştirilmeli. 5 endpoint adımı doğru ama `report_id` is the same as `run_id` gibi implementasyon detayları çıkarılmalı.

---

### Example test files (satır 357-365)

**Karar: SHORTEN + MERGE**

Gerekçe: "Try it yourself" bölümünde tek satırla referans ver: "Use the example specs from `examples/v1.yaml` and `examples/v2.yaml`."

---

### Example usage with curl (satır 368-404)

**Karar: KEEP + SHORTEN**

Gerekçe: curl örnekleri değerli — API'yi Swagger olmadan da test edebileceğini gösteriyor. Ama 4 ayrı komut + açıklama çok. "Create a run" + "Fetch the report" 2 komut yeterli.

Markdown format sorunu: `\\` (çift backslash) curl satırlarında gereksiz escape var. Düzeltilmeli.

---

### One-shot smoke test (satır 407-426)

**Karar: SHORTEN + MOVE**

Gerekçe: "CI & Testing" bölümüne taşı. Tek satır: "Run `./scripts/smoke.sh` for an end-to-end smoke test."

---

### API surface summary (satır 428-452)

**Karar: REMOVE**

Gerekçe: Swagger UI bu bilgiyi zaten sağlıyor. README'de tekrar etmek gereksiz. Canlı demo linki varken bu bölüm değer katmıyor.

---

### Environment variables (satır 454-493)

**Karar: SHORTEN significantly**

Gerekçe: 15 satırlık tablo + 15 satırlık `.env` örneği = 30+ satır. Çoğu kullanıcı bunları değiştirmez. `.env.example` dosyası zaten var ve yeterli.

Önerilen yaklaşım: "Configuration is managed via environment variables. Copy `.env.example` to `.env` for defaults. See `.env.example` for all available options." Sadece `ENABLE_LLM_CHANGELOG` gibi dikkat çekici ayarları 1-2 satırla açıkla.

---

### Local database and migrations (satır 496-508)

**Karar: SHORTEN + MOVE**

Gerekçe: "Development setup" bölümüne tek satır olarak ekle: "Migrations run automatically on container startup. For manual migration: `alembic upgrade head`."

---

### CI summary (satır 510-515)

**Karar: REWRITE + EXPAND slightly**

Gerekçe: Tek paragraf çok az. CI pipeline güçlü bir özellik (format check, lint, migration check, test, container build, smoke test). Bunu 3-4 satırla daha iyi anlat. Test sayısını veya coverage bilgisini ekle.

---

### Design principles (satır 517-525)

**Karar: KEEP**

Gerekçe: 6 madde, hepsi anlamlı ve bilinçli. Özellikle "AI is optional and non-authoritative" ve "deterministic logic first" ifadeleri çok değerli. Bir teknik müdür bunu okuyunca "bu kişi düşünüyor" der.

---

### MVP scope (satır 527-555)

**Karar: REMOVE**

Gerekçe: Bu bilgi `docs/adr/ADR-0001-mvp-scope.md` dosyasında detaylı olarak mevcut. README'de tekrar etmek gereksiz. Kaldırılması README'yi ~30 satır kısaltır.

"Non-goals for the first version" bilgisi potansiyel olarak Design Principles bölümüne 1-2 satır olarak eklenebilir.

---

### Demo / portfolio notes (satır 557-569)

**Karar: REMOVE**

Gerekçe: README'nin tamamı zaten demo/portfolio vitrini. Ayrı bir "Demo / portfolio notes" bölümü meta-bilgi. Bu bilgi README'nin genel yapısı ile zaten iletilmeli.

---

### Troubleshooting (satır 571-614)

**Karar: KEEP + SHORTEN slightly**

Gerekçe: 3 sorun/çözüm çifti var, hepsi gerçekçi. "Health check works but there is no UI homepage" cevabı iyi — "API-first" mesajını pekiştiriyor. Bırak.

Küçük düzeltme: `APP\_PORT` → `APP_PORT` (escape düzelt).

---

### Author (satır 617-621)

**Karar: REWRITE + EXPAND**

Gerekçe: Sadece isim var. LinkedIn profili, GitHub profili veya kişisel site linki eklenmeli. Recruiter'ın sonraki adımı "bu kişiye nasıl ulaşırım?" olacak.

---

## 6. Exact Content Suggestions

### Live Demo bloğu

```markdown
## ⚡ Live Demo

> **Try it now →** [Swagger UI](https://api-change-radar.onrender.com/docs)
>
> Upload two OpenAPI specs, get a risk-classified change report in seconds.
>
> ⏳ **First request may take ~60 seconds** — the service runs on Render Free and spins down when idle.
```

### Project Status bloğu

```markdown
**Status:** MVP complete · Actively maintained · [v0.1.0](https://github.com/fatihaybsn/API-Change-Radar/releases)
```

Veya status satırını tamamen kaldırıp badge'lerle göster:

```markdown
![Status](https://img.shields.io/badge/status-MVP%20complete-green)
```

### Try it in Swagger bloğu

```markdown
## Try It Yourself

The fastest way to test the full flow:

1. Open the [Swagger UI](https://api-change-radar.onrender.com/docs) (or `http://localhost:8000/docs` if running locally)
2. Expand **POST /api/v1/runs**
3. Click **Try it out**
4. Upload two OpenAPI spec files (use the included `examples/v1.yaml` and `examples/v2.yaml`)
5. Click **Execute** — you'll receive a `run_id`
6. Use the `run_id` with:
   - **GET /api/v1/runs/{run_id}** — check processing status
   - **GET /api/v1/reports/{run_id}** — fetch the JSON report
   - **GET /api/v1/reports/{run_id}?format=markdown** — Markdown export
   - **GET /api/v1/reports/{run_id}/demo** — minimal HTML report page
```

### Repo About açıklaması

```
Backend service that compares OpenAPI specs, detects breaking changes, classifies risk, and produces structured reports. Live demo available.
```

### Cold start notu

```markdown
> ⏳ **Cold start:** This demo runs on Render Free. If the service has been idle, the first request may take up to 60 seconds while the container starts. Subsequent requests are fast.
```

### CI & Testing bölümü önerisi

```markdown
## CI & Testing

Automated CI via GitHub Actions on every push and PR:

- **Code quality:** `ruff format --check` + `ruff check`
- **Database:** Migration validation with `alembic upgrade head`
- **Tests:** 16 test modules covering diff engine, severity engine, API ingestion, report retrieval, run orchestration, settings, health, and E2E smoke
- **Container:** Docker build + smoke test against live stack

Run locally: `make check` (lint + test) or `./scripts/smoke.sh` (E2E smoke test)
```

---

## 7. Markdown Cleanup Checklist

### Gereksiz escape karakterleri

- [ ] `\\---` → `---` (tüm horizontal rule'larda)
- [ ] `\\_` → `_` (tüm alt çizgilerde: `run\_id`, `changelog\_text`, `report\_id`, `APP\_NAME`, vb.)
- [ ] `<YOUR\_GITHUB\_REPOSITORY\_URL>` → gerçek GitHub repo URL'si
- [ ] `<YOUR\_REPOSITORY\_FOLDER>` → `API-Change-Radar`
- [ ] `<RUN\_ID>` → `<RUN_ID>` (escape gereksiz)

### Kod blokları

- [ ] curl komutlarındaki `\\\\` (çift backslash) → `\` (tek backslash)
- [ ] `.env` bloğundaki `IMAGE\_TAG` → `IMAGE_TAG` vb.

### Linkler

- [ ] `<YOUR_GITHUB_REPOSITORY_URL>` → `https://github.com/fatihaybsn/API-Change-Radar` (veya doğru URL)
- [ ] Author bölümüne GitHub/LinkedIn linki ekle

### Başlık hiyerarşisi

- [ ] Tek bir `# H1` olduğunu doğrula (şu an doğru, sadece `# API Change Radar`)
- [ ] `### 1\) Create a run` → `### 1. Create a run` (kaçış karakterli parantez düzelt)
- [ ] Tüm numbered section başlıklarındaki `\)` → `)` düzelt

### Badge önerileri

README'nin en üstüne eklenecek badge'ler:

```markdown
![CI](https://github.com/<user>/API-Change-Radar/actions/workflows/ci.yml/badge.svg)
![Python 3.12](https://img.shields.io/badge/python-3.12-blue)
![FastAPI](https://img.shields.io/badge/FastAPI-0.115-009688)
![License: MIT](https://img.shields.io/badge/license-MIT-green)
![Live Demo](https://img.shields.io/badge/demo-live%20on%20Render-blueviolet)
```

### Tutarlı terminology

- [ ] "spec" vs "specification" → Tutarlı olarak "spec" kullan (README'de zaten çoğunlukla böyle)
- [ ] "run" vs "analysis run" → API endpoint'lerinde "run", açıklamalarda "analysis run" tutarlılığını koru
- [ ] "demo report" vs "HTML report" → Tutarlı olarak "demo report" kullan

---

## 8. Final Priority List

### 🔴 Critical (ilk düzenlemede mutlaka yapılmalı)

1. **`pre-MVP / active build` ifadesini kaldır veya güncelle.** Proje çalışıyor, deploy edilmiş, test ediliyor. Bu ifade projenin değerini düşürüyor. → `v0.1.0 — MVP complete` veya status satırını tamamen kaldır.

2. **Canlı demo linkini üste taşı ve dikkat çekici yap.** README'nin ilk 5 satırında canlı Swagger linki, kısa açıklama ve cold start notu olmalı. Bu projenin en güçlü özelliği.

3. **Cold start notunu netleştir.** "may take around one minute" yerine "first request may take up to 60 seconds while the container starts. Subsequent requests are fast." daha güvenilir.

4. **`<YOUR_GITHUB_REPOSITORY_URL>` placeholder'ını düzelt.** Gerçek URL ile değiştir. Bu şu an projenin "unfinished" görünmesine neden oluyor.

5. **Markdown escape karakterlerini düzelt.** `\\---`, `\\_`, `\\\\` gibi bozuk kaçış karakterleri README'nin ham halini okunmaz yapıyor ve bazı render engine'lerde görsel sorun yaratıyor.

### 🟡 Important (ilk düzenlemede yapılmalı, ama Critical'den sonra)

6. **README'yi kısalt.** 621 satırdan ~300-350 satıra indirilmeli. Tekrar eden bölümleri birleştir, gereksiz bölümleri kaldır (Distribution model, Normal user flow, API surface summary, MVP scope, Demo/portfolio notes).

7. **Bölüm sıralamasını yeniden düzenle.** Önerilen yeni sıralama: Başlık → Live Demo → What it does → Key features → Architecture → Tech stack → Try it yourself → Local setup → Dev setup → curl examples → Design principles → CI → Troubleshooting → Author.

8. **"Normal user flow" ve "Distribution model" bölümlerini kaldır.** Bu kavramlar bir portfolio projesi için uygun değil. Docker setup bölümü yeterli.

9. **"How to use the application" ve "Fastest manual test via Swagger UI" bölümlerini birleştir.** Tek bir "Try it yourself" bölümü yeterli.

10. **Environment variables tablosunu kısalt.** "See `.env.example`" referansı + 2-3 kritik değişken yeterli.

11. **Badge'ler ekle.** CI status, Python version, FastAPI version, license, live demo badge'leri README'ye profesyonellik katar.

12. **Author bölümüne linkler ekle.** GitHub profili, LinkedIn, kişisel site (varsa).

### 🟢 Nice to have (sonraki iterasyonda yapılabilir)

13. **Architecture bölümüne basit bir metin/mermaid akış diyagramı ekle.** Görsel olarak etkileyici ama zorunlu değil.

14. **Project structure (klasör ağacı) bölümü ekle.** Backend mimarisini görsel olarak gösterir.

15. **Test coverage bilgisi ekle.** CI'da coverage report üretip badge olarak eklenmesi güçlü bir sinyal.

16. **Repo About alanını güncelle.** Önerilen metin: "Backend service that compares OpenAPI specs, detects breaking changes, classifies risk, and produces structured reports. Live demo available."

17. **Blog/LinkedIn yazısı yaz.** "Bu projeyi neden yaptım, ne öğrendim, hangi kararları neden aldım?" Teknik derinlik gösterir.

18. **Screenshot veya GIF ekle.** Swagger UI'da yapılan bir test akışının kısa bir ekran görüntüsü veya GIF'i çok etkili olabilir.

---

## Ek: Kritik Karar Noktaları

### README'nin ilk ekranında Docker mı, canlı Swagger mı öne çıkmalı?

**Canlı Swagger.** Docker setup herkesin yapabileceği bir şey değil (Docker bilgisi, disk alanı, zaman gerektirir). Canlı Swagger linki ise tek tıklama. Recruiter'ın yapacağı şey: linke tıkla → Swagger'ı gör → "çalışıyor" → karar ver. Docker bilgisi aşağıda "Local Setup" bölümünde olsun.

### "Normal user flow" bölümü gerçekten gerekli mi?

**Hayır.** Bu proje bir SaaS ürünü değil, bir portfolio demosu. "Normal user" kavramı burada yapay. Docker setup bölümü yeterli.

### `pre-MVP / active build` ifadesi korunmalı mı?

**Hayır, kesinlikle değiştirilmeli.** Proje çalışan bir MVP. "pre-MVP" demek çalışan bir projeye "henüz hazır değil" demek gibi. Ya `v0.1.0 — MVP complete` yap, ya da status satırını tamamen kaldır.

### Docker Hub image bilgisi üstte mi kalmalı?

**Hayır, aşağıya taşınmalı.** Docker Hub image bilgisi teknik bir detay. "Local Setup with Docker" bölümünde kısa referans yeterli. Üstte dikkat dağıtıyor.

### README çok teknik mi?

**Teknik ama düzensiz.** Teknik detay iyi — hedef kitle teknik. Sorun detayların organizasyonunda. Doğru sıralama ve kısaltma ile README hem teknik hem okunabilir bir vitrin olabilir.

### Canlı demo linki README'nin neresinde olmalı?

**Başlığın hemen altında, ilk 5 satırda.** Badge satırı → Live Demo kutusu. İlk 10 saniyede görünmeli.

### Cold start notu nasıl yazılmalı?

**Kısa, spesifik ve güven verici:** "First request may take up to 60 seconds (Render Free cold start). Subsequent requests respond in under 1 second." Bu format hem sorunu açıklıyor hem de "bu beklenen bir davranış" mesajı veriyor.

### AI / LLM özelliği nasıl anlatılmalı?

**Kısa ve savunmacı olmadan.** "Optional AI changelog interpretation (disabled by default). Deterministic analysis is always authoritative." Tek satır yeterli. Key features listesinde bir madde. Env variables'da kısa referans. Ayrı bölüm gereksiz.

"AI abartısı" izleniminden kaçınmak için: AI kelimesini başlıkta kullanma, feature listesinde son sıralarda ver, "optional" ve "non-authoritative" ifadelerini koru.
