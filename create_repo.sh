#/bin/bash

function packing {

IFS='.' #Internal Field Seperator S pour couper le nom du fichier

if [ "$1" = "Makefile" ]
then
    return  #Makefile
else
    set $1 #reduit le nom du fichier pour avoir juste apres le point
    if [ "$2" = "c" ] # $2 représente ce qui est écrit après le point
    then
        return #C
    elif [ "$2" = "java" ]
    then
        return #java
    elif [ "$2" = "sh" ]
    then
        return #bash
    fi 
fi
echo "Nombres de paramètres : $#"
echo "premier parametre : $1"
echo "deuxieme parametre : $2"
}

if [ "$1" = "-h" ]
then
    echo ""
    echo "Prepares your GitHub repository Java/C/Bash projects :" 
    echo "\$1 is the project name"
    echo ""
    exit 0
fi

name=false

if ! [ -z "$1" ] # if there is no project name, the program will only do the bare minimum
then
    name=true
fi

if [ name=true ] 
then
    echo "Clone from git?"
    read 

    if [ $REPLY = "y" -o $REPLY == "Y" ]
    then
        echo "Which git?"
        read
        git clone git@github.com:$REPLY/$1
    else
        mkdir $1
    fi

    cd $1 #Go in the newly created folder
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

#Packing of Makefile
packing Makefile

# Check si le nom du projet à été donné
if [ name=true ]
then
    echo "The projet is in which language?"
    read

    echo "$REPLY"
    if [ $REPLY = "c" -o $REPLY = "C" ]
    then #C project
        touch include/$1.h #!Creation of .h
        touch src/$1.c #!Creation of .c

        #Packing of src
        packing src/$1.c

    elif [ $REPLY = "java" -o $REPLY = "Java" ]
    then #Java project
        touch src/$1.java #!Creation of .java

        #Packing of src
        packing src/$1.java

    elif [ $REPLY = "bash" -o $REPLY = "Bash" -o $REPLY = "sh"]
    then #Bash project
        touch src/$1.sh #Creation of .sh

        #Packing of src
        packing src/$1.sh

    else
        echo "Je ne connais pas encore ce language!"

    fi
else 
    echo "Les fichiers n'ont pas été crées"
fi



echo "done!"