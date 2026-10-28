#! /usr/bin/env bash

# Прочитать pid и is_focused окна niri
IFS=':' read id pid is_focused < <( niri msg -j windows | jq '.[] | select( .title | match("AmneziaVPN")) | "\(.id):\(.pid):\(.is_focused)"' -r )

if [[ ! -n "$is_focused" ]]; then
	# окон amnezia нету
	AmneziaVPN
elif [[ "$is_focused" == "false" ]]; then
	# окно не сфокусировано, но есть -- сфокусируюсь
	niri msg action focus-window --id $id
elif [[ "$is_focused" == "true" ]]; then
	# окно сфокусировано -- закрываю
	# но сначала переключусю на пред окно
	niri msg action focus-window-previous
	niri msg action close-window --id $id
else
	# не знаю когда эта ветка if выполнится,
	# но в случае если я ошибся в логике, то я увижу
	notify-send "Ошибка" "Из скрипта ~/.config/niri/focuse_throne.sh"
fi

# vim:ts=8:
