#!/bin/bash

for d in ~/.vim/pack/*
do 
        echo "[$(basename $d)]"
        cd $d

        for p in *[^start]
        do 
                echo "$p = \"$(cd $p && git config --get remote.origin.url && cd ..)\""
        done
        echo
done

