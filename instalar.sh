#!/bin/bash
# Instala (o actualiza) Limón 🍋🐱
#
# Uso (pegar en Terminal):
#   curl -fsSL https://raw.githubusercontent.com/Diiegoo-15/limon-descarga/main/instalar.sh | bash
#
# Al descargarlo desde Terminal, macOS no le pone la marca de "descargado de
# internet", así que Limón se abre directamente sin avisos de seguridad.
set -e

URL="https://github.com/Diiegoo-15/limon-descarga/releases/download/limon/Limon.zip"

echo ""
echo "  🐱  Llamando a Limón..."
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

if ! curl -fsSL "$URL" -o "$TMP/Limon.zip"; then
    echo "  😿  No he podido descargar a Limón. ¿Hay internet? Prueba otra vez en un ratito."
    exit 1
fi

# Si ya estaba abierto (actualización), lo cerramos un momento.
pkill -x Limon >/dev/null 2>&1 || true
sleep 1

DEST="/Applications"
if [ ! -w "$DEST" ]; then
    DEST="$HOME/Applications"
    mkdir -p "$DEST"
fi

rm -rf "$DEST/Limon.app"
ditto -x -k "$TMP/Limon.zip" "$DEST"
xattr -dr com.apple.quarantine "$DEST/Limon.app" >/dev/null 2>&1 || true

open "$DEST/Limon.app"

echo "  🧡  ¡Listo! Limón ya está en tu pantalla."
echo "      (Puedes cerrar esta ventana.)"
echo ""
