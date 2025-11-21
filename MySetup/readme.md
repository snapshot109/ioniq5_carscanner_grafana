### My Setup

Hier eine kurze Beschreibung zu meinem konkreten Setup, das Kontext und zusätzliche Hilfe bieten soll

### Autos

Ich nutze die beschriebene Lösung in 2 Autos: einem Ioniq 5 MY22 und einem MY25. Das modelyear 25 hat in Carscanner andere Sensoren und da der komplett neu für mich ist, werden ich wohl nochmal an die Telegraf.conf ran müssen, um die Daten in diesselben Felder zu schreiben, wie beim MY22. Ob beim 25er auch alle Sensoren so vorhanden sind, werde ich sehen

### Disclaimer

Ich bin kein Developer. Die hier beschriebene Lösung war nur mit Unterstützung von Tools wie ChatGPT, Claude, Gemini möglich. Für Verbesserungen/ Fehlerkorrekturen gerne über Issues/ Pull-Requests Feedback geben. Dies ist aber auch ein "hatte-gerade-mal-Zeit-dafür" Projekt. D.h. ob ich es dauerhaft maintaine werde ich sehen

### Carscanner

* Carscanner wird bei mir von einem Android-Modus automatisch gestartet, wenn sich mein Handy per Bluetooth mit dem Auto verbindet
* In Carscanner habe ich 2 Fahrzeuge angelegt, beide mit eigenem OBD Dongle
* Im OBD Dongle des Hauptfahrzeugs ist "automatisch verbinden" und "Dashboard anzeigen" aktiv, so dass ich nichts tun muss, um Carscanner zu starten
* Datenaufzeichnung in Carscanner ist aktiv
* Nach einer Fahrt (oder irgendwann wenn ich Zeit habe), exportiere ich die CSVs der Fahrtaufzeichnung ("CSV #2" in Carscanner Export) aus der App und speichere sie direkt auf mein Synology NAS (via DS File App von Synology)
* Mein Carscanner Dash sieht wie folgt aus:

![Demo Screenshot meine Carscanner Dashboard](/assets/images/Carscanner_Dash.jpg)

* Das Dashboard enthält vor allem so viele Daten, damit in der Aufzeichnung alles vorhanden ist, was ich am Ende auswerten will
* Dieses Dashboard ergibt ein CSV File mit diesen Daten

