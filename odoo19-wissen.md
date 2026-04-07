---
name: odoo19-wissen
description: >
  Odoo 19 Enterprise Skill für WISSEN BERATUNG. Enthält alle konkreten Infos zur Instanz (Pfade, User, Config, DB, Module) — kein Nachfragen nötig. Verwende diesen Skill bei ALLEN Odoo-Fragen: Custom-Modul-Entwicklung (wb_anpassungen, QWeb, XML, Python), Admin & Konfiguration (Automated Actions, Workflows, Einstellungen), Buchhaltung (SKR03, DATEV, Vendor Bills, Journale), Infrastruktur (Systemd, Logs, Upgrades, PDF-Renderer). Triggern bei: "odoo", "wb_anpassungen", "QWeb", "Rechnung", "Vendor Bill", "Kontenplan", "Journal", "Automated Action", "PDF drucken", "Chromium", "wkhtmltopdf", "DIN5008", "systemctl odoo19", oder jeder Frage die sich auf die Odoo-Instanz bezieht.
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
/opt/odoo19/custom_addons         ← Custom Module (wb_anpassungen etc.)
/opt/odoo19/venv/bin/python3.12   ← Python venv (IMMER verwenden!)
/etc/odoo19.conf                  ← Konfigurationsdatei
/var/log/odoo/odoo19.log          ← Log
```

**addons_path in odoo19.conf:**
```ini
addons_path = /opt/odoo19/addons,/opt/odoo19/enterprise,/opt/odoo19/custom_addons
```

---

## Standard-Befehle

```bash
# Service starten/stoppen/neustarten
systemctl start odoo19
systemctl stop odoo19
systemctl restart odoo19
systemctl status odoo19

# Log live verfolgen
tail -f /var/log/odoo/odoo19.log

# Modul installieren / updaten
sudo -u odoo19 /opt/odoo19/venv/bin/python3.12 /opt/odoo19/odoo-bin \
  -c /etc/odoo19.conf \
  -u wb_anpassungen \
  -d Main \
  --stop-after-init

# Modul erstmalig installieren (-i statt -u)
sudo -u odoo19 /opt/odoo19/venv/bin/python3.12 /opt/odoo19/odoo-bin \
  -c /etc/odoo19.conf \
  -i wb_anpassungen \
  -d Main \
  --stop-after-init

# Rechte setzen nach Dateiänderungen
chown -R odoo19:odoo19 /opt/odoo19/custom_addons/

# Odoo Shell öffnen
sudo -u odoo19 /opt/odoo19/venv/bin/python3.12 /opt/odoo19/odoo-bin \
  shell -c /etc/odoo19.conf -d Main
```

> ⚠️ **WICHTIG:** Niemals `/opt/odoo19/odoo-bin` direkt aufrufen — immer mit `venv/bin/python3.12`, sonst `ModuleNotFoundError: No module named 'passlib'`

---

## Custom Modul: wb_anpassungen

**Pfad:** `/opt/odoo19/custom_addons/wb_anpassungen/`

Dieses Modul ist die zentrale Anlaufstelle für alle Odoo-Anpassungen bei WISSEN BERATUNG. Es ist der umgebaute und umbenannte Nachfolger von `fat_wissen_reporting`. `wb_beleg_designer` wurde separat verworfen und existiert nicht mehr.

### Aktuelle Inhalte (Stand bekannt)

| Datei | Inhalt |
|---|---|
| `report_saleorder_headertext.xml` | Dynamischer Einleitungstext via `x_studio_headertext` (XPath auf DIN5008 Layout, nur bei Angeboten) |
| `sale_report_templates.xml` | Produktname fett + Beschreibung getrennt + Spaltenbreiten + page-break Hacks |
| `report_invoice_productname.xml` | Produktname fett in Rechnungen |

### Modul-Struktur Vorlage

```
wb_anpassungen/
├── __manifest__.py
├── __init__.py
└── views/
    ├── report_saleorder_headertext.xml
    ├── sale_report_templates.xml
    └── report_invoice_productname.xml
