#!/bin/bash
# WISSEN BERATUNG — Paperclip Skills Installer
# Ausführen auf s01: bash install-wb-skills.sh

set -e

# Volume-Mountpoint ermitteln
VOLUME=$(docker volume ls --format '{{.Name}}' | grep -i paperclip | grep -v pgdata | head -1)
if [ -z "$VOLUME" ]; then
  echo "❌ Kein Paperclip-Volume gefunden. Prüfe: docker volume ls"
  exit 1
fi

MOUNTPOINT=$(docker volume inspect "$VOLUME" --format '{{ .Mountpoint }}')
SKILLS_DIR="$MOUNTPOINT/instances/default/skills"

echo "📦 Volume: $VOLUME"
echo "📁 Mountpoint: $MOUNTPOINT"
echo "📂 Skills-Ziel: $SKILLS_DIR"

mkdir -p "$SKILLS_DIR"

# ─────────────────────────────────────────────
# SKILL 1: wb-brand-voice
# ─────────────────────────────────────────────
cat > "$SKILLS_DIR/wb-brand-voice.md" << 'SKILL_EOF'
---
name: wb-brand-voice
description: >
  Schreibstil für alle Texte im Namen von WISSEN BERATUNG (IT-Beratung & Automatisierung, DACH).
  Nutzen bei: Mails, LinkedIn-Posts, Angebote, Website-Texte, Kaltakquise, Produktkommunikation
  (WB-CRM, WB-InvoiceHub, Chatwoot Whitelabel). Verbotene Phrasen, Satzrhythmus und CTAs
  sind unten definiert.
---

# WISSEN BERATUNG — Brand Voice

## Kernprinzipien

**Nutzen zuerst, nie Ich-Bezug.**
Nicht: "Wir bieten X." → Sondern: "Du gewinnst X."
Nicht: "Wir sind stolz auf..." → Nie. Kein einziges Mal.

**Schmerz vor Lösung.**
Starte beim Problem des Lesers — nicht beim Produkt.
Der erste Satz soll auslösen: "Das kenne ich." Erst dann kommt die Lösung.

**Konkret, nicht abstrakt.**
Nicht: "Ihre Prozesse werden optimiert."
Sondern: "Das Angebot, das Sie letzte Woche vergessen haben — das passiert nicht nochmal."

**Kurze Sätze als Wucht.**
Drei Punkte hintereinander. Kurz. Hart. Treffen.
Dann ein längerer Satz der erklärt.

**Kein Druck. Klare Einladung.**
CTAs: "Darf ich Ihnen das in 20 Minuten zeigen?" — kein "Jetzt kaufen", kein "Nur noch heute".

**Augenhöhe.**
Der Leser ist Unternehmer, IT-Leiter, Entscheider. Schreiben auf Augenhöhe — direkt, ohne Herablassung.

---

## Verbotene Phrasen (nie verwenden)

- "innovativ" / "innovative Lösungen"
- "digitale Transformation"
- "führender Anbieter"
- "Mehrwert bieten"
- "wir sind stolz"
- "maßgeschneidert" (außer buchstäblich gemeint)
- "ganzheitlich"
- "state of the art"
- "synergieeffekte"
- "zukunftsorientiert"
- Jede Phrase die auch in einer SAP-Pressemitteilung stehen könnte

---

## Satzrhythmus-Muster

**Einstieg:** Frage oder Feststellung die den Schmerz trifft.
> "Kennen Sie das Gefühl, nach einem Kundengespräch zu wissen: 'Da war noch etwas — aber was?'"

**Problem:** Kurze, harte Sätze.
> "Ein Angebot vergessen. Ein Interessent kalt. Ein Auftrag weg."

**Wendepunkt:** "Genau hier setzt X an:" — dann nüchterne Beschreibung.

**Nutzen:** Konkrete Frage oder Aufzählung.
> "Sie sehen auf einen Blick: Wer braucht heute eine Nachverfolgung? Welche Angebote laufen ab?"

**CTA:** Weich, ohne Druck, mit konkretem nächsten Schritt.

---

## Zielgruppen-Mapping

| Leser | Ton | Fokus |
|---|---|---|
| Geschäftsführer KMU | Direkt, unternehmerisch | Zeit, Geld, Risiko |
| IT-Leiter | Technisch präzise, kein Oversell | Funktioniert wirklich? Integration? |
| Solo-Unternehmer | Persönlicher, weniger formal | Entlastung, Überblick, Kontrolle |
| Mitarbeiter | Verständlich, ohne Fachjargon | Was ändert sich für mich? |

---

## Markenfarben
- Navy:  #1D3C6E
- Blue:  #1A8BC4
- Cyan:  #00C8E8

---

## Positiv-Referenz

