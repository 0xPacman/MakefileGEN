# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    makegen.sh                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ahjadani <ahjadani@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/05/22 18:31:40 by ahjadani          #+#    #+#              #
#    Updated: 2022/05/22 18:54:45 by ahjadani         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' 


echo "${RED}Makefile Generator${NC}"
echo ""
read -p "Compiler: " compiler
read -p "Enter the name of the program: " program
read -p "Enter additional flags: " xflags
read -p "Enter files sperated by space: " files
read -p "Enter the header file: " header

if [ -z "$files" ]; then
	files=$(find . -name "*.c" -print | tr '\n' ' '| sed 's/\.\///g')
fi

if [ -z "$compiler" ]; then
	compiler="gcc"
fi

if [ -z "$program" ]; then
	program="program"
fi

if [ -z "$header" ]; then
	files=$(find . -name "*.h" -print | tr '\n' ' '| sed 's/\.\///g')
fi

echo "
CC = ${compiler}
CFLAGS = -Werror -Wextra -Wall 
FILES = ${files}
OBJECTS = \$(FILES:.c=.o)
NAME = ${program}
XFLAGS = ${xflags}
HEADER = ${header}
RM = rm -f

all: \$(NAME)

\$(NAME): \$(OBJECTS)
	\$(CC) \$(CFLAGS) \$(OBJECTS) -o \$(NAME) \$(XFLAGS)

%.o:%.c \$(HEADER)
	\$(CC) \$(CFLAGS) -c \$< -o \$@

clean:
	\$(RM) \$(OBJECTS)

fclean: clean
	\$(RM) \$(NAME)

re: fclean all

.PHONY: all, clean, fclean, re

" > Makefile

echo "${BLUE}Compiling...${NC}"

make
