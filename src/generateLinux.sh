#!/bin/bash

# Create header snippet file
function headerFile () {
    echo "{" > ${2}
    echo "	\"${1}\": {" >> ${2}
    echo "		\"prefix\": \"${1}\"," >> ${2}
    echo "		\"body\": [" >> ${2}
}


# Create body snippet file
function bodyFile () {
    while IFS= read -r line
    do
        newLine=${line//    /"\t"}
        newLine=${newLine//"\""/'\"'}

        echo "          \"${newLine}\"," >> ${2}
    done < models/$1
}


# Create footer snippet file
function footerFile () {
    echo "        ]" >> ${1}
    echo "    }" >> ${1}
    echo "}" >> ${1}
}

echo "Iniciado criacao de snippets..."
echo ""

for file in `ls models/`
do
    filename="$(cut -d '.' -f1 <<< "$file")"
    snippetFile="snippets/${filename}.code-snippets"

    headerFile $filename $snippetFile
    bodyFile $file $snippetFile
    footerFile $snippetFile

    echo "Snippet ${snippetFile} criado!"
done

echo ""
echo "Copiando snippets para pasta do VSCode..."
cp snippets/* /home/$USER/.config/Code/User/snippets/

echo ""
echo "Finalizado!"

