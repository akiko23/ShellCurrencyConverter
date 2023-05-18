API_KEY=oZ2ugqoP2vSvDiu25QZzoWLwuYEV9WEC
INPUT_FORMAT='[сумма] [исходная_валюта] [целевая_валюта]'

# This function makes request on Fixer API which consists of amount, origin curency and curency that you want to receive and then returns the current rate
function convert() {
    echo "Подождите, ждем ответа от АПИ.."
    url="https://api.apilayer.com/fixer/convert?to=$3&from=$2&amount=$1"
    response=`curl -s --request GET \
         --url $url \
         --header "apikey: $API_KEY"`
    
    query=`echo $response | jq ".query"`
    if [[ $query == "null" || ! $query ]]; then
        echo -e "\033[0m\033[0m\033[31m[ERROR]\033[37m Некорректный ответ, проверьте ваш запрос (\033[0;33m'[$1] [$2] [$3]'\033[39m) , он должен соответствовать формату $INPUT_FORMAT)"
      exit 1
    fi
    
    result=`echo $response | jq ".result"`
    echo -e "$1 $2 это $result $3"
    echo
}

# "how to use" instruction
if [[ $1 == '-h' ]]; then
 echo " 
 -h |                                                 | вывод справки по скрипту                                                                                          |
 -f | [file_path]                                     | принять на вход путь до файла, который должен содержать строки формата $INPUT_FORMAT | Пример: ./script.sh -f currencies.txt
    | $INPUT_FORMAT      | параметры конвертации, введенные с клавиатуры                                                                     | Пример: ./script.sh 100 USD RUB 

 Также вы можете запустить скрипт без аргументов и он предложит вам 2 сценария использования"
 exit 0
fi

# check for the first case with 3 arguments
if [[ $1 ]] && [[ $2 ]] && [[ $3 ]]; then
    convert $1 $2 $3
    
# check for the second case with file path
elif [[ $1 == "-f" ]]; then
    if [[ ! $2 ]]; then
        echo -e "\033[0m\n\033[0m\033[31m[ERROR]\033[37m Вы не указали обязательный аргумент (путь до файла).\nИспользование -f: \033[32m./script.sh -f [путь/до/файла]"
        exit 2
    fi

    if [[ ! -f $2 ]]; then
        echo -e "\033[0m\n\033[0m\033[31m[ERROR]\033[37m Указанного пути не сушествует или это не файл"
        exit 3
    fi
   c=1
   # read file lines
   while read amount from to
   do
      # beautiful output
      echo -e "\033[32m[INFO $c]\033[37m"
      
      convert $amount $from $to
      c=$(($c+1))
   done < $2
# third case
else
    read -p "Выберите сценарий использования:
1 - самостоятельный ввод запроса с клавиатуры в формате $INPUT_FORMAT; 2 - указание файла со строками формата $INPUT_FORMAT): " action
    echo
    # check the selected option
    if [[ $action -eq 1 ]]; then
    	# process first case with 3 arguments
        read -p "Введите запрос в формате $INPUT_FORMAT: " amount from to
        convert $amount $from $to
    else
        read -p "Введите путь до файла: " f_path
	
	# check file existence
        if [[ ! -f $f_path ]]; then
            echo "\033[0m\n\033[0m\033[31m[ERROR]\033[37m Указанного пути не существует или это не файл"
            exit 0
        fi
	# process second case with file path
	c=1
	echo
        while read amount from to
        do
	  # beautiful output
          echo -e "\033[32m[INFO $c]\033[37m"
	  
          convert $amount $from $to
          c=$(($c+1))
        done < $f_path
    fi
fi