```
[ADAS] Front left wheel speed (High res.) (km/h)
[ADAS] Front right wheel speed (High res.) (km/h)
[ADAS] Lateral acceleration (m/s²)
[ADAS] Longitudinal acceleration (m/s²)
[ADAS] Rear left wheel speed (High res.) (km/h)
[ADAS] Rear right wheel speed (High res.) (km/h)
[ADAS] Steering angle (°)
[ADAS] Yaw rate (°/s)
[BMS] Airbag H/wire Duty ()
[BMS] Auxillary Battery Voltage (V)
[BMS] Available Charge Power (kW)
[BMS] Available Discharge Power (kW)
[BMS] Battery Cell Voltage Deviation (V)
[BMS] Battery Current (A)
[BMS] Battery DC Voltage (V)
[BMS] Battery Fan Duty Feedback (%)
[BMS] Battery Fan Feedback (Hz)
[BMS] Battery Fan Status ()
[BMS] Battery Heater 1 Temperature (℃)
[BMS] Battery Inlet Temperature (℃)
[BMS] Battery management ()
[BMS] Battery Max Temperature (℃)
[BMS] Battery Min Temperature (℃)
[BMS] Battery Pack B01 (℃)
[BMS] Battery Pack B02 (℃)
[BMS] Battery Pack B03 (℃)
[BMS] Battery Pack B04 (℃)
[BMS] Battery Pack B05 (℃)
[BMS] Battery Pack B06 (℃)
[BMS] Battery Pack B07 (℃)
[BMS] Battery Pack B08 (℃)
[BMS] Battery Pack B09 (℃)
[BMS] Battery Pack B10 (℃)
[BMS] Battery Pack B11 (℃)
[BMS] Battery Pack B12 (℃)
[BMS] Battery Pack B13 (℃)
[BMS] Battery Pack B14 (℃)
[BMS] Battery Pack B15 (℃)
[BMS] Battery Pack B16 (℃)
[BMS] Battery Power (kW)
[BMS] Battery temperature at WCS input (℃)
[BMS] Battery temperature PRA (℃)
[BMS] Battery work time total (h) (h)
[BMS] Battery work time total (sec.) (sec.)
[BMS] BMS Ignition ()
[BMS] BMS Main Relay ()
[BMS] CALC Average Cell Voltage 58kWh (V)
[BMS] CALC Average Cell Voltage 72kWh (V)
[BMS] CALC Average Cell Voltage 77kWh (V)
[BMS] CALC Estimated time 100kW 80% Charge (min)
[BMS] CALC Estimated time 11kW 80% Charge (h)
[BMS] CALC Estimated time 150kW 80% Charge (min)
[BMS] CALC Estimated time 175kW 80% Charge (min)
[BMS] CALC Estimated time 2.3kW 80% Charge (Hours)
[BMS] CALC Estimated time 3.7kW 80% Charge (Hours)
[BMS] CALC Estimated time 350kW 80% Charge (min)
[BMS] CALC Estimated time 50kW 80% Charge (min)
[BMS] CALC Estimated time 7.4kW 80% Charge (Hours)
[BMS] Coolant temperature 2 (℃)
[BMS] Cumulative Charge Current (Ah)
[BMS] Cumulative Discharge Current (Ah)
[BMS] Cumulative Energy Charged (kWh)
[BMS] Cumulative Energy Discharged (kWh)
[BMS] DATC A/C Compressor operation RPM var.1 (rpm)
[BMS] Drive Motor Speed 1 (rpm)
[BMS] Drive Motor Speed 2 (rpm)
[BMS] HV_Charging ()
[BMS] Inverter Capacitor Voltage (V)
[BMS] Isolation Resistance (kOhm)
[BMS] Maximum Cell Voltage (V)
[BMS] Maximum Cell Voltage No ()
[BMS] Maximum Deterioration Cell No ()
[BMS] Minimum Cell Voltage (V)
[BMS] Minimum Cell Voltage No ()
[BMS] Minimum Deterioration (%)
[BMS] Minimum Deterioration Cell No ()
[BMS] Normal Charge Port ()
[BMS] Operating Time (Hours)
[BMS] Rapid Charge Port ()
[BMS] Remaining energy (Wh)
[BMS] State of Charge BMS (%)
[BMS] State of Charge Display (%)
[BMS] State of Health (%)
[DASH] Odometer (km)
[DASH/2025] Odometer ()
[HVAC] Evaporator Temperature (℃)
[HVAC] Humidity sensor for automatic defogger (%)
[HVAC] Indoor Temperature (℃)
[HVAC] Interior temperature: driver legs vent (℃)
[HVAC] Interior temperature: driver vent (℃)
[HVAC] Interior temperature: front (℃)
[HVAC] Outdoor Temperature (℃)
[HVAC] Outside temperature (℃)
[HVAC] Real Vehicle Speed (km/h)
[ICCU] Aux. Battery Current (A)
[ICCU] Aux. Battery State of Charge (%)
[ICCU] Aux. Battery Temperature (℃)
[ICCU] Aux. Battery Voltage (V)
[ICCU] LDC Input Voltage (V)
[ICCU] LDC Output Current (A)
[ICCU] LDC Output Voltage (V)
[ICCU] LDC Temperature (℃)
[MCU] EOP Actual Speed (rpm)
[MCU] EOP Commanded Speed (rpm)
[MCU] EOP Current DC (A)
[MCU] EOP Current IQ (A)
[MCU] EOP Torque (N⋅m)
[MCU] EWP Actual Rotation Speed (rpm)
[MCU] EWP Commanded Rotation Speed (rpm)
[MCU] EWP Current DC (A)
[MCU] EWP Voltage DC (V)
[MCU] Heat sink temperature (℃)
[MCU] IGN Voltage (V)
[MCU] Inverter temperature (℃)
[MCU] Motor Actual Torque (N⋅m)
[MCU] Motor phase current (rms) (A)
[MCU] Motor RPM (rpm)
[MCU] Motor temperature (℃)
[MCU] Nominal torque value (N⋅m)
[MCU/2025] Motor temperature (℃)
[VCMS] AC Charging state ()
[VCMS] Aux. battery voltage (V)
[VCMS] DC Charging state ()
[VCMS] Estimated charging power (W)
[VCMS] OBC Charging AC Current (A)
[VCMS] OBC Charging AC Voltage (V)
[VCMS] OBC Charging DC Current (A)
[VCMS] OBC Charging DC Voltage (V)
[VCMS] OBC Discharging AC Current (A)
[VCMS] OBC Discharging DC Current (A)
Brake light ()
Durchschnittsgeschwindigkeit (km/h)
Durchschnittsgeschwindigkeit (GPS) (km/h)
Energiekosten (€)
EV Instant Energy Consumption (kWh) (kWh)
EV Momentaner Energieverbrauch (kWh/distance) (kWh/100km)
Fahrzeugbeschleunigung (m/s²)
Geschwindigkeit (GPS) (km/h)
Höhe (GPS) (m)
Leistung der Hochvolt-Batterie des Elektrofahrzeugs (kW)
Momentaner Energieverbrauch (distance/kWh) (km/kWh)
Potential energy (over sea level) 2000 kg car (Vehicle options: enable 'show GPS speed') (kWh)
Verbrauchte Energie (kWh)
zurückgelegte Strecke (km)
zurückgelegte Strecke (gesamt) (km)
Latitude
Longtitude
```

