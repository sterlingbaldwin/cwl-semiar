cwlVersion: v1.0
class: CommandLineTool
baseCommand: python
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: get_datasets.py
        entry: |
          import os
          import sys
          import argparse

          def walk_datasets(path, variable):
              for root, dirs, files in os.walk(path):
                  if dirs:
                      continue
                  if not files:
                      continue
                  tail, head = os.path.split(root)
                  if variable not in tail:
                      continue
                  versions = sorted(os.listdir(tail))
                  if head != versions[0]:
                      continue
                  yield root
          
          def main():
              parser = argparse.ArgumentParser()
              parser.add_argument('--path', required=True)
              parser.add_argument('--variable', required=True)
              args = parser.parse_args()
              for path in walk_datasets(args.path, args.variable):
                  print(path)
              return 0

          if __name__ == "__main__":
              sys.exit(main())
arguments:
  - get_datasets.py

inputs:
  cmip_root:
    type: string
    inputBinding:
      prefix: --path
  variable:
    type: string
    inputBinding:
      prefix: --variable
outputs:
  datasets: stdout
stdout: datasets.txt
