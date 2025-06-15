#!/bin/bash

DEFAULT_FILENAME="output.txt"
interrupt_count=0

handle_interrupt() {
    ((interrupt_count++))
    if [[ $interrupt_count -eq 1 ]]; then
        echo -e "\nExecuting 'du -a':"
        du -a
    else
        echo -e "\nExecuting 'du -s':"
        du -s
    fi
}

trap handle_interrupt SIGINT

while true; do
    echo -n "Enter file name or press enter for default ($DEFAULT_FILENAME). To quit, type 'q': "
    read filename

    if [[ "$filename" == "q" ]]; then
        echo "Exiting program..."
        exit 0
    fi

    if [[ -z "$filename" ]]; then
        filename=$DEFAULT_FILENAME
    fi

    : > "$filename"  # Очистка файла перед записью
    (
        pwd
        ls -l
    ) | cat > "$filename"
    echo "Output written to $filename"
done

