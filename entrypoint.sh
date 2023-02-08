#!/bin/bash

REQUEST_LINK=https://seq.ceremony.ethereum.org/auth/request_link

urlencode() {
    local l=${#1}
    for (( i = 0 ; i < l ; i++ )); do
        local c=${1:i:1}
        case "$c" in
            [a-zA-Z0-9.~_-]) printf "$c" ;;
            ' ') printf + ;;
            *) printf '%%%.2X' "'$c"
        esac
    done
}

echo -e "#######################################################################"
kzgcli status
echo -e "#######################################################################\n\n"
function get_request_link() {
    RESPONSE=$(curl --connect-timeout 5 \
        --max-time 10 \
        --silent \
        --retry 5 \
        --retry-delay 0 \
        --retry-max-time 40 \
        -X GET "${REQUEST_LINK}") ||
        {
            echo "[ERROR] getting the request link"
            exit 1
        }

    ETH_AUTH_LINK=$(echo $RESPONSE | jq -r .eth_auth_url)
    GITHUB_AUTH_URL=$(echo $RESPONSE | jq -r .github_auth_url)

    ETH_AUTH_LINK_ENCODED=$(urlencode ${ETH_AUTH_LINK} )
    GITHUB_AUTH_URL_ENCODED=$(urlencode ${GITHUB_AUTH_URL})

    curl --connect-timeout 5 \
        --max-time 10 \
        --silent \
        --retry 5 \
        --retry-delay 0 \
        --retry-max-time 40 \
        -X POST "http://my.dappnode/data-send?key=Ethereum&data=${ETH_AUTH_LINK_ENCODED}" ||
        {
            echo "[ERROR] failed to post ENR to dappmanager"
            exit 1
        }
    curl --connect-timeout 5 \
        --max-time 10 \
        --silent \
        --retry 5 \
        --retry-delay 0 \
        --retry-max-time 40 \
        -X POST "http://my.dappnode/data-send?key=Github&data=${GITHUB_AUTH_URL_ENCODED}" ||
        {
            echo "[ERROR] failed to post ENR to dappmanager"
            exit 1
        }

    echo "[INFO] you need to get a session-id, either by logging in with github or with an ethereum address."
    echo -e "[INFO] For ethreum you can get it here:\n\n\t${ETH_AUTH_LINK}\n\n"
    echo -e "[INFO] For github you can get it here:\n\n\t ${GITHUB_AUTH_URL}\n\n"

    echo "[INFO] once logged in you will have to copy the session-id here to be able to make your contribution."
    sleep infinity
}

if [[ "${SESSION_ID}" == "" ]]; then
    get_request_link
else
    echo -e "[INFO] Starting your contribution...\n\n"
    kzgcli contribute --session-id ${SESSION_ID} ${EXTRA_OPTS}
    sleep infinity
fi
