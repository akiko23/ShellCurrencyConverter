API_KEY=kVQbLPfe3nLrfCR5d6v9FBxJYN5h7qRB
INPUT_FORMAT='КОЛИЧЕСТВО ВАЛЮТА_НА_ВХОД ВАЛЮТА_НА_ВЫХОД (Пример: 5000 RUB USD)'

# This function makes request on Fixer API which consists of amount, origin curency and curency that you want to receive and then returns the current rate
function convert() {
    echo "Подождите, идет запрос к АПИ.."
    url="https://api.apilayer.com/fixer/convert?to=$3&from=$2&amount=$1"
    echo `curl -s --request GET \
         --url $url \
         --header "apikey: $API_KEY"` | \
    python3 -c "import sys, json; data = json.load(sys.stdin); query = data.get('query', None); print(query['amount'], query['from'], 'это', data['result'], query['to'] + '\n') if query else print('Некорректный формат ввода. Проверьте входные данные, они должны соответствовать формату \"КОЛИЧЕСТВО ВАЛЮТА_НА_ВХОД ВАЛЮТА_НА_ВЫХОД\" (Пример: 5000 RUB USD)\n')"
}

# "how to use" instruction
if [[ $1 == '-h' ]]; then
  echo "Существует 3 варианта использования скрипта. 
  1. Вы можете сразу передать аргументы на этапе запуска формата $INPUT_FORMAT;
  2. Вы можете передать первым аргументом на этапе запуска путь до файла, который содержит строки формата $INPUT_FORMAT
  3. Вы можете запустить скрипт без аргументов и он предложит вам 2 варианта использования"
  exit 0
fi

# check for first case with 3 arguments
if [[ $1 ]] && [[ $2 ]] && [[ $3 ]]; then
    convert $1 $2 $3
    
# check for the second case with file path
elif [[ -f $1 ]]; then
   c=1
   # read file lines
   while read amount from to
   do
      # beautiful output
      echo "[INFO $c]"
      
      convert $amount $from $to
      c=$(($c+1))
   done < $1
# third case
else
    read -p "Выберите вариант использования(1 - самостоятельный ввод запроса с клавиатуры в формате $INPUT_FORMAT; 2 - указание файла со строками формата $INPUT_FORMAT): " action
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
            echo "Указанного пути не существует или это не файл"
            exit 0
        fi
	# process second case with file path
	c=1
	echo
        while read amount from to
        do
	  # beautiful output
          echo "[INFO $c]"
	  
          convert $amount $from $to
          c=$(($c+1))
        done < $f_path
    fi
fi

