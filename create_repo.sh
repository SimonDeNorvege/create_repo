#/bin/bash

function packing {  #fonction de remplissage de fichier

IFS='.' #Internal Field Seperator pour couper le nom du fichier

if [ "$1" = "Makefile" ]
then
    set $1
    packing_makefile  #Makefile
else
    if [ "$2" = "c" ] # $2 représente ce qui est écrit après le point
    then
        packing_C #C
    elif [ "$2" = "java" ]
    then
        packing_java #java
    elif [ "$2" = "sh" ]
    then
        packing_sh #bash
    fi 
fi
}

<< 'Comment'
    the packing function starts here, these are the functions 
    that fill the files created during the repository creation
Comment

function packing_makefile { #fonction de remplissage de Makefile 

echo "##" > Makefile
echo -n "## PROJECT, " >> Makefile
date +"%d %m %Y" >> Makefile
echo "## Makefile" >> Makefile
echo "## File description:" >> Makefile
echo "## $project_name" >> Makefile
echo "##" >> Makefile
echo >> Makefile

if [ $operand = "c" -o $operand = "C" ] # C project
then
    echo "SRC = $project_name.c" >> Makefile
    echo >> Makefile
    echo "NAME = $project_name" >> Makefile
    echo >> Makefile
    echo "OBJ = \$(SRC:.c=.o)" >> Makefile
    echo >> Makefile
    echo "CFLAGS =	-W -Wall -std=gnu11 -Wextra -I include/ -g" >> Makefile
    echo >> Makefile
    echo "all: 	\$(NAME)" >> Makefile
    echo >> Makefile 
    echo "\$(NAME): \$(OBJ)" >> Makefile
    echo "	gcc -o \$(NAME) \$(OBJ) \$(CFLAGS)" >> Makefile
    echo >> Makefile
    return

elif [ $operand = "Java" ] # Java Project
then
    rm Makefile
elif [ $operand = "Bash" ] # Bash Project
then
    rm Makefile
fi
}

function packing_C { #fonction de remplissage des fichiers C
echo "Writing in C file..."
echo "/*" > src/$project_name.c
echo "** PROJECT, 2022" >> src/$project_name.c
echo "** $project_name.c" >> src/$project_name.c
echo "** File description:" >> src/$project_name.c
echo "** $project_name" >> src/$project_name.c
echo "*/" >> src/$project_name.c
echo >> src/$project_name.c
echo "int main(int argc, char **argv)" >> src/$project_name.c
echo "{" >> src/$project_name.c
echo >> src/$project_name.c
echo "}" >> src/$project_name.c

echo "Writing in Header file..."
echo "/*" > include/$project_name.h
echo "** PROJECT, 2022" >> include/$project_name.h
echo "** $project_name.h" >> include/$project_name.h
echo "** File description:" >> include/$project_name.h
echo "** $project_name" >> include/$project_name.h
echo "*/" >> include/$project_name.h
echo >> include/$project_name.h
echo "#ifndef $project_name" >> include/$project_name.h
echo "#define $project_name" >> include/$project_name.h
echo >> include/$project_name.h
echo "#endif /* ! $project_name */" >> include/$project_name.h

return
}

function packing_java { #fonction de remplissage du fichier Java
echo "Writing in java file..."
echo "/*" > src/$project_name.java
echo "** PROJECT, 2022" >> src/$project_name.java
echo "** $project_name.java" >> src/$project_name.java
echo "** File description:" >> src/$project_name.java
echo "** $project_name" >> src/$project_name.java
echo "*/" >> src/$project_name.java
echo
}

function packing_sh { #fonction de remplissage du fichier Bash
echo "Writing in bash file..."
echo "#/bin/bash" > src/$project_name.sh
echo
return
}

# the file packing ends here

# /!\ start of the function /!\

if [ "$1" = "-h" ]
then
    echo
    echo "/                                                        \\"
    echo "|Prepares your GitHub repository : Java/C/Bash projects :|" 
    echo "|\$1 is required and is the project name                                  |"
    echo "\\                                                        /"
    echo
    exit 0
fi








# START OF THE FUNCTION
# Pull the folder from the git

project_name=project_name

if ! [ -z "$1" ] # if there is no project name, the program will only do the bare minimum
then
    project_name=$1    
fi

mkdir "$project_name"
cd $project_name
# echo "le premier arguent est : [$1]"

if [ "$project_name" != "False" ] 
then
    echo "Clone from git?"
    read $REPLY

    if [ $REPLY = "y" -o $REPLY == "Y" ]
    then
        echo "Which git?"
        read file_name #FINALLY
        git clone git@github.com:$file_name/$project_name
        if [ ! -e "$project_name" ]
        then
            echo $project_name
            mkdir $project_name # au cas au git ne marche pas
            echo "Hasn't been able to connect to your git repository, creating one"
            cd $project_name
        else
            cd $project_name
        fi
    fi
else
    mkdir Project_folder
    cd Project_folder #Go in the newly created folder
fi

#Creation of folders

if [ -e src ]
then
    echo "le dossier 'src' existe déjà"
else
    mkdir src
fi

if [ -e include ]
then
    echo "le dossier 'include' existe déjà"
else
    mkdir include
fi

if [ -e lib ]
then
    echo "le dossier 'lib' existe déjà"
else
    mkdir lib
fi

#Creation and shift of 'my'
if [ -e lib/my ]
then
    echo "le dossier 'my' existe déjà"
else
    mkdir my
    mv my lib
fi

#Creation of Makefile
touch Makefile

# Check si le nom du projet à été donné
if [ name=true ]
then
    echo "The projet is in which language?"
    read operand

    #Packing of Makefile
    packing Makefile

    if [ $operand = "c" -o $operand = "C" ]
    then #C project
        operand="c"

        touch include/$project_name.h #!Creation of .h
        touch src/$project_name.c #!Creation of .c
        
        #Packing of src
        packing_C src/$project_name.c

    elif [ $operand = "java" -o $operand = "Java" ]
    then #Java project
        operand="java"

        touch src/$project_name.java #!Creation of .java

        #Packing of src
        packing_java src/$project_name.java

    elif [ $operand = "bash" -o $operand = "Bash" -o $operand = "sh" ]
    then #Bash project
        operand="sh"

        touch src/$project_name.sh #Creation of .sh

        #Packing of src
        packing_sh src/$project_name.sh

    else
        echo "Je ne connais pas encore ce language!" #Erreur 

    fi  
else 
    echo "Les fichiers n'ont pas été crées"
fi



echo "done!"