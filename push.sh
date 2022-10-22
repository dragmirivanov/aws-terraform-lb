#!/bin/bash

git add .
echo "Enter commit message: "
read answer
git commit -m "$answer"
git push
