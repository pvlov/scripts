#!/bin/bash

# Check if at least one argument is provided
if [ $# -lt 1 ]; then
  echo "Usage: $0 <Project Name>"
  exit 1
fi

# Access the first argument
project_name="$1"

# Create Project-Folder
mkdir $project_name
cd $project_name

# Create Folder for source code
mkdir src

# Add Hello World
touch src/main.c

echo "
#include <stdio.h>

int main(void) 
{
	printf(\"Hello World!\n\");
	return 0;
}

"> src/main.c

# Create format Guidelines
touch .clang-format  
echo -e "--- \n BasedOnStyle: WebKit" > .clang-format

# Create Makefile and add building, running, formatting and cleaning
touch Makefile
echo -e "
CFlags = -Wall -Wextra -O3
BIN_NAME = $project_name  
build:
	@clang \$(CFLAGS) src/*.c -o \$(BIN_NAME)
run:
	@make build
	@./\$(BIN_NAME)
clean:
	@rm \$(BIN_NAME)
format:
	@clang-format -i src/*.c	
		
.PHONY: build run clean format 
" > Makefile 
git init
