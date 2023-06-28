# -*- coding: utf-8 -*-
$coins = Get-Content "coins.txt" | ForEach-Object { [int]$_ }    # Считываем номиналы монет из файла
$total_sum = Read-Host "Введите сумму для выдачи сдачи"         # Считываем сумму

$dp = [Collections.Generic.List[int]]::new()                    # Создаем массив dp
for ($i = 0; $i -le $total_sum; $i++) {
    $dp.Add([int]::MaxValue)                                     # Заполняем бесконечно большими значениями
}
$dp[0] = 0                                                      # Устанавливаем dp[0] = 0

foreach ($coin in $coins) {
    for ($curr_sum = 1; $curr_sum -le $total_sum; $curr_sum++) {
        if ($coin -le $curr_sum -and $dp[$curr_sum - $coin] + 1 -lt $dp[$curr_sum]) {
            $dp[$curr_sum] = $dp[$curr_sum - $coin] + 1           # Обновляем минимальное количество монет
        }
    }
}

$min_coins = [Collections.Generic.List[int]]::new()             # Создаем список для хранения набора монет
$curr_sum = $total_sum

while ($curr_sum -gt 0) {
    foreach ($coin in $coins) {
        if ($coin -le $curr_sum -and $dp[$curr_sum - $coin] + 1 -eq $dp[$curr_sum]) {
            $min_coins.Add($coin)                                # Добавляем текущий номинал в список
            $curr_sum -= $coin                                   # Обновляем текущую сумму
            break
        }
    }
}

Write-Host "Минимальное количество монет:" $dp[$total_sum]      # Выводим минимальное количество монет
Write-Host "Набор монет для выдачи сдачи:" $min_coins           # Выводим набор монет