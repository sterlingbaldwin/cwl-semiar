import os
import sys
import argparse

def walk_datasets(path: str):
    for root, dirs, files in os.walk(path):
        if dirs:
            continue
        if not files:
            continue
        tail, head = os.path.split(root)
        versions = sorted(os.listdir(tail))
        if head != versions[0]:
            continue
        yield root
        
def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--path', required=True)
    args = parser.parse_args()

    for path in walk_datasets(args.path):
        print(path)
    return 0

if __name__ == "__main__":
    sys.exit(main())