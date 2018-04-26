#!/bin/bash

sessionid=$1

for market in Sverige Norge Danmark; do
    for cap in large mid; do
        echo "Fetching $market $cap..."
        curl -s -b "JSESSIONID=$sessionid" "https://www.nordnet.se/mux/web/marknaden/kurslista/aktier.html?marknad=${market}&lista=1_1&${cap}=on&sektor=0&subtyp=key_ratios" | hxnormalize -x | hxselect table#kurstabell | asc2xml | ruby ./extract.rb > ${market}-${cap}.csv
    done
done

# First North
echo "Fetching Sverige First North..."
curl -s -b "JSESSIONID=$sessionid" 'https://www.nordnet.se/mux/web/marknaden/kurslista/aktier.html?marknad=Sverige&lista=6_0&subtyp=key_ratios' | hxnormalize -x | hxselect table#kurstabell | asc2xml | ruby ./extract.rb > Sverige-firstnorth.csv
