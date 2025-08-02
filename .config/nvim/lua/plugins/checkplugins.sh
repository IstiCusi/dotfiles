#!/bin/bash
grep -Eo '"[a-zA-Z0-9_.-]+/[a-zA-Z0-9_.-]+"' *.lua | sed -E 's/^"//; s/"$//' | sort -u

