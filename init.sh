#!/bin/bash

echo -e "\033[0;31mNOTE\033[0m The script will delete itself after the configuration."

echo

while [[ -z "$PROJECT" ]]; do
  echo -n -e "\033[0;34mProject name:\033[0m "; read PROJECT
done

while [[ -z "$MODULE" ]]; do
  echo -n -e "\033[0;34mModule path:\033[0m "; read MODULE
done

echo

while [[ -z "$SQL_DIALECT" ]]; do
  echo -n -e "\033[0;34mDialect (sqlite3|mysql|postgres):\033[0m "; read SQL_DIALECT
done

case $SQL_DIALECT in
  sqlite3)  DEF_DRIVER="github.com/mattn/go-sqlite3" ;;
  mysql)    DEF_DRIVER="github.com/go-sql-driver/mysql" ;;
  postgres) DEF_DRIVER="github.com/lib/pq" ;;
esac

echo -n -e "\033[0;34mDriver ($DEF_DRIVER):\033[0m "; read SQL_DRIVER
if [ -z $SQL_DRIVER ]; then SQL_DRIVER=$DEF_DRIVER; fi

MODULE=$(echo $MODULE | sed "s#\.#\\\.#g" | sed "s#/#\\\/#g")
SQL_DRIVER=$(echo $SQL_DRIVER | sed "s#\.#\\\.#g" | sed "s#/#\\\/#g")

grep --exclude={.git,\*.sh} -rl '${PROJECT}' . | while read -r path; do
  sed -i '' -e "s/\${PROJECT}/$PROJECT/g" $path
done

grep --exclude={.git,\*.sh} -rl '${MODULE}' . | while read -r path; do
  sed -i '' -e "s/\${MODULE}/$MODULE/g" $path
done

grep --exclude={.git,\*.sh} -rl '${SQL_DIALECT}' . | while read -r path; do
  sed -i '' -e "s/\${SQL_DIALECT}/$SQL_DIALECT/g" $path
done

grep --exclude={.git,\*.sh} -rl '${SQL_DRIVER}' . | while read -r path; do
  sed -i '' -e "s/\${SQL_DRIVER}/$SQL_DRIVER/g" $path
done

echo

go mod tidy
rm pkg/.gitkeep
rm README.md
rm init.sh