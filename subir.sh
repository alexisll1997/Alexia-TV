#!/bin/bash
cd ~/Alexia-TV
git pull
read -p "Nuevo versionCode (ej. 43776): " VCODE
read -p "Nuevo versionName (ej. 4.35.3): " VNAME
read -p "Notas de la actualizacion: " NOTES
mkdir -p releases/$VCODE
cp "/storage/emulated/0/Apktool_M/Alexia TV.apk" releases/$VCODE/Alexia.TV.apk
SIZE=$(wc -c < releases/$VCODE/Alexia.TV.apk | tr -d " ")
SHA=$(sha256sum releases/$VCODE/Alexia.TV.apk | awk "{print \$1}")
PROTO="https"
HOST="raw.githubusercontent.com"
REPO="alexisll1997/Alexia-TV/main/releases/$VCODE/Alexia.TV.apk"
cat << JSON > ota.json
{
  "packageName": "com.xuper.alexia",
  "versionCode": $VCODE,
  "versionName": "$VNAME",
  "minSdk": 22,
  "url": "$PROTO://$HOST/$REPO",
  "size": $SIZE,
  "sha256": "$SHA",
  "notes": "$NOTES"
}
JSON
git add .
git commit -m "Release $VNAME ($VCODE)"
git push
echo "Listo! Actualizacion $VNAME publicada."