```
Kennen Sie das Gefühl, nach einem Kundengespräch zu wissen: „Da war noch etwas — aber was?"

Für die meisten inhabergeführten Unternehmen im Mittelstand ist Vertrieb keine strukturierte
Pipeline, sondern Bauchgefühl plus Erinnerungsvermögen. Das funktioniert — bis es nicht mehr
funktioniert. Bis ein Angebot vergessen wird. Ein Interessent kalt wird. Ein Auftrag zur
Konkurrenz geht.

Genau an diesem Punkt setzt WB-CRM an:
Kein Salesforce-Overkill, kein teures Beratungsprojekt. Ein schlankes System, das Ihre
Kundenbeziehungen sichtbar macht — damit aus Kontakten Aufträge werden.

Darf ich Ihnen das einmal in 20 Minuten zeigen?
```

## Negativ-Referenz (so NICHT)

```
Als führender Anbieter innovativer IT-Lösungen unterstützen wir Unternehmen dabei,
ihre digitale Transformation voranzutreiben. Wir sind stolz darauf, unseren Kunden
durch maßgeschneiderte, ganzheitliche Lösungen einen nachhaltigen Mehrwert zu bieten.
```

---

## Checkliste

- [ ] Steht der Nutzen des Lesers im Vordergrund — nicht das Produkt?
- [ ] Gibt es einen konkreten Schmerz im Einstieg?
- [ ] Sind verbotene Phrasen eliminiert?
- [ ] Ist der CTA weich aber klar?
- [ ] Würde ein Geschäftsführer das in 30 Sekunden verstehen?
SKILL_EOF

echo "✅ wb-brand-voice.md"

# ─────────────────────────────────────────────
# SKILL 2: wb-personal-voice
# ─────────────────────────────────────────────
cat > "$SKILLS_DIR/wb-personal-voice.md" << 'SKILL_EOF'
---
name: wb-personal-voice
description: >
  Persönlicher Schreibstil von Tobias Wissen (Inhaber WISSEN BERATUNG) für LinkedIn-Posts,
  persönliche Nachrichten, Kommentare, DMs, Story-Posts. Norddeutsch-pragmatisch, nüchtern
  bei Erfolgen, trocken humorvoll. NICHT für offizielle WISSEN BERATUNG Kommunikation —
  dafür wb-brand-voice nutzen.
---

# Personal Voice — Tobias Wissen

## Wer Tobias ist
Norddeutsch-pragmatischer IT-Unternehmer. Macht Dinge einfach, wenig Aufhebens, denkt
trotzdem drei Schritte weiter als sein Gegenüber.

---

## Kerncharakter

**Nüchtern bei Erfolgen.**
Kein Ausrufezeichen-Feuerwerk. Kein "WOW, was für eine Reise!".
"So, Auftrag hab ich." — das ist Tobias.

**Trocken humorvoll.**
Nicht laut lustig. Eher `^^` oder `;)` an der richtigen Stelle.

**Denkt mit, ohne gefragt zu werden.**
Sieht Monats-Abo und sagt proaktiv: "Macht da nicht Jahrestarif mehr Sinn?"

**Direkt, kein Drumherumreden.**
Eine Frage. Eine Antwort. Kein Aufwärmen.

---

## Sprachliche Merkmale

**Was Tobias schreibt:**
- Kurze Sätze. Oft ohne Punkt am Ende
- „joar", „moin", „hej" — keine gestelzten Begrüßungen
- Norddeutscher Einschlag: „och jaor muss ne", „wie is"
- Emoticons: `^^` `;)` `:)` — keine Emoji-Lawinen
- „ne" statt „nicht wahr" oder „oder?"

**Was Tobias NICHT schreibt:**
- „Ich bin so dankbar für diese Reise 🙏"
- „Das hat mein Leben verändert"
- Dreifache Ausrufezeichen
- Bullet-Listen mit Motivationsfloskeln
- Inspirationssprüche die auch auf einem Kalender stehen könnten

---

## LinkedIn Posts — Tobias-Stil

LinkedIn-Tobias = WhatsApp-Tobias + eine Schippe Bewusstsein. Gleiche Person.

**Einstieg:** Konkrete Beobachtung oder nüchterne Feststellung — keine generischen Fragen.
Gut: "Letzten Monat hat ein Kunde sein Abo gekündigt. Nicht weil das Produkt schlecht war."
Schlecht: "90% der Meetings sind Zeitverschwendung." (zu generisch)

**Länge:** Kurz bis mittel. Wenn's in 5 Sätzen gesagt ist — 5 Sätze.

**Abschluss:** Kein "Was denkst du? Schreib's in die Kommentare! 👇"
Eher: "Wer das kennt — gerne austauschen." Oder einfach aufhören.

---

## Positiv-Referenz

