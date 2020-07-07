#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: wc
requirements:
  - class: InlineJavascriptRequirement

inputs:
  message: File

stdout: word_count.txt

outputs:
  word_count: 
    type: int
    outputBinding:
      glob: word_count.txt
      loadContents: true
      outputEval: $( parseInt( self[0].contents.split()[0] ) )

arguments: 
    - "-l"
    - $(inputs.message)