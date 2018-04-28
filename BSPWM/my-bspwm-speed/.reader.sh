rm ~/.bar
mkfifo ~/.bar
while read line < ~/.bar; do
    printf "%s\n" "${line}";
done
