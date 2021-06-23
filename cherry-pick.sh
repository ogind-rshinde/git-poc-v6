#!/bin/bash

BRANCH=$(git rev-parse --abbrev-ref HEAD)
echo "Your current branch is $BRANCH"

branchType=${BRANCH:0:3}
if [[ "$branchType" == "Fea" ]]
then
    parentBranch='main'
fi

if [[ "$branchType" == "Bug" ]]
then
    parentBranch='release/next'
fi

if [[ "$branchType" == "Esn" ]]
then
    parentBranch='hotfix/next'
fi


if [[ "$BRANCH" != "$parentBranch" ]]
then
    echo " condition is matched, branch is updating ************   "
    git checkout $parentBranch
    git pull origin $parentBranch
    git checkout $BRANCH
    git pull origin $BRANCH
fi

commitIdArr=$(git log --pretty=format:"%h" -30)

parentBranchCommitId=$(git log origin/$parentBranch --pretty=format:"%h" -1)

isExist=$(git branch --contains $parentBranchCommitId | grep $BRANCH)

echo "Commit Id is $isExist on that branch"

if [[ "$isExist" == "" ]]
then
    echo "Invoke the rebase......"
    git rebase $parentBranch
    git push origin $BRANCH -f
    echo "$(tput setaf 2) **************** Rebase is successfully completed *************************"
else
    echo "$(tput setaf 2) ************************************************
        ********** Your branch does not require rebase   ****************************"
fi


# PARENT_COMMIT_ID=$(git reflog --pretty=format:"%h" $BRANCH | tail -n 1)
# echo $PARENT_COMMIT_ID
# echo "**********************************"
# for j in $(git reflog origin/main --pretty=format:'%h')
# do
#   echo "$j"
# done