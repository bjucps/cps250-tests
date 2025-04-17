#!/usr/bin/env awk
BEGIN { version = "unknown" }
/^this:/ { version = "75" }
/^this[[:space:]]/ { version = "100" }
END { print version }
