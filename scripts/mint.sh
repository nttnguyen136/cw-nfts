
# RPC="https://rpc.euphoria.aura.network:443"
# AURASCAN="https://euphoria.aurascan.io"
# NODE="--node $RPC"
# FEE="0.0025ueaura"
# CHAIN_ID='euphoria-1'
# TXFLAG="$NODE --chain-id $CHAIN_ID --gas-prices $FEE --gas auto --gas-adjustment 1.3 -y"
# CONTRACT="aura1jrq65w79x5y9utw77c3ze8sg3qwvxtdjp09jrsf4dvkmnc8z6xpsj2f4f5"


RPC="https://rpc.serenity.aura.network:443"
AURASCAN="https://serenity.aurascan.io"
NODE="--node $RPC"
FEE="0.0025uaura"
CHAIN_ID='serenity-testnet-001'
TXFLAG="$NODE --chain-id $CHAIN_ID --gas-prices $FEE --gas auto --gas-adjustment 1.3 -y"
CONTRACT="aura1992q8ekk2xxkh36nxatkmsk84pes2vmxjzdttqvm42puypquux5q75c3ux"

# RPC="https://rpc.dev.aura.network:443"
# AURASCAN="https://explorer.dev.aura.network/"
# NODE="--node $RPC"
# FEE="0.0025utaura"
# CHAIN_ID='aura-testnet'
# TXFLAG="$NODE --chain-id $CHAIN_ID --gas-prices $FEE --gas auto --gas-adjustment 1.3 -y"
# CONTRACT="aura1d6rdtpa3h0llnhuyylzwsrc30jueythft4n87k6059xewj9duj3szp9n6t"


#MINT='{"mint":{"amount":"1","recipient":"aura1trqfuz89vxe745lmn2yfedt7d4xnpcpvltc86e"}}'
# i=1
# TOKEN_ID="ID-11Oct2022-"$i""
# MINT='{"mint":{"owner":"aura1trqfuz89vxe745lmn2yfedt7d4xnpcpvltc86e","token_id":"'$TOKEN_ID'", "token_uri": "https://nft-ipfs.s3.amazonaws.com/QmTAMW7d3PFUXUSiBvPXF5RtNnBmK3b12cKkrTcVtgNqgT.mp4"}}'
# echo $MINT
# # aurad tx wasm execute "$CONTRACT" "$MINT"  --from wallet --node https://rpc.serenity.aura.network:443 --chain-id serenity-testnet-001 --gas-prices 25uaura --gas auto --gas-adjustment 1.3 -y --keyring-backend test
# # echo "aurad tx wasm execute "$CONTRACT" "$MINT" --amount 1000uaura --from wallet $TXFLAG"

# aurad tx wasm execute "$CONTRACT" "$MINT" --amount 1000uaura --from wallet $TXFLAG

for i in {1..222}
do
   TOKEN_ID="#ID-15Nov2022-"$i""
   #token URI - no image
   #MINT='{"mint":{"owner":"aura1trqfuz89vxe745lmn2yfedt7d4xnpcpvltc86e","token_id":"'$TOKEN_ID'", "token_uri": "https://nft-ipfs-indexer.s3.ap-southeast-1.amazonaws.com/bafybeicjilgl52q3iwo4b6r5sgsr4sjudb3zf5vxygcitvwf7ncfewyiei"}}'
   #animation_URL
   MINT='{"mint":{"owner":"aura1trqfuz89vxe745lmn2yfedt7d4xnpcpvltc86e","token_id":"'$TOKEN_ID'", "extension": {"animation_url": "ipfs://bafybeicjilgl52q3iwo4b6r5sgsr4sjudb3zf5vxygcitvwf7ncfewyiei"}}}'
   echo $MINT
   aurad tx wasm execute "$CONTRACT" "$MINT" --amount 1000uaura --from wallet $TXFLAG
   sleep 3

done