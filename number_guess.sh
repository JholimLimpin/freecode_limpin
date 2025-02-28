#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

echo "Enter your username:"
read USERNAME

USER_ID=$($PSQL "SELECT user_id FROM users WHERE username = '$USERNAME'")

if [[ -z $USER_ID ]]; then
  INSERT_USER=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME')")
  USER_ID=$($PSQL "SELECT user_id FROM users WHERE username = '$USERNAME'") # Retrieve new user_id
  echo "Welcome, $USERNAME! It looks like this is your first time here."
else
  GAMES_PLAYED=$($PSQL "SELECT COUNT(*) FROM games WHERE user_id = $USER_ID")
  BEST_GAME=$($PSQL "SELECT MIN(number_guesses) FROM games WHERE user_id = $USER_ID")

  if [[ -z $BEST_GAME ]]; then
    BEST_GAME="N/A"
  fi
  
  echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
fi

RANDOM_NUM=$((1 + $RANDOM % 1000))
GUESS=1

echo "Guess the secret number between 1 and 1000:"

while read NUM; do
  if [[ ! $NUM =~ ^[0-9]+$ ]]; then
    echo "That is not an integer, guess again:"
  else
    if [[ $NUM -eq $RANDOM_NUM ]]; then
      break
    elif [[ $NUM -gt $RANDOM_NUM ]]; then
      echo "It's lower than that, guess again:"
    else
      echo "It's higher than that, guess again:"
    fi
  fi
  ((GUESS++))
done

echo "You guessed it in $GUESS tries. The secret number was $RANDOM_NUM. Nice job!"

if [[ -n $USER_ID ]]; then
  INSERT_GAME=$($PSQL "INSERT INTO games(user_id, number_guesses) VALUES($USER_ID, $GUESS)")
else
  echo "Error: Could not retrieve user ID. Game result not saved."
fi

