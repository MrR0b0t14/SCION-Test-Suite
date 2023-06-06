#!/bin/bash
# This script runs the entire test suite
# Store the arguments passed to the shell script

# Usage: ./test_suite.sh <iterations>
iterations=$1
args="$@"

display_help_info() {
    echo "Help information:"
    echo "Usage: ./test_suite.sh <iterations>"
    echo "Arguments:"
    echo "  -h, --help: Display help information"
    echo ""
    echo "  <iterations>: Number of iterations to run the test suite"
}

# Iterate through the arguments
for arg in $args; do
    # Check if the argument is '-help'
    if [[ "$arg" == "--help" || "$arg" == "-h" ]]; then
        # Display help information
        display_help_info
        exit 0
    fi
done

if ! [[ $1 =~ ^[0-9]+$ ]]; then
    echo "Invalid iterations argument. Argument is not a digit."
    display_help_info
else
    if [ -z "$iterations" ]; then
        echo "Please provide the iterations number as an argument."
        # Display help information
        display_help_info
        exit 1
    fi

    for arg in $args; do
        # Check if the argument is '-help'
        if [[ "$arg" == "--skip" ]; then
            # echo "Skipping the path collection..."
            echo "Running the test suite..."
            python3 Tests/run_test.py -n 1
            exit 0
        fi
    done  

    # Collect the paths
    echo "Collecting all the paths..."
    python3 collect_paths.py

    echo "Running the test suite..."
    python3 Tests/run_test.py -n 1
    exit 0
fi
