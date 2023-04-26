API_KEY=wYLMrI9ITvgE34F3cCEBmlcSXxalHPd8

# This function makes request on Fixer API which consists of amount, origin curency and curency that you want to receive and then returns the current rate
function convert() {
    echo "Подождите, идет запрос к АПИ.."
    url="https://api.apilayer.com/fixer/convert?to=$3&from=$2&amount=$1"
    echo `curl -s --request GET \
         --url $url \
         --header "apikey: $API_KEY"` | \
    python3 -c "import sys, json; data = json.load(sys.stdin); query = data['query']; print(query['amount'], query['from'], 'это', data['result'], query['to'] + '\n')"
}

# "how to use" instruction
if [[ $1 == '-h' ]]; then
  echo ""
  exit 0
fi

if [[ $1 ]] && [[ $2 ]] && [[ $3 ]]; then
    convert $1 $2 $3
elif [[ -f $1 ]]; then
   while read amount from to
   do
      convert $amount $from $to
   done < $1 
else
    read -p "Выберите вариант использования(1 - самостоятельный ввод запроса с клавиатуры в формате 'КОЛИЧЕСТВО ВАЛЮТА_НА_ВХОД ВАЛЮТА_НА_ВЫХОД' (5000 RUB USD); 2 - указание файла со строками формата 'КОЛИЧЕСТВО ВАЛЮТА_НА_ВХОД ВАЛЮТА_НА_ВЫХОД'): " action
    echo
    if [[ $action -eq 1 ]]; then
        read -p "Введите запрос в формате 'КОЛИЧЕСТВО ВАЛЮТА_НА_ВХОД ВАЛЮТА_НА_ВЫХОД' (5000 RUB USD): " amount from to
        convert $amount $from $to
    else
        read -p "Введите путь до файла: " f_path
        if [[ ! -f $f_path ]]; then
            echo "Указанного пути не существует или это не файл"
            exit 0
        fi

        while read amount from to
        do
          convert $amount $from $to
        done < $f_path
    fi
fi

