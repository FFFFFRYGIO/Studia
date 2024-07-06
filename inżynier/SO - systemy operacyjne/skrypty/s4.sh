#!/bin/bash
if [[ -f $1 || -d $1 ]]; then
    name=$( basename $1 ) #otherwise: tr "^.*/"
    user=$( stat -c '%A' $1 | cut -c 2-4 )
    group=$( stat -c '%A' $1 | cut -c 5-7 )
    all=$( stat -c '%A' $1 | cut -c 8-10 )
    owner=$( stat -c '%U' $1 )
    if [ -f $1 ]; then
        echo "File name: $name"
        echo "User permissions: $user"
        echo "Group permissions: $group"
        echo "All remaining users permissions: $all"
        echo "Owner: $owner"
    else
        echo "Catalog name: $name"
        echo "User permissions: $user"
        echo "Group permissions: $group"
        echo "All remaining users permissions: $all"
        count=$( ls $1 | wc -l )
        echo "Number of objects in catalog: $count"
        objlist=$( ls $1 | tr '\n' ',' | sed 's/\,/, /g')
        content=${objlist:0:-2}
        echo "Catalog content: $content"
    fi
fi