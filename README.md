# CarScanner → InfluxDB → Grafana  
### Fahrzeugtelemetrie mit Synology NAS & Docker

Dieses Projekt zeigt, wie man Fahrzeugdaten aus der **CarScanner-App** auf einer **Synology NAS** verarbeitet und in **Grafana** visualisiert.  
Das Setup basiert auf **Docker + Telegraf + InfluxDB + Grafana** und läuft komplett lokal.

Ideal für:
- EV-Datenanalyse  
- Energieverbrauch & Ladeverhalten  
- Batterietemperaturen & Zell-Spread  
- Trip-Auswertungen  
- Historische Datenvisualisierung  

---

## 🚀 Architekturüberblick

```
CarScanner (CSV)
↓
Synology NAS
 └── Docker
 ├── InfluxDB 2.x → Speicherung
 ├── Telegraf → CSV-Import & Parsing
 └── Grafana → Dashboards
```

---

## 📦 Voraussetzungen

- Synology NAS mit Docker-Unterstützung (z. B. DS218+, DS920+, …)
- Docker installiert
- CarScanner App + OBD-Dongle
- Grundkenntnisse in Synology File Station & Docker GUI

---

## 📁 Ordnerstruktur

Auf der NAS folgende Verzeichnisse erstellen:

```
/volume1/docker/influxdb/
/data
/config

/volume1/docker/telegraf/
/config
/obd_logs

/volume1/docker/grafana/
/data
```

**Tipp:** Deinem NAS-Benutzer Lese-/Schreibrechte geben.

---

## 🗄️ InfluxDB einrichten

1. Im Synology Docker „InfluxDB 2“ Image laden  
2. Container erstellen

### Volumes:
```
/volume1/docker/influxdb/data → /var/lib/influxdb2
/volume1/docker/influxdb/config → /etc/influxdb2
```

### Port:
8086:8086

### Setup:
Danach im Browser öffnen:

```
http://<NAS-IP>:8086
```

- Admin-User erstellen
- Organisation anlegen
- Bucket anlegen, z. B. `carscanner_tagged`
- API Token erzeugen

---

## 📊 Grafana installieren

1. "Grafana" Docker-Image laden  
2. Container starten

### Volumes:
```
/volume1/docker/grafana/data → /var/lib/grafana
```

### Port:
3000:3000

### Setup:
Im Browser öffnen:
```
http://<NAS-IP>:3000
```
Login: `admin / admin`

InfluxDB als Datenquelle hinzufügen (Flux-Modus):

- URL: `http://influxdb:8086` (oder NAS-IP)
- Org: Deine Organisation
- Token: Dein Token
- Default Bucket: `carscanner_tagged`

---

## 🔧 Telegraf konfigurieren

Telegraf übernimmt den Import der CarScanner-CSV-Dateien.

1. "telegraf:latest" Docker-Image laden  
2. Container erstellen (**noch nicht starten**)  
3. Config unter:

```
/volume1/docker/telegraf/config/telegraf.conf
```

### Beispiel-Konfiguration:

```toml
[agent]
  interval = "1s"

[[inputs.file]]
  files = ["/obd_logs/*.csv"]
  data_format = "csv"
  csv_header_row_count = 1
  csv_timestamp_column = "time"
  csv_timestamp_format = "2006-01-02T15:04:05Z07:00"

[[processors.starlark]]
  namepass = ["carscanner"]
  source = '''
# Hier könnte ein Sanitizer stehen,
# um Feldnamen zu vereinheitlichen usw.

[[outputs.influxdb_v2]]
  urls = ["http://influxdb:8086"]
  token = "<DEIN TOKEN>"
  organization = "<DEINE ORG>"
  bucket = "carscanner_tagged"
```

**Tipp:** Eine funktionierende Konfiguration mit Sanitizer s. telegraf.conf in diesem Repo

---

### 📥 CSV-Import

CarScanner-Fahrtaufzeichnungen als .csv exportieren (CSV #2 in Carscanner)
Diese Dateien kopierst du in:

```
/volume1/docker/telegraf/obd_logs/
```

Telegraf erkennt neue Dateien automatisch und schreibt sie in InfluxDB.

Optional:
Ein „new → processing → done“-Workflow kann per Shell-Skript ergänzt werden.

**Tipp:** 2 funktionierende Shell-Skripte im Verzeichnis "Scripts" -> in diesem Fall 2 Scripte zur Erfassung von 2 verschiedenen Fahrzeugen

---

### 📈 Grafana Dashboards

Beispielhafte Panels:
* Akkutemperaturen (Min/Max/Spread)
* Verbrauch (kWh/100 km)
* Verlauf über die letzten 600 km
* Ladeleistung vs. SoC
* Trip-basierte Analysen
* Beschleunigung, Motorleistung, HVAC-Einfluss

Grafana nutzt dafür Flux Queries wie:

```
from(bucket: "carscanner_tagged")
  |> range(start: v.timeRangeStart, stop: v.timeRangeStop)
  |> filter(fn: (r) => r._field == "[BMS] State of Charge Display (%)")
```

**Tipp:** Ein Funktionierendes Dashboard findest Du unter "grafana", sowie querys für panels

---

### 🧰 Erweiterungen

* Starlark-Sanitizer für saubere Feldnamen
* Autotagging (car, ownership, trip)
* Wetterdaten einbinden

---

### Details zu meinem Setup

* s. readme im Ordner "MySetup"

--- 

### 🤝 Mitmachen & Feedback

* Fragen, Ideen oder Verbesserungsvorschläge?
* Issues & Pull Requests sind willkommen!

---

### 📜 Lizenz

The Unlicense

