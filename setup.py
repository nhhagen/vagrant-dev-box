#!/usr/bin/env python

import argparse
import subprocess
import shutil
import os


def setup(args):
    origin = args.origin
    project_dir = os.path.abspath(args.directory)
    shutil.copytree('.', project_dir)

    remove_files = [
        '.git',
        'setup.sh',
        'setup.py',
        'LICENSE'
    ]

    for filename in remove_files:
        filepath = os.path.join(project_dir, filename)
        if os.path.isfile(filepath):
            os.remove(filepath)
        elif os.path.isdir(filepath):
            shutil.rmtree(os.path.join(project_dir, filename))

    subprocess.call('git init', shell=True, cwd=project_dir)
    subprocess.call('git remote add origin ' + origin, shell=True,
                    cwd=project_dir)
    subprocess.call('git add -A .', shell=True, cwd=project_dir)
    subprocess.call('git commit -m "Initial commit"', shell=True,
                    cwd=project_dir)
    subprocess.call('git push --set-upstream origin master', shell=True,
                    cwd=project_dir)

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-d', '--directory',
                        help='The new directory for the project',
                        required=True)
    parser.add_argument('-o', '--origin', help='The git remote for the project',
                        required=True)
    args = parser.parse_args()
    setup(args)
