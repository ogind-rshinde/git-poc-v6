#!/bin/bash
USERNAME="ogind-rshinde"

echo "$(tput setaf 2) Which type of branch you want create: 
1 - feature branch
2 - Dev bug branch
3 - QA bug branch
4 - hotfixes bug branch 
5 - Intermidate branch"
read -p "Choose the number : "  branchOption

#echo "Welcome $branchOption!

branch=$(git symbolic-ref HEAD | sed -e 's,.*/\(.*\),\1,')
echo "current branch is : $branch"
read -p "Please enter branch name : "  branchName
echo "$(tput setaf 3)"

if test "$branchOption" = 1; then
    git checkout main
    git pull origin main
    git checkout -b "feat-"$USERNAME"/$(date +'%Y-%m-%d')/"$branchName  
fi

if test "$branchOption" = 2; then
    git checkout main
    git pull origin main
    git checkout -b "dvbg-"$USERNAME"/$(date +'%Y-%m-%d')/"$branchName  
fi

if test "$branchOption" = 3; then
    git checkout release/next
    git pull origin release/next  
    git checkout main
    git pull origin main      
    git checkout -b "qabg-"$USERNAME"/$(date +'%Y-%m-%d')/"$branchName 
    git reset --hard release/next    
fi

if test "$branchOption" = 4; then
    git checkout hotfix/next
    git pull origin hotfix/next 
    git checkout -b "hfbg-"$USERNAME"/$(date +'%Y-%m-%d')/"$branchName
fi

if test "$branchOption" = 5; then
    git checkout main
    git pull origin main 
    git checkout -b "inter-/$(date +'%Y-%m-%d')/"$branchName
fi

echo "$(tput setaf 2) ************************************************
********** Branch is created successfully ****************************"