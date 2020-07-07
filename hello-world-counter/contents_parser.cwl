#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

inputs:
  word_file: File

baseCommand: python
arguments:
 - prefix: -c
   valueFrom: |
    import json
    with open("$(inputs.word_file.path)", "r") as infile:
        words = infile.readline().split()[0]
        
    with open("cwl.output.json", "w") as output:
      json.dump({"number_of_words": int(words)}, output)

outputs:
  number_of_words: 
    type: int
