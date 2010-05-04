if [ $(grep 'Sequences producing significant alignments:'  $1 | wc -l) -gt 0 ]; then
    exit 0
else
    exit 1
fi
