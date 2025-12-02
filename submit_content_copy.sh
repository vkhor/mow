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
            STEPPING="$2"
            shift 2 
            ;;
        -prodname)
            PRODNAME="$2"
            shift 2 
            ;;
        -content_type)
            CONTENT_TYPE="$2"
            shift 2 
            ;;
        -source)
            SOURCE="$2"
            shift 2 
            ;;
        -description)
            if [[ -n "$2" ]]; then
                DESCRIPTION="$2"
                shift 2 # Shift past the flag and the description text
            else
                echo "Error: -description flag requires a value." >&2
                exit 1
            fi
            ;;
        -h|--help)
            echo "Usage: $0 [-stepping value]"
            exit 0
            ;;
        *)
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

#Create a tmp area
RAND_INT=$RANDOM
mkdir -p /tmp/mow_$RAND_INT
cd /tmp/mow_$RAND_INT
git clone https://github.com/vkhor/mow.git 
cd mow
git checkout -b  content_copy/${USER}_${PRODNAME}_${STEPPING}_${CONTENT_TYPE}
touch copy_details
echo "stepping=$STEPPING" >> copy_details
echo "prodname=$PRODNAME" >> copy_details
echo "content_type=$CONTENT_TYPE" >> copy_details
echo "source=$SOURCE" >> copy_details
echo "description=$DESCRIPTION" >> copy_details

git add --all
git commit -m "commit"
git push -u origin content_copy/${USER}_${PRODNAME}_${STEPPING}_${CONTENT_TYPE}

