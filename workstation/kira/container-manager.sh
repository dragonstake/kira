#!/bin/bash

set +e && source "/etc/profile" &>/dev/null && set -e
# quick edit: FILE="$KIRA_WORKSTATION/kira/container-manager.sh" && rm $FILE && nano $FILE && chmod 555 $FILE

NAME=$1

#CONTAINER_DUPM="$KIRA_DUMP/kira/${NAME^^}.log"
#mkdir -p $(dirname "$CONTAINER_DUPM")
#rm -fv $CONTAINER_DUPM
#exec >> "$CONTAINER_DUPM" 2>&1 && tail "$CONTAINER_DUPM"

while : ; do
    START_TIME="$(date -u +%s)"
    source $KIRA_WORKSTATION/kira/container-status.sh "$NAME"

    if [ "${EXISTS,,}" != "true" ] ; then
        clear
        echo "WARNING: Container $NAME no longer exists, aborting container manager..."
        sleep 2
        break
    fi

    clear
    
    echo -e "\e[36;1m-------------------------------------------------"
    echo "|        KIRA CONTAINER MANAGER v0.0.3          |"
    echo "|             $(date '+%d/%m/%Y %H:%M:%S')               |"
    echo "|-----------------------------------------------|"
    echo "|        Name: $NAME ($(echo $ID | head -c 8)...)"

    if [ "${EXISTS,,}" == "true" ] ; then # container exists
        i=-1 ; for net in $NETWORKS ; do i=$((i+1))
            IP="IP_$net" && IP="${!IP}"
            if [ ! -z "$IP" ] && [ "${IP,,}" != "null" ] ; then
                echo "|  Ip Address: $IP ($net)"
            fi
        done
    fi

    [ ! -z "$REPO" ] && \
    echo "| Source Code: $REPO ($BRANCH)"
    echo "|-----------------------------------------------|"
    echo "|     Status: $STATUS"
    echo "|     Health: $HEALTH"
    echo "| Restarting: $RESTARTING"
    echo "| Started At: $(echo $STARTED_AT | head -c 19)"
    echo "|-----------------------------------------------|"
    [ "${EXISTS,,}" == "true" ] && 
    echo "| [I] | Try INSPECT container                   |"
    [ "${EXISTS,,}" == "true" ] && 
    echo "| [L] | Dump container LOGS                     |"
    [ "${EXISTS,,}" == "true" ] && 
    echo "| [R] | RESTART container                       |"
    [ "$STATUS" == "exited" ] && 
    echo "| [A] | START container                         |"
    [ "$STATUS" == "running" ] && 
    echo "| [S] | STOP container                          |"
    [ "$STATUS" == "running" ] && 
    echo "| [R] | RESTART container                       |"
    [ "$STATUS" == "running" ] && 
    echo "| [P] | PAUSE container                         |"
    [ "$STATUS" == "paused" ] && 
    echo "| [U] | UNPAUSE container                       |"
    [ "${EXISTS,,}" == "true" ] && 
    echo "|-----------------------------------------------|"
    echo "| [X] | Exit | [W] | Refresh Window             |"
    echo -e "-------------------------------------------------\e[0m"

    read -s -n 1 -t 6 OPTION || continue
    [ -z "$OPTION" ] && continue

    ACCEPT="" && while [ "${ACCEPT,,}" != "y" ] && [ "${ACCEPT,,}" != "n" ] ; do echo -en "\e[36;1mPress [Y]es to confirm option (${OPTION^^}) or [N]o to cancel: \e[0m\c" && read  -d'' -s -n1 ACCEPT && echo "" ; done
    [ "${ACCEPT,,}" == "n" ] && echo -e "\nWARINIG: Operation was cancelled\n" && sleep 1 && continue
    echo ""

    EXECUTED="false"
    if [ "${OPTION,,}" == "i" ] ; then
        echo "INFO: Entering container $NAME ($ID)..."
        echo "INFO: To exit the container type 'exit'"
        docker exec -it $ID bash || docker exec -it $ID sh 
        OPTION=""
        EXECUTED="true"
    elif [ "${OPTION,,}" == "l" ] ; then
        echo "INFO: Dumping all loggs..."
        $WORKSTATION_SCRIPTS/dump-logs.sh $NAME
        EXECUTED="true"
    elif [ "${OPTION,,}" == "r" ] ; then
        echo "INFO: Restarting container..."
        $KIRA_SCRIPTS/container-restart.sh $NAME
        EXECUTED="true"
    elif [ "${OPTION,,}" == "a" ] ; then
        echo "INFO: Staring container..."
        $KIRA_SCRIPTS/container-start.sh $NAME
        EXECUTED="true"
    elif [ "${OPTION,,}" == "s" ] ; then
        echo "INFO: Stopping container..."
        $KIRA_SCRIPTS/container-stop.sh $NAME
        EXECUTED="true"
    elif [ "${OPTION,,}" == "p" ] ; then
        echo "INFO: Pausing container..."
        $KIRA_SCRIPTS/container-pause.sh $NAME
        EXECUTED="true"
    elif [ "${OPTION,,}" == "u" ] ; then
        echo "INFO: UnPausing container..."
        $KIRA_SCRIPTS/container-unpause.sh $NAME
        EXECUTED="true"
    elif [ "${OPTION,,}" == "w" ] ; then
        echo "INFO: Please wait, refreshing user interface..."
        EXECUTED="true"
        continue
    elif [ "${OPTION,,}" == "x" ] ; then
        echo -e "INFO: Stopping Container Manager...\n"
        EXECUTED="true"
        sleep 1
        break
    fi
    
    if [ "${EXECUTED,,}" == "true" ] && [ ! -z $OPTION ] ; then
        echo "INFO: Option ($OPTION) was executed, press any key to continue..."
        read -s -n 1 || continue
    fi
done

echo "INFO: Contianer Manager Stopped"