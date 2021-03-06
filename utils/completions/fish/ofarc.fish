complete -c ofarc -s a -l append -d 'Append to archive'
complete -c ofarc -s c -l create -d 'Create archive'
complete -c ofarc -s C -l directory -r -d 'Extract into the specified directory'
complete -c ofarc -s E -l encoding -x \
    -d 'The encoding used by the archive (only tar files)'
complete -c ofarc -s f -l force -d 'Force / overwrite files'
complete -c ofarc -s h -l help -d 'Show help'
complete -c ofarc -s l -l list -d 'List all files in the archive'
complete -c ofarc -s n -l no-clobber -d 'Never overwrite files'
complete -c ofarc -s p -l print -d 'Print one or more files from the archive'
complete -c ofarc -s q -l quiet -d 'Quiet mode (no output, except errors)'
complete -c ofarc -s t -l type -x -a 'gz lha tar tgz zip' -d 'Archive type'
complete -c ofarc -s v -l verbose -d 'Verbose output for file list'
complete -c ofarc -s x -l extract -d 'Extract files'
