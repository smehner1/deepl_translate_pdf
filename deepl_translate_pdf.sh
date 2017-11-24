#!/bin/bash



BASE=$(pwd)
TMP_TXT="tmp.txt"
TRANSLATED_FILE="translated.txt"
CHAR_THRESHOLD=100
CHAR_LIMIT=4800

echo "pdftotext $1 $TMP_TXT"
## convert pdf to txt with pdftotxt


pdftotext "$1" $TMP_TXT

# pdftotext BroadR-Reach.pdf tmp.txt

## remove all \n but keep \n\n
echo ""
sed -i ':a;N;$!ba;s/\n\n/NEWLINENEWLINE/g' "$TMP_TXT"
sed -i ':a;N;$!ba;s/\n//g' "$TMP_TXT"
sed -i 's/NEWLINENEWLINE/\n\n/g' "$TMP_TXT"

TXT=$(cat $TMP_TXT)

echo "" > "$TRANSLATED_FILE"

echo "begin to translate file..."
echo
while read -r line
do
  # get chars from current line
  STRLENGTH=$(echo -n $line | wc -m)
  #echo $STRLENGTH
  # if string length greater than CHAR_THRESHOLD translate, otherwise there are only headlines or "Fig.1" that doesn't need to be translated
  # but one request to deepl api seems to be limited to 5000 chars
  if [ $STRLENGTH -ge $CHAR_THRESHOLD -o  $STRLENGTH -ge $CHAR_LIMIT ]
    then
      echo "$line" | deepl translate -t 'DE' >> "$TRANSLATED_FILE"
      echo -n ":"
      sleep 1
    else
      echo "$line" >> "$TRANSLATED_FILE"
      echo -n "."
  fi




done <<< "$TXT"

echo "... finished"

## clean up
rm "$TMP_TXT"
