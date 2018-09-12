#!/bin/bash

# pre-requisites
which hxselect > /dev/null || (echo "Error: missing 'hxselect'; brew install html-xml-utils" ; exit 1)
which hxnormalize > /dev/null || (echo "Error: missing 'hxnormalize'; brew install html-xml-utils" ; exit 1)
which asc2xml > /dev/null || (echo "Error: missing 'asc2xml'; brew install html-xml-utils" ; exit 1)

sessionid=$1

for market in Sverige Norge Danmark; do
    for cap in large mid; do
        echo "Fetching $market $cap..."
        curl -s -b "JSESSIONID=$sessionid" "https://www.nordnet.se/mux/web/marknaden/kurslista/aktier.html?marknad=${market}&lista=1_1&${cap}=on&sektor=0&subtyp=key_ratios" | hxnormalize -x | hxselect table#kurstabell | asc2xml | ruby ./extract.rb > ${market}-${cap}.csv
    done
done

# Sverige small
echo "Fetching Sverige small..."
curl -s -b "JSESSIONID=$sessionid" 'https://www.nordnet.se/mux/web/marknaden/kurslista/aktier.html?marknad=Sverige&lista=1_1&small=on&sektor=0&subtyp=key_ratios' | hxnormalize -x | hxselect table#kurstabell | asc2xml | ruby ./extract.rb > Sverige-small.csv

# First North
echo "Fetching Sverige First North..."
curl -s -b "JSESSIONID=$sessionid" 'https://www.nordnet.se/mux/web/marknaden/kurslista/aktier.html?marknad=Sverige&lista=6_0&subtyp=key_ratios' | hxnormalize -x | hxselect table#kurstabell | asc2xml | ruby ./extract.rb > Sverige-firstnorth.csv
