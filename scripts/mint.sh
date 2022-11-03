
RPC="https://rpc.euphoria.aura.network:443"
AURASCAN="https://euphoria.aurascan.io"
NODE="--node $RPC"
FEE="0.0025ueaura"
CHAIN_ID='euphoria-1'
TXFLAG="$NODE --chain-id $CHAIN_ID --gas-prices $FEE --gas auto --gas-adjustment 1.3 -y"
CONTRACT="aura1jrq65w79x5y9utw77c3ze8sg3qwvxtdjp09jrsf4dvkmnc8z6xpsj2f4f5"


# RPC="https://rpc.serenity.aura.network:443"
# AURASCAN="https://serenity.aurascan.io"
# NODE="--node $RPC"
# FEE="0.0025uaura"
# CHAIN_ID='serenity-testnet-001'
# TXFLAG="$NODE --chain-id $CHAIN_ID --gas-prices $FEE --gas auto --gas-adjustment 1.3 -y"
#CONTRACT="aura1d32dfs4m6l8y75l2yqnxwlz7xnnnx6xnss2mvzgexaq8snhsx0js7w8wq4"

# RPC="https://rpc.dev.aura.network:443"
# AURASCAN="https://explorer.dev.aura.network/"
# NODE="--node $RPC"
# FEE="0.0025utaura"
# CHAIN_ID='aura-testnet'
# TXFLAG="$NODE --chain-id $CHAIN_ID --gas-prices $FEE --gas auto --gas-adjustment 1.3 -y"
# CONTRACT="aura1206t3say4u6p5dnwpagzjz77qmt0uyx2dsew4sncm9j7w7lxjjxs4xheh9"


#MINT='{"mint":{"amount":"1","recipient":"aura1trqfuz89vxe745lmn2yfedt7d4xnpcpvltc86e"}}'
# i=1
# TOKEN_ID="ID-11Oct2022-"$i""
# MINT='{"mint":{"owner":"aura1trqfuz89vxe745lmn2yfedt7d4xnpcpvltc86e","token_id":"'$TOKEN_ID'", "token_uri": "https://nft-ipfs.s3.amazonaws.com/QmTAMW7d3PFUXUSiBvPXF5RtNnBmK3b12cKkrTcVtgNqgT.mp4"}}'
# echo $MINT
# # aurad tx wasm execute "$CONTRACT" "$MINT"  --from wallet --node https://rpc.serenity.aura.network:443 --chain-id serenity-testnet-001 --gas-prices 25uaura --gas auto --gas-adjustment 1.3 -y --keyring-backend test
# # echo "aurad tx wasm execute "$CONTRACT" "$MINT" --amount 1000uaura --from wallet $TXFLAG"

# aurad tx wasm execute "$CONTRACT" "$MINT" --amount 1000uaura --from wallet $TXFLAG

for i in {1..200}
do
   TOKEN_ID="#ID-14Oct2022-"$i""
   MINT='{"mint":{"owner":"aura1trqfuz89vxe745lmn2yfedt7d4xnpcpvltc86e","token_id":"'$TOKEN_ID'", "token_uri": "https://nft-ipfs-indexer.s3.amazonaws.com/QmQ1fvmdBsn7RJqjWZtBxXp3367j843Hb71F1sm3YBCQuN.mp4"}}'
   echo $MINT
   aurad tx wasm execute "$CONTRACT" "$MINT" --amount 1000ueaura --from wallet $TXFLAG
   sleep 10

done