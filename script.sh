API_KEY=oZ2ugqoP2vSvDiu25QZzoWLwuYEV9WEC

if [[ $1 ]] && [[ $2 ]] && [[ $3 ]]; then
    url="https://api.apilayer.com/fixer/convert?to=$3&from=$2&amount=$1"

    echo `curl -s --request GET \
         --url $url \
         --header "apikey: $API_KEY"` | \
    python3 -c "import sys, json; data = json.load(sys.stdin); query = data['query']; print(query['amount'], query['from'], 'это', data['result'], query['to'])"
elif [[ -f $1 ]]; then
   while read amount from to
   do
       url="https://api.apilayer.com/fixer/convert?to=$to&from=$from&amount=$amount"

        echo `curl -s --request GET \
             --url $url \
             --header "apikey: $API_KEY"` | \
        python3 -c "import sys, json; data = json.load(sys.stdin); query = data['query']; print(query['amount'], query['from'], 'это', data['result'], query['to'])"
   done < $1 
else
    echo "Выберите вариант использования(1 - самостоятельный ввод запроса с клавиатуры в формате 'КОЛИЧЕСТВО ВАЛЮТА_НА_ВХОД ВАЛЮТА_НА_ВЫХОД' (5000 RUB USD); 2 - указание файла со строками формата 'КОЛИЧЕСТВО ВАЛЮТА_НА_ВХОД ВАЛЮТА_НА_ВЫХОД')"
    read action

    if [[ $action -eq 1 ]]; then
        echo "Введите запрос в формате 'КОЛИЧЕСТВО ВАЛЮТА_НА_ВХОД ВАЛЮТА_НА_ВЫХОД' (5000 RUB USD)"
        read amount from to

        url="https://api.apilayer.com/fixer/convert?to=$to&from=$from&amount=$amount"
        echo `curl -s --request GET \
             --url $url \
             --header "apikey: $API_KEY"` | \
        python3 -c "import sys, json; data = json.load(sys.stdin); query = data['query']; print(query['amount'], query['from'], 'это', data['result'], query['to'])"
    else
        echo "Введите путь до файла"
        read f_path

        if [[ ! -f $f_path ]]; then
            echo "Указанного пути не существует или это не файл"
            exit 0
        fi

        while read amount from to
        do
            url="https://api.apilayer.com/fixer/convert?to=$to&from=$from&amount=$amount"
            echo `curl -s --request GET \
                 --url $url \
                 --header "apikey: $API_KEY"` | \
            python3 -c "import sys, json; data = json.load(sys.stdin); query = data['query']; print(query['amount'], query['from'], 'это', data['result'], query['to'>
        done < $f_path
    fi
fi

