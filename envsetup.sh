#!/bin/bash 

if [ -d "env" ]
then
echo "python venv exists"
else
echo "python venv does not exist"
python3 -m venv env
fi 
echo $PWD 
source env/bin/activate
echo $PWD 
pip install -r requirements.txt

if [ -d "env" ]
then
echo "log folder exists"
else
echo "log folder not exist"
mkdir logs 
touch logs/error.log logs/acess.log
fi 
chmod +R 777 logs 
echo "env setup complete"
