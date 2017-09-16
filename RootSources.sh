#!/bin/bash

if [ "$1" == "-h" ]; then
    echo "Use of " $0 " Version.of.ROOT Build_Of-ROOT"
    echo "Ejem " $0 "5.28.00 x86_64-centos7-gcc49-opt"
    exit 1
fi

#See wich versions of root are instaled
Versions=($(ls /afs/cern.ch/sw/lcg/app/releases/ROOT/))

#See if the argument of the function is empty
if [ -z $1 ]; then 
 
   #Shows the avaible versions
    echo "Versions avaible:" 
    echo ${Versions[@]}
    
    
#While for the decition of the user
    while true; 
    do
    #read de version from the input
	read -p "Select the version: " Version
	
    #Compare the version read, to the versions avaible
	flagVersion=false    
	for Ver in "${Versions[@]}"
	do
	    if [ "$Ver" == "$Version" ]; then
		flagVersion=true
		break
	    fi
	done
	
    #Shows the Builds avaibles in the Version chosen 
	if [ "$flagVersion" = true ]; then
	    Builds=($(ls /afs/cern.ch/sw/lcg/app/releases/ROOT/$Version/))
	    break
	else 
	    echo "Select a valid version"
	    echo "Versions avaible:" 
	    echo ${Versions[@]}  
	fi
    done
    
    echo "The Builds avaible: "
    echo ${Builds[@]}

    while true; 
    do
	
	read -p "Select the Build: " Build
	
	flagBuild=false
	
	for Bui in "${Builds[@]}"
	do
	    if [ "$Bui" == "$Build" ]; then
		flagBuild=true
		break
	    fi
	done
	
	if [ "$flagBuild" == "true" ]; then
	    Path=/afs/cern.ch/sw/lcg/app/releases/ROOT/$Version/$Build/root/bin/thisroot.sh
	    break
	else 
	    echo "Select a valid build"
	    echo "Builds avaible:" 
	    echo ${Builds[@]}
	fi
	
    done

else #If there are arguments "RootSources.sh 5.28.00 x86_64-centos7-gcc49-opt"

    #see if the first argument is a valid version   
    #While for the Version
    #read de version from the argument
    Version=$1  
    while true; 
    do
        #Compare the version read, to the versions avaible
	flagVersion=false    
	for Ver in "${Versions[@]}"
	do
	    if [ "$Ver" == "$Version" ]; then
		flagVersion=true
		break
	    fi
	done
	
        #Save the Builds avaibles in the Version chosen 
	if [ "$flagVersion" = true ]; then
	    Builds=($(ls /afs/cern.ch/sw/lcg/app/releases/ROOT/$Version/))
	    break
	else 
	    echo "Select a valid version"
	    echo "Versions avaible:" 
	    echo ${Versions[@]}
            #read de version from the input
	    read -p "Select the version: " Version
	fi
    done
    
    #Use the bulid from the comand line
    Build=$2
    #While for the Build
    while true; 
    do
	#Compare build to the builds avaible
	flagBuild=false
	for Bui in "${Builds[@]}"
	do
	    if [ "$Bui" == "$Build" ]; then
		flagBuild=true
		break
	    fi
	done
	
	if [ "$flagBuild" = true ]; then
	    Path=/afs/cern.ch/sw/lcg/app/releases/ROOT/$Version/$Build/root/bin/thisroot.sh
	    break
	else 
	    echo "Select a valid build"
	    echo "Builds avaible:" 
	    echo ${Builds[@]}
	    #Read the build from the imput
	    read -p "Select the Build: " Build
	fi
    done
fi
############################################
# Use the configurations
############################################
echo "source $Path"
eval "source $Path" 
