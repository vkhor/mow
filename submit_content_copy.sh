#!/bin/bash

# Function to display usage information
usage() {
  echo "Usage: $0 [-stepping] [-prodname] [-content_type] [-source] [-descripton]"
  echo "  -stepping       Product Stepping. Eg. a0/b0/p0"
  echo "  -prodname       Product Name. Eg. rzlcpu/ttlhub"
  echo "  -content_type   Content Typr    "
  echo "  -source         Source of Patterns to Copy"
  echo "  -descripton     One Line Description of What are Copied. "
  echo "  -help           Help Message  "
  exit 1
}

for arg in "$@"; do
    if [ "$arg" == "-help" ] || [ "$arg" == "--help" ] || [ "$arg" == "-h" ]; then
        usage
        break # Exit the loop early once a match is found
    fi
done

while [[ "$#" -gt 0 ]]; do
    case "$1" in
        -stepping)
            # When -stepping is found ($1), store the NEXT argument ($2)
            STEPPING="$2"
            # Shift twice: once for the flag, once for the value
            shift 2 
            ;;
        -prodname)
            # When -stepping is found ($1), store the NEXT argument ($2)
            PRODNAME="$2"
            # Shift twice: once for the flag, once for the value
            shift 2 
            ;;
        -content_type)
            # When -stepping is found ($1), store the NEXT argument ($2)
            CONTENT_TYPE="$2"
            # Shift twice: once for the flag, once for the value
            shift 2 
            ;;
        -source)
            # When -stepping is found ($1), store the NEXT argument ($2)
            SOURCE="$2"
            # Shift twice: once for the flag, once for the value
            shift 2 
            ;;
        -description)
            # Check if the next argument exists before trying to access it
            if [[ -n "$2" ]]; then
                DESCRIPTION="$2"
                shift 2 # Shift past the flag and the description text
            else
                echo "Error: -description flag requires a value." >&2
                exit 1
            fi
            ;;
        -h|--help)
            # Handle a help flag if needed
            echo "Usage: $0 [-stepping value]"
            exit 0
            ;;
        *)
            # Handle unknown arguments or general arguments
            echo "Ignoring unknown parameter: $1"
            shift 1
            ;;
    esac
done

echo "stepping=$STEPPING"
echo "prodname=$PRODNAME"
echo "content_type=$CONTENT_TYPE"
echo "source=$SOURCE"
echo "description=$DESCRIPTION"

