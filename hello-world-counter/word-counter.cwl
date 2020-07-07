#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow

inputs:
  message: string

steps:
  echo_message:
    run: echo.cwl
    in:
      message: message
    out: [words]

  # count:
  #   run: wc.cwl
  #   in:
  #     message: echo_message/words
  #   out: [word_count]
  

# outputs:
#   word_count:
#     type: File
#     outputSource: count/word_count







##################

#   convert:
#     run: contents_parser.cwl
#     in: 
#       word_file: count/word_count
#     out: [number_of_words]
# outputs:
#   number_of_words:
#     type: int
#     outputSource: convert/number_of_words


##################

##################
  count:
    run: wc-int.cwl
    in:
      message: echo_message/words
    out: [word_count]

outputs:
  word_count:
    type: int
    outputSource: count/word_count
##################