
#!/usr/bin/env bash

bash ionice -c3 -n7 ./nice.sh &
bash ionice -c2 -n0 ./notnice.sh &
