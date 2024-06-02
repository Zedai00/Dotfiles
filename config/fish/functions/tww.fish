function tww
cd /Zed/Programming/Github/MoneyPrinterV2/
. venv/bin/activate.fish 
set twniches (cmd cat twniches)
while true
set rtw $twniches[(random 1 (count $twniches))]
cat .mp/twitter.json | jq --arg n $rtw '.accounts[0].topic = $n' > ttmp ; mv ttmp .mp/twitter.json
py src/main.py < twinput 
end
end
