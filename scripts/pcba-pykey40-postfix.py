#!/usr/bin/env python3

# The POS/CPL files for the PCBA for PyKey40 need some additional
# manipulations even after Kibot has generated them.
#
# The PyKey40's PCBA is bottom-side only.
#
# The Kailh Hotswap sockets in JLCPCB's library
# are assumed to have a position in the middle of the socket, on B.Cu,
# whereas the KiCad footprint's centre is the middle of the switch, on F.Cu.
#
# This program outputs a "-fixed" bottom POS/CPL,
# with the rows sorted by the reference designator,
# and adds the Kailh Hotswap sockets with the correct position.

import argparse
import csv
import re

def int_or_value(s):
    try:
        return int(s)
    except ValueError:
        return s

def designator_comparitor(designator):
    match = re.match(r"([a-z]+)([0-9]+)", designator, re.I)
    if match:
        s, n = match.groups()
        return [s, int(n)]
    else:
        parts = [int_or_value(s) for s in designator.rsplit('_', 1)]
        parts[0] = parts[0] + "_"
        return parts

# function which appends "-fixed" to the basename of a filename.
# e.g. "foo.ext" becomes "foo-fixed.ext"
def fixed_filename(filename):
    parts = filename.split('.')
    return parts[-2] + '-fixed.' + parts[-1]

def sort_rows_by_designator(rows):
    return sorted(rows, key=lambda row: designator_comparitor(row['Designator']))

def is_kailh_socket(row):
    return row['Package'] == "Kailh_socket_MX_substitutable"

def adjust_kailh_socket(row):
    delta_x, delta_y = [0.635, -3.81]
    row['Mid X'] = "{:.6f}".format(float(row['Mid X']) + delta_x)
    row['Mid Y'] = "{:.6f}".format(float(row['Mid Y']) + delta_y)
    row['Layer'] = 'bottom'


parser = argparse.ArgumentParser(description='Generate a fixed POS/CPL for the PyKey40 PCBA.')
parser.add_argument('bottom_filename', type=str, help='path to the bottom POS/CPL file')
parser.add_argument('top_filename', type=str, nargs='?', help='path to the top POS/CPL file')

if __name__ == "__main__":
    args = parser.parse_args()

    output_filename = fixed_filename(args.bottom_filename)

    with open(args.bottom_filename, newline='') as csvfile:
        reader = csv.DictReader(csvfile)
        data = list(reader)
        if args.top_filename:
            with open(args.top_filename, newline='') as csvfile:
                reader = csv.DictReader(csvfile)
                kailh_sockets = filter(is_kailh_socket, list(reader))
                for row in kailh_sockets:
                    adjust_kailh_socket(row)
                    data.append(row)
        sorted_data = sort_rows_by_designator(data)
        writer = csv.DictWriter(open(output_filename, 'w', newline=''), fieldnames=reader.fieldnames)
        writer.writeheader()
        writer.writerows(sorted_data)
