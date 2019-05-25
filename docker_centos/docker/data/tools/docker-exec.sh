#!/bin/bash

VERBOSE="false"
EXECUTE="true"

run()
{
 
  TASK_ID="$(docker service ps -q -f "desired-state=Running" ${SERVICE_NAME})" || exit 1
  CONT_ID="$(docker inspect -f "{{.Status.ContainerStatus.ContainerID}}" ${TASK_ID})"	
  NODE_ID="$(docker inspect -f "{{.NodeID}}" ${TASK_ID})"
  NODE_IP="$(docker inspect -f {{.Status.Addr}} ${NODE_ID})"

  if [ "$VERBOSE" = "true" ]
  then
    echo "Service $SERVICE_NAME was found on $NODE_IP"
    echo "Send Command '$COMMAND' to Container $CONT_ID"
    echo "Task ID : $TASK_ID"
    echo "Cont ID : $CONT_ID"
    echo "Node ID : $NODE_ID"

    echo ssh -A ${NODE_IP} docker exec ${CONT_ID} ${COMMAND}
  fi

  if [ "$EXECUTE" = "true" ]
  then
    ssh -A ${NODE_IP} "docker exec ${CONT_ID} ${COMMAND}"
  fi
}

display_help() {
  echo "Usage: $0 [option...] {docker service name} {command}" >&2
  echo
  echo "   -h, --help           display this help"
  echo "   -v, --verbose        activate verbose mode"
  echo "   -n, --no-exec        dont exec the command on the container"
  echo
}

while :
do
case "$1" in
  -h | --help)
      display_help
      exit 0
      ;;

  -v | --verbose)
      VERBOSE="true"
      shift
      ;;

  -n | --no-exec)
      VERBOSE="true"
      EXECUTE="false"
      shift
      ;;

  --)
      shift
      break
      ;;
  -*)
      echo "Error: Unknown option: $1" >&2
      display_help
      exit 1 
      ;;
  *)
      break
      ;;
esac
done

case "$1" in
  '')
    display_help
    exit 1
  ;;
  *)
    SERVICE_NAME=$1
    COMMAND=""
    shift

    if [ "$1" = "" ]
    then
      display_help
      exit 1
    fi

    for ARG in "$@"; do
    COMMAND="$COMMAND $ARG"
    done

    run
  ;;
esac