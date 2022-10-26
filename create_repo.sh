#/bin/bash

function packing {  #fonction de remplissage de fichier

IFS='.' #Internal Field Seperator pour couper le nom du fichier

if [ "$1" = "Makefile" ]
then
    packing_makefile  #Makefile
else
    set $1 #reduit le nom du fichier pour avoir juste apres le point
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
return
}

function packing_C { #fonction de remplissage des fichiers C
return
}

function packing_java { #fonction de remplissage du fichier Java
return
}

function packing_sh { #fonction de remplissage du fichier Bash
return
}

# the file packing ends here

if [ "$1" = "-h" ]
then
    echo ""
    echo "Prepares your GitHub repository : Java/C/Bash projects :" 
    echo "\$1 is the project name"
    echo ""
    return 0
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
        echo "Je ne connais pas encore ce language!" #Erreur 

    fi
else 
    echo "Les fichiers n'ont pas été crées"
fi



echo "done!"
return 0