# 🕷️ SpiderRecon

**SpiderRecon** is an automated reconnaissance framework for web applications and infrastructure, built with **Bash + Python**, focused on simplicity, automation, and intelligent analysis.

---

## 🚀 Features

* 🔍 Automatic port scanning (**Nmap**)
* 🌐 Technology detection (**WhatWeb**)
* 📂 Directory enumeration (**Gobuster**)
* ⚠️ Basic vulnerability scanning (**Nikto**)
* 🌍 DNS + Whois information gathering
* 🧠 Intelligent analysis (port interpretation)
* 📄 Report generation (`report.md`)
* ⚡ Parallel execution (fast scanning)
* 🔧 Auto-installation of dependencies (first run)

---

## 📂 Project Structure

```id="ybcmql"
SpiderRecon/
├── spiderrecon.sh
├── demo.gif
├── modules/
│   ├── scan.sh
│   ├── parser.py
│   ├── intel.py
│   └── report.py
├── results/
```

---

## ⚙️ Installation

Clone the repository:

```bash id="k4u6cc"
git clone https://github.com/your-username/SpiderRecon.git
cd SpiderRecon
```

Make scripts executable:

```bash id="mrn1d4"
chmod +x spiderrecon.sh
chmod +x modules/scan.sh
```

---

## ▶️ Usage

Start SpiderRecon:

```bash id="7w91l9"
./spiderrecon.sh
```

Inside the interactive CLI:

```bash id="5b6bbh"
spiderrecon> -t target.com -i -e
```

---

## 🧠 Options

| Flag | Description                 |
| ---- | --------------------------- |
| `-t` | Define target               |
| `-i` | Enable intelligent analysis |
| `-e` | Extra enumeration           |

---

## 📊 Output

Results are saved in:

```id="ozv8k5"
results/<target>/
```

Example:

```id="u5ec7k"
results/example.com/
├── ports.txt
├── ports.json
├── web.txt
├── dirs.txt
├── vulns.txt
├── dns.txt
├── headers.txt
├── report.md
```

---

## 🧠 Intelligence Engine

SpiderRecon automatically interprets results:

* Port **22** → SSH (possible brute force)
* Port **80** → Web attack surface
* Port **443** → SSL/TLS analysis
* Port **3306** → Exposed database ⚠️

---

## ⚠️ Legal Disclaimer

This project is intended **for educational and authorized testing purposes only**.

❌ Do not use on unauthorized systems
✔️ Use on labs, local environments, or systems you own

---

## 🧪 Recommended Environments

* Hack The Box
* TryHackMe
* DVWA (local)

---

## 🛠️ Technologies

* Bash
* Python 3
* Nmap
* Gobuster
* Nikto
* WhatWeb

---

## 🚀 Roadmap

* [ ] Subdomain enumeration
* [ ] Smart wordlist generator
* [ ] Web dashboard
* [ ] Stealth mode
* [ ] Plugin system

---

## 👨‍💻 Author

Developed by **rkz**

---

## ⭐ Contributing

Pull requests are welcome!
Feel free to improve the project.

---

## 📜 License

MIT License
