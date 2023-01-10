<< doc

NAME -> NIRANJAN.R.SANSUDDI

DATE -> 26-12-2022

DESCRIPTION ->
1. To Provide Sign In / Sign Up Option to User.
2. In Sign Up User should choose a unique Username.
3. Once User is Sign Up, User should have option to take Test / Quit.
4. User choose to take Quiz. Question has to be given and 10 seconds to answer the same.
5. If Username not Provided any input default option has to be taken.
6. All Useranswer has to be collected and Result has to be displayed.
doc

#!/bin/bash
echo "Welcome to Command Line Test !!"
echo "Please select an Option"
echo "1. Sign Up."
echo "2. Sign In."
echo "3. Exit"
read Option
case $Option in
1)echo "You Have Choosen Sign Up !!!"
  echo "Please Type Your UserName : "
  read Username
  #Storing Username and Password to File.
  userarr=(`cat userarr.csv`)
  passwrdarr=(`cat passwr.csv`) 
  #Checking Wether USername exsits are Not
  Check=(`grep -c "$Username" userarr.csv`)
  while [ $Check -ge 1 ] 
  do
	  echo "UserName $Username already Taken".
	  echo "Please Type Your UserName : "
	  read Username
	  Check=(`grep -c "$Username" userarr.csv`)
  done
  echo $Username>>userarr.csv
  while [ $Passwrd != $RPasswrd ]
  do
	  echo "Enter Your Password :"
	  read -s Passwrd
	  echo "Please Re-confirm Your Password :"
	  read -s RPasswrd
	  if  [[ $Passwrd != $RPasswrd ]] 
	  then
		  echo "Password Doesnot Match !!!"
		  echo "Please Enter Your Password : "
		  read -s Passwrd
		  echo "Please Re-confirm Your Password :"
		  read -s RPasswrd
	  else
		  echo "Password Saved"
	  fi
  done
  echo $Passwrd>>passwr.csv ;;
2)echo "You Have Choosen Sign Up!!"
  echo "Welcome Back :)"
  userarr=(`cat userarr.csv`)
  passwrdarr=(`cat passwr.csv`)
  Check=0
  while [ $Check -eq 0 ]
  do
	 read -p "Enter Your Username :" username
	 Check=(`grep -xc "$username" userarr.csv`)
     if [ $Check -eq 1 ] 
	 then
		 for i in `seq 0 $((${#userarr[@]}-1))`
		 do
			 if [[ $username = ${userarr[$i]} ]]
			 then
				 Index=$i
			 fi
		 done
		 echo "Please Enter Your Password:"
	     read -s password
	     if [[ $password = ${passwrdarr[$Index]} ]] 
		 then 
		      echo "Sign In Sucess"
			  Check=1
			  Line_Count=`cat questions.txt | wc -l`
			  echo "Select an Option"
			  echo "1. Take test"
			  echo "2. Exit"
			  read Choice 
			  case $Choice in 

				  1)echo "										"Welcome $username"								"
					echo   
					echo "										"ALL THE BEST"									"         
              for i in `seq 5 5 $Line_Count`
			  do
			       echo 
				   head -$i questions.txt| tail -5
				   for i in `seq 10 -1 1`
				   do
					   echo -ne "\rEnter the Option :$i "
					   read -t 1 option
					   if [ -n "$option" ]
					   then 
						   echo $option|tr [A-Z] [a-z] >> useranswer.txt
						   break
					   else
						   option=e
					   fi
					   #echo $option |tr [A-Z] [a-z] >> useranswer.txt
				   done
		
			   done
		       echo -e "\n-----------------------------------------------------------------------------------------"
		       echo -e "\n<-----------------------------------RESULT PAGE------------------------------------------>"
			   correct_ans=(`cat corr_ans.txt`)
			   user_ans=(`cat useranswer.txt`)
			   total=0
			   m=0
			   for i in `seq 5 5 $Line_Count`
			   do
			       head -$i questions.txt| tail -5
				   if [[ ${user_ans[$m]} = ${correct_ans[$m]} ]]
				   then	   
						     echo  -e "Correct\n"
							 total=`expr $total + 1 `
					elif [[ ${user_ans[$m]} = "e" ]]
					then
						  echo "TimeOut"
					else
                          echo "Wrong Answer"
						  echo "Your Answer : Option - ${user_ans[$m]}"
						  echo -e "corrected Answer : Option -${correct_ans[$m]}\n"
				   fi
					   m=`expr $m + 1`

			    done
				 echo "Total = $total/10"
				 rm useranswer.txt
			   ;;

		   2) break
			   ;;
	           esac
		 else
	          echo "Bad Creditionals"
	          Check=0
		 fi
	 else 
	        echo "Username not Exsit"
	        Check=0		
	 fi
  done	 
  ;;
3) 
	;;
esac
		   
