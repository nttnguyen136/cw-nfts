
#!/bin/bash
BUILD="TRUE"
WORKSPACE=cosmwasm/workspace-optimizer:0.12.12
# CHAIN_ID=aura-testnet-2
CHAIN_ID=serenity-testnet-001
# CHAIN_ID=euphoria-2
# CHAIN_ID=xstaxy-1
WASM_PATH="./artifacts/"
#WASM_FILE="cw721_base.wasm" #normal
WASM_FILE="cw721_metadata_onchain.wasm" #meta onchain
WASM_FILE_PATH=$WASM_PATH$WASM_FILE
WALLET=wallet #qfu
# WALLET=ndt    #rjm
GITHUB="https://github.com/nttnguyen136/cw-nfts"
DELAY=10
# CODE_ID=1378
CONTRACT_LABEL="CW721 Contract name"

AURAD=$(which aurad)

case $CHAIN_ID in
  aura-testnet-2)
    RPC="https://rpc.dev.aura.network:443"
    AURASCAN="http://explorer.dev.aura.network"
    NODE="--node $RPC"
    FEE="0.0025utaura" 
    ;;

  serenity-testnet-001)
    RPC="https://rpc.serenity.aura.network:443"
    AURASCAN="https://serenity.aurascan.io"
    NODE="--node $RPC"
    FEE="0.0025uaura"
    ;;

  xstaxy-1)
    RPC="http://rpc.aura.network:443"
    AURASCAN="https://aurascan.io"
    NODE="--node $RPC"
    FEE="0.0025uaura"
    ;;

  euphoria-2)
    RPC="https://rpc.euphoria.aura.network:443"
    AURASCAN="https://euphoria.aurascan.io"
    NODE="--node $RPC"
    FEE="0.0025ueaura"
    ;;
esac

TXFLAG="$NODE --chain-id $CHAIN_ID --gas-prices $FEE --gas auto --gas-adjustment 1.3 -y"

echo "=================== DEPLOY ENV INFO ==================="
echo "- RPC                 $RPC"
echo "- CHAIN_ID            $CHAIN_ID"
echo "- TXFLAG:             $TXFLAG"
echo "- WASM_FILE_PATH:     $WASM_FILE_PATH"
echo "======================================================="
echo " "


if [ "$BUILD" = "TRUE" ]; then
  DOCKER_BUILDKIT=1
  docker run --rm -v "$(pwd)":/code \
    --mount type=volume,source="$(basename "$(pwd)")_cache",target=/code/target \
    --mount type=volume,source=registry_cache,target=/usr/local/cargo/registry \
    $WORKSPACE
fi

if [ -z $CODE_ID ]; then

  TXHASH=$($AURAD tx wasm store $WASM_FILE_PATH --from $WALLET $TXFLAG --output json | jq -r ".txhash")

  echo "Store hash: $AURASCAN/transaction/$TXHASH"

  sleep $DELAY

  CODE_ID=$(curl "$RPC/tx?hash=0x$TXHASH" | jq -r ".result.tx_result.log" | jq -r ".[0].events[-1].attributes[-1].value")
fi

if [ $CODE_ID -ge 0 ]; then
  INIT_MSG='{"name":"'$CODE_ID' CW721 Token","symbol":"'$CODE_ID' BASE","minter":"aura1afuqcya9g59v0slx4e930gzytxvpx2c43xhvtx"}'
  INIT=$INIT_MSG

  LABEL="$CODE_ID $CONTRACT_LABEL"

  echo "=================== CONTRACT INFO ==================="
  echo "CODE_ID:       $CODE_ID"
  echo "INIT:          $INIT"
  echo "LABEL:         $LABEL"
  echo "====================================================="

  INSTANTIATE=$($AURAD tx wasm instantiate $CODE_ID "$INIT" --from $WALLET --label "$LABEL" $TXFLAG -y --no-admin --output json)
  # INSTANTIATE=$($AURAD tx wasm instantiate "$INIT" --from $WALLET --label "$LABEL" $TXFLAG -y --no-admin --output json)

  echo $INSTANTIATE
  echo $HASH

  HASH=$( echo $INSTANTIATE | jq -r ".txhash")

  sleep $DELAY

  CONTRACT=$(curl "$RPC/tx?hash=0x$HASH" | jq -r ".result.tx_result.log" | jq -r ".[0].events[0].attributes[0].value")

  COMMIT_ID=$(git rev-parse --verify HEAD)

  echo "====================================================="
  echo `date`
  echo "CW721 - Code ID: "$CODE_ID
  echo "Aurascan: $AURASCAN/transaction/$HASH"
  echo "Contract: $AURASCAN/contracts/$CONTRACT"
  echo "Github: $GITHUB/commit/$COMMIT_ID"
  echo "Cargo version: $WORKSPACE"
  echo "WASM FILE: $WASM_FILE"
  echo "====================================================="

  echo "=====================================================" >> CW721info.txt
  echo `date` >> CW721info.txt
  echo "CW721 - Code: " $CODE_ID >> CW721info.txt
  echo "Aurascan: $AURASCAN/transaction/$HASH" >> CW721info.txt
  echo "Contract: $AURASCAN/contracts/$CONTRACT" >> CW721info.txt
  echo "Github: $GITHUB/commit/$COMMIT_ID" >> CW721info.txt
  echo "Cargo version: $WORKSPACE" >> CW721info.txt
  echo "WASM FILE: $WASM_FILE" >> CW721info.txt
  echo "=====================================================" >> CW721info.txt
else
  echo "==================="
  echo "Can not get CODE_ID"
  echo "==================="
fi