```

### QWeb-Regeln

- Hauptvariable heißt `o` (nicht `doc` — `doc` führt zu `KeyError: 'doc'`)
- XPath auf DIN5008: `//div[@name='address_recipient']` oder `l10n_din5008.external_layout_din5008`
- XPath für Produktname Angebot: `sale.report_saleorder_document` / `td_product_name`
- XPath für Produktname Rechnung: `account.report_invoice_document` / `account_invoice_line_name`

---

## PDF-Renderer

### Aktueller Stand: wkhtmltopdf (mit Workarounds)
`sale_report_templates.xml` enthält XPath page-break Hacks weil wkhtmltopdf Tabellenzeilen nicht korrekt über Seitenumbrüche bricht.

### TODO: Migration auf Chromium headless

```bash
# 1. Chromium installieren
apt install chromium-browser

# 2. Pfad prüfen
which chromium-browser

# 3. In /etc/odoo19.conf ergänzen
chrome_bin = /usr/bin/chromium-browser

# 4. Neustart
systemctl restart odoo19

# 5. Nach erfolgreichem Test: XPath page-break Hacks aus
#    sale_report_templates.xml entfernen
```

---

## Buchhaltung / SKR03

- **Kontenplan:** SKR03
- **Eröffnungsbilanz Bankkonto:** Konto 1201
- **Zahlungsanbieter:** Stripe (integriert, Token-basierte Abbuchung konfigurierbar)
- **DATEV-Export:** geplant / in Konfiguration

### Vendor Bill Workflows (Automated Actions)
Offenes TODO: Automatisierung der Lieferantenrechnungs-Bezahlung via Lastschrift/Kreditkarte über Odoo Automated Actions.

---

## Azure OAuth / Fetchmail

**App-ID:** `ea520a01-c415-4a20-aa34-0dcfd0862afb`

**Redirect URI (muss in Azure eingetragen sein):**
```
http://www.wissen-beratung.de/microsoft_outlook/confirm
```

**Postfächer (Fetchmail):** Sales, Support, Invoice, Purchase

**Häufiger Fehler:**
```
AADSTS50011: The redirect URI does not match
```
→ Fix: Azure Portal → App Registrations → App `ea520a01-...` → Authentication → Redirect URI eintragen

**web.base.url prüfen:**
```python
# In Odoo Shell
env['ir.config_parameter'].get_param('web.base.url')
env['ir.config_parameter'].set_param('web.base.url', 'https://www.wissen-beratung.de')
env.cr.commit()
```

---

## DIN5008 Layout

Odoo 19 nutzt `l10n_din5008` als Basis-Layout für alle Belege.
- Template: `l10n_din5008.external_layout_din5008`
- AGB-Block liegt aktuell noch im Studio-Template (TODO: in `wb_anpassungen` auslagern für Updatefestigkeit)

---

## Häufige Fehler & Fixes

| Fehler | Ursache | Fix |
|---|---|---|
| `KeyError: 'doc'` in QWeb | Variable heißt `o`, nicht `doc` | Alle `doc.` durch `o.` ersetzen |
| `ModuleNotFoundError: passlib` | Python-Binary statt venv genutzt | `venv/bin/python3.12` verwenden |
| `manifest not found` für Custom-Modul | `custom_addons` fehlt im addons_path | `/etc/odoo19.conf` prüfen + `-c` Flag beim Start |
| Azure `AADSTS50011` | Redirect URI nicht in Azure eingetragen | URI in App Registration hinzufügen |
| `computed signature != provided signature` | Bank-Sync auf mehreren DB-Instanzen aktiv | Doppelte Verbindungen in Buchhaltung → Online Synchronization löschen |
| `chown: invalid user: 'odoo:odoo'` | User heißt `odoo19`, nicht `odoo` | `chown -R odoo19:odoo19 ...` |

---

## Offene TODOs

- [ ] PDF-Renderer von wkhtmltopdf auf Chromium headless migrieren
- [ ] AGB-Block aus Studio in `wb_anpassungen` auslagern
- [ ] Vendor Bill Automated Actions (Lastschrift/Kreditkarte)
- [ ] DATEV-Export vollständig konfigurieren
