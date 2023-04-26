API_KEY=wYLMrI9ITvgE34F3cCEBmlcSXxalHPd8
INPUT_FORMAT='КОЛИЧЕСТВО ВАЛЮТА_НА_ВХОД ВАЛЮТА_НА_ВЫХОД (Пример запроса: 5000 RUB USD)'

# This function makes request on Fixer API which consists of amount, origin curency and curency that you want to receive and then returns the current rate
function convert() {
    echo "Подождите, идет запрос к АПИ.."
    url="https://api.apilayer.com/fixer/convert?to=$3&from=$2&amount=$1"
    echo `curl -s --request GET \
         --url $url \
         --header "apikey: $API_KEY"` | \
    python3 -c "import sys, json; data = json.load(sys.stdin); query = data.get('query', None); print(query['amount'], query['from'], 'это', data['result'], query['to'] + '\n') if query else print('Некорректный формат ввода. Проверьте входные данные, они должны соответствовать формату \"КОЛИЧЕСТВО ВАЛЮТА_НА_ВХОД ВАЛЮТА_НА_ВЫХОД\"\n')"
}

# "how to use" instruction
if [[ $1 == '-h' ]]; then
  echo ""
  exit 0
fi

if [[ $1 ]] && [[ $2 ]] && [[ $3 ]]; then
    convert $1 $2 $3
elif [[ -f $1 ]]; then
   c=1
   while read amount from to
   do
      echo "[INFO $c]"
      convert $amount $from $to
      c=$(($c+1))
   done < $1 
else
    read -p "Выберите вариант использования(1 - самостоятельный ввод запроса с клавиатуры в формате $INPUT_FORMAT; 2 - указание файла со строками формата 'КОЛИЧЕСТВО ВАЛЮТА_НА_ВХОД ВАЛЮТА_НА_ВЫХОД'): " action
    echo
    if [[ $action -eq 1 ]]; then
        read -p "Введите запрос в формате $INPUT_FORMAT: " amount from to
        convert $amount $from $to
    else
        read -p "Введите путь до файла: " f_path
        if [[ ! -f $f_path ]]; then
            echo "Указанного пути не существует или это не файл"
            exit 0
        fi
	c=1
	echo
        while read amount from to
        do
          echo "[INFO $c]"
          convert $amount $from $to
          c=$(($c+1))
        done < $f_path
    fi
fi

