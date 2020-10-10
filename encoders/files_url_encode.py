# Copyright (C) Khudyashev Ivan, 2020
import sys

def usage():
    print(\
        "Util " + sys.argv[0] + \
        " is aimed for url-encode files as command arguments" + \
        " line by line and write its in files with same names plus" + \
        " suffix '.save'"\
    )

def urlencode_file(f):
    #check if file exists
    import os.path
    from urllib.parse import quote
    if os.path.isfile(f):
        save_file = open(f + ".save", "w")
        with open(f) as in_file:
            for line in in_file:
                save_file.write(quote(line))
        save_file.close()
    else:
        print("There is no file: " + f)
        usage()

def main():
    print("Hello. This utility url-encode every string in files in args")
    cnt_args = len(sys.argv)
    i = 1 # start with 1-st arg
    while i < cnt_args:
        urlencode_file(sys.argv[i])
        i = i + 1
    print("Job well done")

if __name__ == "__main__":
    main()
