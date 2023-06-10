#!/usr/bin/env python3

import os

import sexpdata

def render_sexpdata_symbol_to_string(c):
    if type(c) == list:
      return [render_sexpdata_symbol_to_string(cc) for cc in c]
    elif type(c) == sexpdata.Symbol:
      return c.value()
    else:
      return c

if __name__ == "__main__":
    # sym-lib-table

    pcb_dir = "../pcb"

    # read in pcb_dir/sym-lib-table
    sym_lib_table = sexpdata.loads(open(os.path.join(pcb_dir, "sym-lib-table"), "r").read())

    # find symbol library names in sym-lib-table
    sym_lib_names = []
    for s in sym_lib_table:
        if type(s) == list:
            if s[0].value() == "lib":
                # (lib (name "x") ...)
                name = s[1][1]
                if type(name) == str:
                    sym_lib_names.append(name)
                else:
                    sym_lib_names.append(name.value())

    print("sym-lib-table has:")
    for sym_lib_name in sym_lib_names:
        print(sym_lib_name)
    print("")

    # read in pcb_dir/sym-lib-table
    fp_lib_table = sexpdata.loads(open(os.path.join(pcb_dir, "fp-lib-table"), "r").read())

    # find symbol library names in sym-lib-table
    fp_lib_names = []
    for s in fp_lib_table:
        if type(s) == list:
            if s[0].value() == "lib":
                # (lib (name "x") ...)
                name = s[1][1]
                if type(name) == str:
                    fp_lib_names.append(name)
                else:
                    fp_lib_names.append(name.value())

    print("fp-lib-table has:")
    for fp_lib_name in fp_lib_names:
        print(fp_lib_name)
    print("")

    # list all *.kicad_sch files in pcb directory
    schematic_paths = []
    for root, dirs, files in os.walk(pcb_dir):
        for file in files:
            if file.endswith(".kicad_sch"):
                 schematic_paths.append(os.path.join(root, file))

    # (kicad_sch ... (lib_symbols (symbol string-or-lib-id ...)))
    #
    # (lib_id "")
    # kicad_pcb_data_sexpr = sexpdata.loads(kicad_pcb)
    #
    # And this symbol id is in form "library:component"
    #
    # Add to set used_symbol_libraries
    used_symbol_libraries = set()
    for schematic_path in schematic_paths:
        kicad_sch = open(schematic_path, "r").read()
        kicad_sch_data_sexpr = sexpdata.loads(kicad_sch)

        for c in kicad_sch_data_sexpr:
            if type(c) == list:
                if c[0].value() == "lib_symbols":
                    for cc in c[1:]:
                        if type(cc) == list and cc[0].value() == "symbol":
                            if type(cc[1]) == list:
                                used_symbol_libraries.add(cc[1][1].split(":")[0])
                            else:
                                used_symbol_libraries.add(cc[1].split(":")[0])

    # print("schematics used:")
    # for used_symbol_library in used_symbol_libraries:
    #     print(used_symbol_library)
    # print("")

    diff_sym = set(sym_lib_names) - used_symbol_libraries
    if len(diff_sym) > 0:
        print("unused symbol libraries:")
        for d in diff_sym:
            print(d)
        print("")

    # list all *.kicad_pcb files in pcb directory
    pcb_paths = []
    for root, dirs, files in os.walk(pcb_dir):
        for file in files:
            if file.endswith(".kicad_pcb"):
                 pcb_paths.append(os.path.join(root, file))

    # (kicad_sch ... (lib_symbols (symbol string-or-lib-id ...)))
    #
    # (lib_id "")
    # kicad_pcb_data_sexpr = sexpdata.loads(kicad_pcb)
    #
    # And this symbol id is in form "library:component"
    #
    # Add to set used_symbol_libraries
    used_fp_libraries = set()
    for pcb_path in pcb_paths:
        kicad_pcb = open(pcb_path, "r").read()
        kicad_pcb_data_sexpr = sexpdata.loads(kicad_pcb)

        for c in kicad_pcb_data_sexpr:
            if type(c) == list and c[0].value() == "footprint":
                used_fp_libraries.add(c[1].split(":")[0])

    # print("footprints used:")
    # for l in used_fp_libraries:
    #     print(l)
    # print("")

    diff_fp = set(fp_lib_names) - used_fp_libraries
    if len(diff_fp) > 0:
        print("unused footprint libraries:")
        for d in diff_fp:
            print(d)
        print("")
    pass