```
Heute Abend Erstgespräch.

Kunde braucht Superchat-Flows, ein paar Automatisierungen,
und irgendwie soll Calendly auch noch rein.
Spoiler: Calendly brauchen wir dann doch nicht.

Das passiert mir öfter — man kommt mit einer Erwartung rein
und merkt nach 20 Minuten: da ist eigentlich was ganz anderes das Problem.

Deswegen frage ich erstmal. Viel. Und dann fange ich an.

[18:35] "So, Auftrag hab ich."
```

## Negativ-Referenz (so NICHT)

```
90 % der Meetings sind Zeitverschwendung
Ich habe es selbst erlebt – als Teamleiter mit einem vollen Kalender und null Output.
Irgendwann war Schluss.
```
→ Klingt nach Motivationsredner. Nicht nach Tobias.

---

## Checkliste

- [ ] Würde Tobias das so tippen — auch wenn er in Eile ist?
- [ ] Kein einziger Satz der auf einem Motivationskalender stehen könnte?
- [ ] Erfolg nüchtern erzählt, nicht gefeiert?
- [ ] Klingt das nach Norddeutschland oder nach einem LinkedIn-Coach aus München?
SKILL_EOF

echo "✅ wb-personal-voice.md"

# ─────────────────────────────────────────────
# SKILL 3: odoo19-wissen
# ─────────────────────────────────────────────
cat > "$SKILLS_DIR/odoo19-wissen.md" << 'SKILL_EOF'
---
name: odoo19-wissen
description: >
  Odoo 19 Enterprise Instanz-Kontext für WISSEN BERATUNG. Enthält Pfade, User, Config,
  DB-Name, Custom-Modul (wb_anpassungen), QWeb-Regeln, Standard-Befehle, Azure OAuth,
  SKR03-Buchhaltung und offene TODOs. Nutzen bei allen Odoo-Fragen.
---

# Odoo 19 Enterprise — WISSEN BERATUNG

## Instanz-Übersicht

| Parameter | Wert |
|---|---|
| **Version** | Odoo 19 Enterprise |
| **Server** | root@s02 (serverdiscounter.com, IP: 185.216.214.34) |
| **Config** | `/etc/odoo19.conf` |
| **Systemd Service** | `odoo19` |
| **Datenbank** | `Main` |
| **DB-User** | `odoo19` |
| **Log** | `/var/log/odoo/odoo19.log` |

---

## Pfade

```
/opt/odoo19/odoo-bin              ← Odoo Binary
/opt/odoo19/addons                ← Core Addons
/opt/odoo19/enterprise            ← Enterprise Addons
/opt/odoo19/custom_addons         ← Custom Module
/opt/odoo19/venv/bin/python3.12   ← Python venv (IMMER verwenden!)
/etc/odoo19.conf                  ← Konfigurationsdatei
/var/log/odoo/odoo19.log          ← Log
```

---

## Standard-Befehle

```bash
# Service
systemctl start|stop|restart|status odoo19

# Log
tail -f /var/log/odoo/odoo19.log

# Modul updaten
sudo -u odoo19 /opt/odoo19/venv/bin/python3.12 /opt/odoo19/odoo-bin \
  -c /etc/odoo19.conf -u wb_anpassungen -d Main --stop-after-init

# Modul erstmalig installieren
sudo -u odoo19 /opt/odoo19/venv/bin/python3.12 /opt/odoo19/odoo-bin \
  -c /etc/odoo19.conf -i wb_anpassungen -d Main --stop-after-init

# Rechte setzen
chown -R odoo19:odoo19 /opt/odoo19/custom_addons/

# Odoo Shell
sudo -u odoo19 /opt/odoo19/venv/bin/python3.12 /opt/odoo19/odoo-bin \
  shell -c /etc/odoo19.conf -d Main
```

> ⚠️ NIEMALS `/opt/odoo19/odoo-bin` direkt — immer mit `venv/bin/python3.12`

---

## Custom Modul: wb_anpassungen

**Pfad:** `/opt/odoo19/custom_addons/wb_anpassungen/`
Nachfolger von `fat_wissen_reporting`. `wb_beleg_designer` wurde verworfen.

| Datei | Inhalt |
|---|---|
| `report_saleorder_headertext.xml` | Dynamischer Einleitungstext via `x_studio_headertext` |
| `sale_report_templates.xml` | Produktname fett + Spaltenbreiten + page-break Hacks |
| `report_invoice_productname.xml` | Produktname fett in Rechnungen |

### QWeb-Regeln
- Hauptvariable heißt **`o`** (nicht `doc` — `doc` → `KeyError: 'doc'`)
- XPath DIN5008: `//div[@name='address_recipient']`
- XPath Produktname Angebot: `sale.report_saleorder_document` / `td_product_name`

---

## PDF-Renderer

Aktuell: **wkhtmltopdf** (mit XPath page-break Hacks)

