#!/bin/bash

# ===== INSTALL SYSTEM =====
INSTALL_FLAG=".installed"

install_tools() {
echo "[+] First run detected. Installing dependencies..."

sudo apt update

TOOLS=(
    nmap
    whois
    dnsutils
    curl
    nikto
    gobuster
    whatweb
)

for tool in "${TOOLS[@]}"; do
    if ! command -v "$tool" >/dev/null 2>&1; then
        echo "[+] Installing $tool..."
        sudo apt install -y "$tool"
    else
        echo "[i] $tool already installed"
    fi
done

touch $INSTALL_FLAG
echo "[+] Setup complete"
}

if [[ ! -f $INSTALL_FLAG ]]; then
    install_tools
fi

# ===== COLORS =====
RED="\033[1;31m"
GREEN="\033[1;32m"
NC="\033[0m"

# ===== BANNER =====
banner() {
clear
echo -e "${RED}"

cat << "EOF"

                            _____
                              |         
                       J      |                    
                       J      |       >           
                        p    Iw0r     J           
                        J   u/z/Ll   o            
                         0  ff/Luw   h            
                   C      J r1100z  J             
                      J    khf/rrpk     f         
                          C(*hha  ?W\X            
                           JqodoJ                 
                         w'w O' C)m               
                       m* m  }   m 0m             
                     QC  m        Z  Ca           
                    C^  0          u  zC          
                  }-    h           '   8W        
                &      C            C      C.     
                      J              J            

       ____        _     _           ____                      
      / ___| _ __ (_) __| | ___ _ __|  _ \ ___  ___ ___  _ __  
      \___ \| '_ \| |/ _` |/ _ \ '__| |_) / _ \/ __/ _ \| '_ \ 
       ___) | |_) | | (_| |  __/ |  |  _ <  __/ (_| (_) | | | |
      |____/| .__/|_|\__,_|\___|_|  |_| \_\___|\___\___/|_| |_|
            |_|                                                

EOF

echo -e "${NC}"
echo -e "${GREEN}SpiderRecon ( For CyberSecurity )${NC}"
echo ""
}

# ===== HELP =====
help_menu() {
echo ""
echo "Usage:"
echo " -t <target> [-i] [-e]"
echo ""
echo "Options:"
echo " -t target     define target"
echo " -i            run intelligence"
echo " -e            extra enumeration"
echo ""
echo "Example:"
echo " spiderrecon> -t alvo.com -i -e"
echo ""
}

# ===== PIPELINE =====
run_pipeline() {
TARGET=$1
INTEL=$2
ENUM=$3

OUTPUT="results/$TARGET"
mkdir -p "$OUTPUT"

echo "[+] Target: $TARGET"

if curl -s --head http://$TARGET | grep "200 OK" > /dev/null; then
    URL="http://$TARGET"
else
    URL="https://$TARGET"
fi

bash modules/scan.sh "$TARGET" "$URL" "$OUTPUT"
python3 modules/parser.py "$TARGET" "$OUTPUT"

if $ENUM; then
    echo "[+] Extra enumeration..."
    gobuster dir -u "$URL" -w /usr/share/wordlists/dirb/common.txt -o "$OUTPUT/extra.txt"
fi

if $INTEL; then
    python3 modules/intel.py "$OUTPUT"
fi

python3 modules/report.py "$OUTPUT"

echo "[+] Done"
}

# ===== START =====
banner

while true; do
read -rp "spiderrecon> " -a args

TARGET=""
INTEL=false
ENUM=false

for ((i=0; i<${#args[@]}; i++)); do
    case "${args[$i]}" in
        -t)
            TARGET="${args[$i+1]}"
            ((i++))
            ;;
        -i)
            INTEL=true
            ;;
        -e)
            ENUM=true
            ;;
        --help)
            help_menu
            continue 2
            ;;
        exit)
            echo "Bye 🕷"
            exit 0
            ;;
    esac
done

if [[ -z "$TARGET" ]]; then
    echo "Usage: -t <target> [-i] [-e]"
    continue
fi

run_pipeline "$TARGET" "$INTEL" "$ENUM"

done
