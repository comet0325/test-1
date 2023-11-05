#! /bin/bash
echo "User Name: KimJiHun"
echo "Student Numver: 12191582"
echo "[ MENU ]"
echo "1. Get the data of the movie identified by a specific 'movie id' from 'u.item'"
echo "2. Get the data of action genre movies from 'u.item'"
echo "3. Get the average 'rating' of the movie identified by specific 'movid id' from 'u.data'"
echo "4. Delete the 'IMDb URL' from 'u.item'"
echo "5. Get the data about users from 'u.item'"
echo "6. Modify the format of 'release date' in 'u.item'"
echo "7. Get the data of movies rated by a specific 'user id' from 'u.data'"
echo "8. Get the average 'rating' of movies rated by users with 'age' between 20 and 29 and 'occupation; as 'programmer'"
echo "9. Exit"
echo "-----------------------------------------"
while true
do
read -p "Enter your choice [ 1-9 ] " function
case $function in
1)
	read -p "Please enter the 'movie id'(1~1682):" movieId
	cat $1| awk -F\| -v movieId=$movieId '$1==movieId {print}'
	;;
2)
	read -p "Do you want to get the data of 'action' genre movies from 'u.item'?(y/n) :" choice
	if [ $choice = "y" ]
	then
		 cat $1| awk -F\| '$7==1 && count < 10  {print $1, $2; count++}'
	else
		continue
	fi
	;;
3)
	read -p "Please enter the 'movie id' (1~1682):" movieId
	cat $2| awk -v movieId=$movieId '$2==movieId {totalRating+=$3; viewers++} END {print "average rating of "movieId ": "totalRating/viewers}'
	;;
4)
	read -p "Do you want to delete the 'IMDb URL' from 'u.item'?(y/n):" choice
	if [ $choice = "y" ]
	then
		cat $1| awk -F\| 'count < 10 {print; count++}'| sed -E 's/http[^)]*//g'
	else
		continue
	fi
	;;
5)
	read -p "Do you want to get the data about users from 'u.user'?(y/n)" choice
	if [ $choice = "y" ]
	then
		cat $3| awk -F\| 'count < 10 {print "user " $1 " is " $2 "years old " $3 " " $4; count++}' | sed -e 's|M|male|g' -e 's|F|female|g'
	else
		continue
	fi
	;;
6)
	read -p "Do you want to Modify the format of 'release data'in 'u.item'?(Y/n)" choice
	if [ $choice = "y" ]
	then
		cat $1| tail -n 10|  awk -F\| '{print}'| sed -E 's/([1-9]+)-([A-Z]+)-([1-9]+)/\3\2\1/'
	else
		continue
	fi
	;;
7)
	read -p "Please enter the 'user id'(1~943):" userId
	;;
8)
	read -p "Do you want to get the average 'rating' of movies rated by users with 'age' between 20 and 29 and 'occupation' as 'programmer'?(y/n)" choice
	if [ $choice = "y" ]
	then
		break	
	else
		continue
	fi
	;;
9)
	echo "Bye!"
	break
;;
esac
done
