# Weather MOTD Project

## Ce face programul

- Afișează un mesaj personalizat la fiecare login (MOTD - Message of the Day) cu:
  - Numele orașului (din /etc/default/weather)
  - Vremea actuală pentru orașul respectiv
  - Numele hostului și ora curentă
  - Uptime și spațiu liber pe disc
- Loghează fiecare fetch de vreme în /var/log/weather.log
- Scriptul este sigur, suprascrie mereu corect MOTD (nu dublează mesajul) și loghează pasii importanti
## Instalare și configurare

1. Copiază scriptul la locatia corectă și fă-l executabil:
	```bash
	sudo mv gen_motd.sh /usr/local/sbin/weather.sh
	sudo chmod +x /usr/local/sbin/weather.sh
	```

2. Creează fișierul de configurare a orașului:
	```bash
	echo "CITY=Timisoara" | sudo tee /etc/default/weather
	```
3. Creeaza serviciul systemd:
	```bash
	sudo nano /etc/systemd/system/weather.service
	```
	Conținut:
	```
	[Unit]
	Description=Weather MOTD Generator

	[Service]
	Type=oneshot
	RemainAfterExit=yes
	EnvironmentFile=/etc/default/weather
	ExecStart=/usr/local/sbin/weather.sh
	StandardOutput=journal
	StandardError=journal

	[Install]
	WantedBy=multi-user.target
	```
4. Activeaza si porneste serviciul:
	```bash
	sudo systemctl daemon-reload
	sudo systemctl enable weather.service
	sudo systemctl start weather.service
	```

## Verificare

- Statusul serviciului:
  ```bash
  sudo systemctl status weather.service
  ```
  Trebuie să fie `active (exited)`

- Conținutul MOTD:
  ```bash
  cat /etc/motd
  ```

- Logul fetch-urilor de vreme:
  ```bash
  cat /var/log/weather.log
  ```
## Verificare

- Statusul serviciului:
  ```bash
  sudo systemctl status weather.service
  ```
  Trebuie să fie `active (exited)`

- Conținutul MOTD:
  ```bash
  cat /etc/motd
  ```

- Logul fetch-urilor de vreme:
  ```bash
  cat /var/log/weather.log
  ```

## Exemplu de output MOTD

```
========================================
 Welcome and good weather
========================================
City: Glimboca
Weather: 🌦   +25°C
Hostname: ip-172-31-21-186.eu-north-1.compute.internal
Time: 2025-08-19 11:21:02
Uptime: up 2 hours, 50 minutes
Disk free: 98G free of 100G
========================================
```

## Modificare orasului

1. Editează `/etc/default/weather` și schimbă valoarea CITY.
2. Repornește serviciul:
	```bash
	sudo systemctl restart weather.service
	```
3. Verifica MOTD din nou:
	```bash
	cat /etc/motd
	```
~
