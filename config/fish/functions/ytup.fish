function ytup
    cd /Zed/Programming/Github/MoneyPrinterV2/
    . venv/bin/activate.fish 
    set ytniches (cmd cat ytniches)
    while true
      set ryt $ytniches[(random 1 (count $ytniches))]
      cat .mp/youtube.json | jq --arg n $ryt '.accounts[0].niche = $n' > ytmp ; mv ytmp .mp/youtube.json
      py src/main.py < ytinput 
    end
end