### Telegraf

* Die Telegraf Konfig ist so aufgebaut, dass sie damit umgehen kann, auch Felder geliefert zu bekommen, die hier nicht oben stehen.
* Alle in der CSV enthaltenen Felder werden ausnahmslos als "Float" in die InfluxDB importiert
* Dazu werden auch alle Daten durch einen Sanitizer gejagt, der dafür sorgt, dass keine Daten enthalten sind, dich nicht zu "Float" passen
* Meine in diesem Repo enthaltene telegraf.conf berücksichtigt, dass es 2 Fahrzeuge gibt und tagged die Datensätze entsprechend
* Ausserdem lege ich die CSV Exporte in unterschiedlichen Verzeichnissen ab (für MY22 und MY25), damit die korrekt getagged werden können
* Wahrscheinlich könnte man sinnvoll noch mehr taggen, damit habe ich mich aber noch nicht beschäftigt

### Shell-Skripte

* Ich habe Arbeitsverzeichnisse mit "new"/ "processing" & "done" für die CSV Files. 
* Der Gedanke dahinter ist, alle neuen Files in "New" zu legen. 
* Mit einem Script (bzw. 2) werden die dann für Telegraf in "processing" verschoben (und das Dateidatum aktualisiert). 
* Files, die älter als 10 Minuten sind, werden von diesem Skript nach "done" verschoben, damit Telegraf diese nicht ständig prüfen muss
* Man könnte verarbeitete Files auch löschen, ich habe mich dazu entschieden, sie zu behalten, was die Möglichkeit eröffnet, das Setup nochmal komplett aufzubauen und alles neu einzulesen (was beim Aufbauen mehrfach nötig war)


### Grafana

* Hauptintention des ganzen Setup war, den Akku des Autos über eine Zeit lang genauer im Auge zu behalten
* Alle hier enthaltenen Queries gehen davon aus, dass o.g. Daten vorhanden sind
* Die meisten auf dem Dashboard angezeigten Daten sind eher "nebenbei" entstanden, da die Daten vorhanden waren
* Sämtliche Flux Queries sind mit KI Hilfe entstanden. Da ich kein Entwickler bin, kann ich hier nicht wirklich Support geben