TODO: Migration auf Chromium headless:
```bash
apt install chromium-browser
# In /etc/odoo19.conf ergänzen:
chrome_bin = /usr/bin/chromium-browser
systemctl restart odoo19
# Danach: XPath page-break Hacks aus sale_report_templates.xml entfernen
```

---

## Azure OAuth

**App-ID:** `ea520a01-c415-4a20-aa34-0dcfd0862afb`
**Redirect URI:** `http://www.wissen-beratung.de/microsoft_outlook/confirm`

Fehler `AADSTS50011` → Redirect URI in Azure App Registration eintragen.

```python
# web.base.url prüfen (Odoo Shell)
env['ir.config_parameter'].get_param('web.base.url')
env['ir.config_parameter'].set_param('web.base.url', 'https://www.wissen-beratung.de')
env.cr.commit()
```

---

## Häufige Fehler

| Fehler | Fix |
|---|---|
| `KeyError: 'doc'` | Alle `doc.` durch `o.` ersetzen |
| `ModuleNotFoundError: passlib` | `venv/bin/python3.12` statt direktem Binary |
| `manifest not found` | `custom_addons` im addons_path prüfen |
| `AADSTS50011` | Redirect URI in Azure App Registration |
| `chown: invalid user: 'odoo:odoo'` | User heißt `odoo19`, nicht `odoo` |

---

## Offene TODOs

- [ ] PDF-Renderer: wkhtmltopdf → Chromium headless
- [ ] AGB-Block aus Studio in `wb_anpassungen` auslagern
- [ ] Vendor Bill Automated Actions (Lastschrift/Kreditkarte)
- [ ] DATEV-Export vollständig konfigurieren
SKILL_EOF

echo "✅ odoo19-wissen.md"

# ─────────────────────────────────────────────
# SKILL 4: branding-guideline
# ─────────────────────────────────────────────
cat > "$SKILLS_DIR/wb-branding-guideline.md" << 'SKILL_EOF'
---
name: wb-branding-guideline
description: >
  WISSEN BERATUNG Brand Identity. Farben, Typografie, Logo-Regeln. Nutzen bei allen
  visuellen Deliverables (Präsentationen, Dokumente, Social Graphics) für WISSEN BERATUNG.
---

# WISSEN BERATUNG — Brand Identity

## Farben

```
Primary (Navy):   #1D3C6E  — Headlines, Logo, Footer-Backgrounds
Secondary (Blue): #1A8BC4  — Icons, Diagramme, Subheadings
Accent (Cyan):    #00C8E8  — CTAs, Links, Highlights
Neutral Light:    #F4F6F9  — Hintergründe
Neutral Dark:     #1A1A2E  — Body Text, Dark Mode
```

## Typografie

```
Headlines:  Montserrat Bold/ExtraBold
Body:       Inter Regular/Medium
Code/UI:    JetBrains Mono Regular
```

## Logo-Dateien (auf dem Server)

| Datei | Verwendung |
|---|---|
| `/mnt/skills/user/branding-guideline/assets/logo-color.png` | Primary — auf weißen/hellen Hintergründen |
| `/mnt/skills/user/branding-guideline/assets/logo-white.png` | Für dunkle/Navy-Hintergründe |
| `/mnt/skills/user/branding-guideline/assets/logo-mono-navy.png` | Einfarbiger Druck |
| `/mnt/skills/user/branding-guideline/assets/logo-icon-only.png` | Favicon, App-Icons, Avatare |

Logo-Seitenverhältnis: 1270×439px (ca. 2.9:1)

## Logo-Regeln

- Nicht strecken, nicht drehen, kein Drop Shadow
- Mindestbreite digital: 120px
- Mindestbreite Print: 30mm
- Auf farbigen Hintergründen: logo-white.png verwenden

## Brand Voice (Kurzfassung)

→ Schmerz vor Lösung · Kurze Sätze · Keine Buzzwords · Augenhöhe
→ Details: wb-brand-voice Skill

## Anwendung in Dokumenten

```python
# pptx
logo_path = "/mnt/skills/user/branding-guideline/assets/logo-color.png"
slide.shapes.add_picture(logo_path, left, top, width=Inches(2.5))
```

```javascript
// docx-js
const logoPath = "/mnt/skills/user/branding-guideline/assets/logo-color.png";
// width: 200, height: 69 (Seitenverhältnis 1270:439)
```
SKILL_EOF

echo "✅ wb-branding-guideline.md"

# ─────────────────────────────────────────────
# Rechte setzen
# ─────────────────────────────────────────────
chown -R 1000:1000 "$SKILLS_DIR"

echo ""
echo "🎉 Alle 4 Skills installiert in: $SKILLS_DIR"
echo ""
ls -la "$SKILLS_DIR/"
