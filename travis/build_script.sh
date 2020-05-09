travis/script.sh

#!/bin/sh
set -e

xctool -workspace TDT-project.xcworkspace -scheme TDT-project build test
