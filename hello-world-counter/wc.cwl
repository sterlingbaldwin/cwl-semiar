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
  word_count: stdout

arguments: 
    - "-l"
    - $(inputs.message)