
RPC="https://rpc.serenity.aura.network:443"
AURASCAN="https://serenity.aurascan.io"
NODE="--node $RPC"
FEE="0.0025uaura"
CHAIN_ID='serenity-testnet-001'
TXFLAG="$NODE --chain-id $CHAIN_ID --gas-prices $FEE --gas auto --gas-adjustment 1.3 -y"


CONTRACT="aura18gmcfef2qgp06m55zh73f28fm0fnwnkxe6rmhhunduz3s4fn9g6q9zjyc0"
MINT='{"mint":{"amount":"1","recipient":"aura1h6r78trkk2ewrry7s3lclrqu9a22ca3hpmyqfu"}}'

# aurad tx wasm execute "$CONTRACT" "$MINT"  --from wallet --node https://rpc.serenity.aura.network:443 --chain-id serenity-testnet-001 --gas-prices 25uaura --gas auto --gas-adjustment 1.3 -y --keyring-backend test
echo "aurad tx wasm execute "$CONTRACT" "$MINT" --amount 1000uaura --from wallet $TXFLAG"

aurad tx wasm execute "$CONTRACT" $MINT --amount 1000uaura --from wallet $TXFLAG
