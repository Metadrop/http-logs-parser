#!/usr/bin/env python3

import argparse
import subprocess
import sys
import yaml

if __name__ == "__main__":
    with open(f"log-formats.yaml", 'r') as file:
        log_formats = yaml.safe_load(file)

    parser = argparse.ArgumentParser()
    parser.add_argument("--log-file", required=True)
    parser.add_argument("--log-format", default="COMBINED")
    parser.add_argument("--datetime-format", default="COMBINED")
    parser.add_argument("--report-file", required=True)
    args = parser.parse_args()

    if args.log_format in log_formats:
        log_format = log_formats[args.log_format]
    else:
        log_format = args.log_format

    cmd = []
    cmd += ["goaccess"]
    cmd += ["--all-static-files"]
    cmd += [f"--datetime-format={args.datetime_format}"]
    cmd += [f'--log-format="{log_format}"']
    cmd += [f"--output={args.report_file}"]
    cmd += [args.log_file]

    #print("RUN: %s" % " ".join(cmd))

    proc = subprocess.run(cmd, capture_output=True, text=True)
    result = proc.returncode
    if result > 0:
        print(proc.stdout)
        print(proc.stderr)

    sys.exit(result)
