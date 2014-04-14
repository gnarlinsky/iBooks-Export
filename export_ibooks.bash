#!/usr/bin/env bash

# create dir to hold converted ebooks, if it doesn't exist already
path_to_converted_ebooks=~/Desktop/exported_iBooks_epubs;
if [ ! -d $path_to_converted_ebooks ]; then
    mkdir $path_to_converted_ebooks;
fi

# path to ibooks
path_to_ibooks=~/Library/Containers/com.apple.BKAgentService/Data/Documents/iBooks/Books/

# copy the entire iBooks Books directory, and work from within that
cp -r $path_to_ibooks $path_to_converted_ebooks/original_iBooks_epubs

# all epubs
cd $path_to_converted_ebooks/original_iBooks_epubs
all_epubs=*.epub

for epub_file in $all_epubs; do

    # zip up conents
    echo -e "\nZipping contents of $epub_file...";
    cd $epub_file;
    zip -r -q $epub_file.zip .;

    # extract just the title itself
    echo "Attempting to get title..."

    # If there's an .opf, try to parse out the title. If that doesn't work, try
    # same thing with an .ncx, if it exists. If not, use dir name.
    title="";
    if [ -f *.opf ]; then
        title_element=`cat *.opf | grep '<meta name="calibre:title_sort" content='`;
        if [ ! -z "$title_element" ]; then
           title=`echo $title_element | cut -d '"' -f 4`;
        fi
    else
        if [ -f *.ncx ]; then
            title_element=`cat *.ncx | grep '<docTitle><text>.*</text></docTitle>'`;
            if [ ! -z "$title_element" ]; then
                title=`echo $title_element | cut -d '>' -f 3 | cut -d '<' -f 1`;
            fi
        fi
    fi

    if [ -z "$title" ]; then
        # use dir name except the for ".epub"
        title=`echo ${epub_file%?????}`;
    fi

    # if title is same as another, use the dir name
    if [ -f "$path_to_converted_ebooks/$title.epub" ]; then
        title=`echo ${epub_file%?????}`;
    fi

    # move zip out of the epub dir into the one created earlier, naming it with the real title
    echo "Moving $epub_file.zip to $path_to_converted_ebooks/$title.epub...";
    mv $epub_file.zip "$path_to_converted_ebooks/$title.epub";

    # back up out of the directory
    cd ..
done
