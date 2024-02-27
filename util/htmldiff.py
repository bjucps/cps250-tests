#!/usr/bin/env python3
import argparse
import difflib
import os
import sys


def parse_args(argv):
    ap = argparse.ArgumentParser()
    ap.add_argument("expected_file")
    ap.add_argument("actual_file")
    return ap.parse_args()


def main(argv):
    args = parse_args(argv)

    with open(args.expected_file, "rt", encoding="utf-8") as ef, open(args.actual_file, "rt", encoding="utf-8") as af:
        elines = ef.readlines()
        alines = af.readlines()

    hd = difflib.HtmlDiff()
    print(hd.make_file(elines, alines, fromdesc=f"Expected Output (i.e., mine)", todesc=f"Actual Output (i.e., yours)"))


if __name__ == "__main__":
    main(sys.argv)
