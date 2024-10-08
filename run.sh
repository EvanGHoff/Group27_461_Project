#!/bin/bash

arg1=$1

if [ "$arg1" == "install" ]; then
    npm init -y
    if [ $? -ne 0 ]; then
        echo "npm init failed"
        exit 1
    fi

    npm install typescript --save-dev
    if [ $? -ne 0 ]; then
        echo "npm install typescript failed"
        exit 1
    fi

    npm install @types/node --save-dev
    if [ $? -ne 0 ]; then
        echo "npm install @types/node failed"
        exit 1
    fi

    npm install fs --save-dev
    if [ $? -ne 0 ]; then
        echo "npm install fs failed"
        exit 1
    fi

    npm install axios --save-dev
    if [ $? -ne 0 ]; then
        echo "npm install axios failed"
        exit 1
    fi

    npm install dotenv --save-dev
    if [ $? -ne 0 ]; then
        echo "npm install dotenv failed"
        exit 1
    fi

    npm install simple-git --save-dev
    if [ $? -ne 0 ]; then
        echo "npm install simple-git failed"
        exit 1
    fi

    exit 0

if [ "$1" == "test" ]; then
  URL_FILE="test_cases.txt"
  
  if [ ! -f "$URL_FILE" ]; then
    echo "Error: File '$URL_FILE' does not exist."
    exit 1
  fi

  # Directory to store outputs
  OUTPUT_DIR="test_outputs"
  mkdir -p "$OUTPUT_DIR"

  # Iterate through URLs in the file and run tests
  INDEX=1
  while IFS= read -r URL; do
    echo "Processing test case #$INDEX with URL: $URL"

    # Run the metrics code on the URL and save to output file
    node metrics.js "$URL" > "$OUTPUT_DIR/output_$INDEX.json"

    echo "Output for test case #$INDEX written to $OUTPUT_DIR/output_$INDEX.json"
    INDEX=$((INDEX + 1))

    # Limit to 20 test cases
    if [ "$INDEX" -gt 20 ]; then
      break
    fi
  done < "$URL_FILE"

  echo "Completed running 20 test cases."
  exit 0
fi

# Handle URL file input for running specific URL sets
URL_FILE="$1"

if [ ! -f "$URL_FILE" ]; then
  echo "Error: File '$URL_FILE' does not exist."
  exit 1
fi

npx tsc cli.ts
node cli.js $1

echo "Completed processing all URLs."
exit 0
fi