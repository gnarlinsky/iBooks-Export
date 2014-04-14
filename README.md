Export iBook epubs
===================

Quick and dirty Bash script to export iBook-format epubs to normal epubs. Creates a directory
`~/Desktop/exported_iBooks_epubs/` containing the converted epubs.

*The assumed OS X version is Mavericks, so the hardcoded path to the epubs is `~/Library/Containers/com.apple.BKAgentService/Data/Documents/iBooks/Books`. To change the location, change the `path_to_ibooks` variable.*

iBooks stores the epubs in directories with unique names (e.g. "47A0E879EC8AD43F48DE15A6CC75CA95"), so the script attempts to obtain the actual title of the book from the directory contents, but since that's not a straightforward task (where metadata stored -- or even if it's stored correctly -- is not consistent across epub directories), no guarantees on that.


``` bash
$ bash export_ibooks.bash

Zipping contents of 47A0E879EC8AD43F48DE15A6CC75CA95.epub...
Attempting to get title...
Moving 47A0E879EC8AD43F48DE15A6CC75CA95.epub.zip to ~/Desktop/exported_iBooks_epubs/Great North Road.epub...

Zipping contents of 972D61DEACA29531610F65DB2CC82701.epub...
Attempting to get title...
Moving 972D61DEACA29531610F65DB2CC82701.epub.zip to ~/Desktop/exported_iBooks_epubs/Year’s Best Science Fiction, The.epub...
```
