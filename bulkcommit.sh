##This Shell Script is for creating bulk commits on the fly. ##
## Current Working Directory ##
echo "Present Working Directory is >> "$PWD

#I need to write code logic for deleting/creating folders for the bulk commit
echo "Do you want to re-create(previous data will be shreaded) 'BulkCommitDir' folder? (y/n) >> "
read createNewDirectoryFlag

if [ ${createNewDirectoryFlag} == "y" ] || [ ${createNewDirectoryFlag} == "yes" ]; then
    #echo "your answer is '$createNewDirectoryFlag'"
    directoryRecreateCmd="rm -rf BulkCommitDir && mkdir BulkCommitDir"
    echo "Recreating 'BulkCommitDir' folder........."
    eval "$directoryRecreateCmd"
else
    echo "Folder Recreation skipped...."
fi

# Function to create multiple commits
createNewCommits() {
    x=1
    while [ $x -le $totalCommitCount ]; do
        echo "-------  Creating File -------> $x"
        current_time=$(date "+%Y_%m_%d_%H_%M_%s")
        echo "Current Time : $current_time"
        command="echo 'randfile_$x_$current_time' >> BulkCommitDir/randfile_'$x'_$current_time.txt && git add . && git commit -m '$x:randfile_$current_time.txt'"
        echo $command
        eval "$command"

        latestCommitSHAValueCommand="git rev-parse HEAD"
        echo "Latest Commit SHA >> '$latestCommitSHAValueCommand'"
        eval "$latestCommitSHAValueCommand"

        x=$(($x + 1))
        sleep .001
        # echo "\tWaiting for 1 sec."
    done
}

# Conditional Check for the total commits to be done.
echo "Enter, How many new commits you want? "
read totalCommitCount

if [ ${totalCommitCount} -le 0 ]; then
    echo "Zero or Negative Input, No commits to happen."
elif [ ${totalCommitCount} -gt 5000 ]; then
    echo "Input is more than 5000, Please input a positive integer less than 5000"
else
    echo "'${totalCommitCount}' new commits in progress."
    createNewCommits
    echo "'${totalCommitCount}' new commits are created..... "
fi
