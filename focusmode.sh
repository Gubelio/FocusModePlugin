



source focusconfig.properties
edit_file=testreader.txt

if [ $allowed_to_operate -eq 1 ]; then
    while [ $allowed_to_operate -eq 1 ]
    do
        ps_output=$(ps -ef | grep [s]uperproductivity)
        length=${#ps_output}

        if [ $length -gt 0 ]; then
            for value in "${websites[@]}"                  
            do  
                stringval="0.0.0.0 $value"
                line=$(grep -n "$stringval" $edit_file | cut -d : -f 1)
                custom_start=$(grep -n "#customblocks" $edit_file | cut -d : -f 1)
                if [ ! -z $line ]; then
                    sed -i "$line d" $edit_file
                    sed -i "$line i 0.0.0.0 $value" $edit_file
                else
                    newline=$(($custom_start + 1))
                    sed -i "$newline i 0.0.0.0 $value" $edit_file
                fi

            done
    
        fi

        if [ $length -eq 0 ]; then
            for value in "${websites[@]}"                  
            do  
                stringval="0.0.0.0 $value"
                line=$(grep -n "$stringval" $edit_file | cut -d : -f 1)
                if [ ! -z $line ]; then
                    sed -i "$line d" $edit_file

                fi

            done

        fi
        
        sleep $update_frequency
    done

else    
    exit
fi

### EXPLANATION

# ps_output stringifies the output of the following command

    #ps -ef is a longform (-f) readout of all (-e) running processes. grep is a regex searcher through this output. 
    #the [s] is to make sure that grep doesn't find its own execution, as it will find only then strings, not regexes
    # length simply makes the string an int




