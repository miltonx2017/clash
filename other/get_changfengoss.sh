urls_file=urls_changfengoss.txt
proxies_file=rawlist.txt

echo '' > $proxies_file
for x in $(sed -z -E "s|\n| |g" $urls_file)
do
	curl -L --socks5-hostname 0.0.0.0:7891 $x >> $proxies_file
done
sed -i "/.*name.*server.*port/! d" $proxies_file
sed -i -E "s|\: *\"[^\"]*\,[^\"]*\"|\:x|g; s|\"*name\"* *\:[^\,]*|name\:x|; s|\"*country\"* *\:[^\,]*|country\:x|; s|\:|\: |g; s|\,|\, |g; s|  | |g; s|^ *-|-|; s|\"||g" $proxies_file
sort $proxies_file | uniq > /tmp/sorted_proxies_file
cp /tmp/sorted_proxies_file $proxies_file
rm /tmp/sorted_proxies_file

geany $proxies_file
