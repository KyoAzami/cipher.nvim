#!/bin/bash

# ---- Language Detection Logic ----
# Check if the system language starts with "es" (Spanish)
if [[ "$LANG" == es* ]]; then
    MSG_DETECT="🔍 Detectando distribución de Linux..."
    MSG_NO_OS="❌ No se pudo detectar el sistema operativo (falta /etc/os-release)."
    MSG_ARCH="🟢 Sistema basado en Arch Linux detectado (Pacman)."
    MSG_DEBIAN="🟠 Sistema basado en Debian/Ubuntu detectado (APT)."
    MSG_FEDORA="🔵 Sistema basado en Fedora/RHEL detectado (DNF)."
    MSG_SUSE="🟢 Sistema basado en openSUSE detectado (Zypper)."
    MSG_UNSUPPORTED="⚠️ Distribución no soportada automáticamente por este script:"
    MSG_MANUAL="Por favor, instala manualmente con tu gestor de paquetes: nodejs, npm, python, pip, unzip, wget, curl, gzip, tar"
    MSG_SUCCESS="✅ ¡Todas las dependencias para Mason (Neovim) se han instalado correctamente!"
else
    # Default to English
    MSG_DETECT="🔍 Detecting Linux distribution..."
    MSG_NO_OS="❌ Could not detect the operating system (missing /etc/os-release)."
    MSG_ARCH="🟢 Arch Linux based system detected (Pacman)."
    MSG_DEBIAN="🟠 Debian/Ubuntu based system detected (APT)."
    MSG_FEDORA="🔵 Fedora/RHEL based system detected (DNF)."
    MSG_SUSE="🟢 openSUSE based system detected (Zypper)."
    MSG_UNSUPPORTED="⚠️ Distribution not automatically supported by this script:"
    MSG_MANUAL="Please install manually using your package manager: nodejs, npm, python, pip, unzip, wget, curl, gzip, tar"
    MSG_SUCCESS="✅ All dependencies for Mason (Neovim) have been successfully installed!"
fi

echo "$MSG_DETECT"

# ---- OS Information Extraction ----
# Check if the os-release file exists
if [ -f /etc/os-release ]; then
    # Source the file to access its variables
    . /etc/os-release
    OS=$ID
    OS_LIKE=$ID_LIKE
else
    echo "$MSG_NO_OS"
    exit 1
fi

# ---- Package Manager Installation Functions ----

install_pacman() {
    echo "$MSG_ARCH"
    sudo pacman -Sy --noconfirm nodejs npm python python-pip unzip wget curl gzip tar
}

install_apt() {
    echo "$MSG_DEBIAN"
    sudo apt update
    sudo apt install -y nodejs npm python3 python3-pip unzip wget curl gzip tar
}

install_dnf() {
    echo "$MSG_FEDORA"
    sudo dnf install -y nodejs npm python3 python3-pip unzip wget curl gzip tar
}

install_zypper() {
    echo "$MSG_SUSE"
    sudo zypper refresh
    sudo zypper install -y nodejs npm python3 python3-pip unzip wget curl gzip tar
}

# ---- Distribution Detection & Execution ----

# Check for Arch or derivatives (CachyOS, EndeavourOS, Manjaro, etc.)
if [[ "$OS" == "arch" || "$OS_LIKE" == *"arch"* ]]; then
    install_pacman

# Check for Debian, Ubuntu or derivatives (Mint, Pop!_OS, etc.)
elif [[ "$OS" == "ubuntu" || "$OS" == "debian" || "$OS_LIKE" == *"ubuntu"* || "$OS_LIKE" == *"debian"* ]]; then
    install_apt

# Check for Fedora or RHEL derivatives
elif [[ "$OS" == "fedora" || "$OS_LIKE" == *"fedora"* || "$OS_LIKE" == *"rhel"* ]]; then
    install_dnf

# Check for openSUSE
elif [[ "$OS" == "opensuse"* || "$OS_LIKE" == *"suse"* ]]; then
    install_zypper

else
    # Unsupported distribution fallback
    echo "$MSG_UNSUPPORTED $OS"
    echo "$MSG_MANUAL"
    exit 1
fi

echo "$MSG_SUCCESS"
