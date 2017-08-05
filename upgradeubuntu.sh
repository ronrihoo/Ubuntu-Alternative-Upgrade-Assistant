#! /bin/bash

version="0.1.0"
splash="Ubuntu Alternative Upgrade Assistant v$version "
prompt="Upgrade to next version? (Y/n): "
ubuntu_versions=(
	"14.04"
	"14.10"
	"15.04"
	"15.10"
	"16.04"
	"16.10"
	"17.04"
	#"17.10"
)
ubuntu_code_names=(
	"Trusty Tahr"
	"Utopic Unicorn"
	"Vivid Vervet"
	"Wily Werewolf"
	"Xenial Xerus"
	"Yakkety Yak"
	"Zesty Zapus"
	#"Artful Aardvark"
)
ubuntu_release_dates=(
	"2014-07-24" # Trusty
	"2015-08-23" # Utopic
	"2015-04-23" # Vivid
	"2015-08-22" # Wily
	"2016-04-21" # Xenial
	"2016-08-13" # Yakkety
	"2017-04-13" # Zesty
	#"2017-08-XX" # Artful
)
ubuntu_end_of_life=(
	"2019-04-XX" # Trusty
	"2015-07-23" # Utopic
	"2016-02-04" # Vivid
	"2016-07-28" # Wily
	"2021-04-XX" # Xenial
	"2017-07-20" # Yakkety
	"2018-01-XX" # Zesty
	#"20XX-XX-XX" # Artful
)


function get_current_version_number {
	for ((i=0; i < ${#ubuntu_code_names[@]}; i++))
	do
		version=$(echo ${ubuntu_code_names[$i]} | tr '[:upper:]' '[:lower:]')
		if [[ $version == "$current_version"* ]]; then
			num=$i
			current_version_num=${ubuntu_versions[$i]}
		fi
	done
}


function get_next_version_index {
	new_versions=$((${#ubuntu_versions[@]} - num))
	if [[ $new_versions > 1 ]]; then
		next_version_index=(
			$(($num + 1))
		)
	else
		next_version_index=(
			0
		)
	fi
}


current_version=$(lsb_release -c | awk '{ printf tolower($2) }')
get_current_version_number
get_next_version_index


function splash {
	printf "$splash \n\n"
}


function print_exit_message {
	printf "\nExiting Alternative Upgrade Assistant...\n"
}


function display_current_version_info {
	printf "Current Version\n"
	printf "$current_version_num - ${ubuntu_code_names[num]} \t ${ubuntu_release_dates[num]} \t ${ubuntu_end_of_life[num]} \n\n" | expand -t 14
}


function show_menu {
	if [[ ${next_version_index[0]} > 0 ]]; then
		splash
		display_current_version_info
		
		printf "Next Version \n"
		for i in ${next_version_index[@]}
		do
			printf "${ubuntu_versions[i]} - ${ubuntu_code_names[i]} \t ${ubuntu_release_dates[i]} \t ${ubuntu_end_of_life[i]} \n" | expand -t 14
		done
		printf "\n"
		
		a=0
		while [ "$a" != "y" ] && [ "$a" != "Y" ] && [ "$a" != "n" ] && [ "$a" != "N" ]
		do
			printf "$prompt"
			read a
		done

		if [[ "$a" == "n" || "$a" == "N" ]]; then
			do_upgrade=1
		elif [[ "$a" == "y" || "$a" == "Y" ]]; then
			do_upgrade=0
		fi
	else
		do_upgrade=2
		printf "The current version is either the latest or it isn't within the scope of this script.\n"
	fi

}


function set_sources {
	printf "\nSetting up sources...\n"
	upgrade_version=$(printf ${ubuntu_code_names[$((num + 1))]} | awk '{ printf tolower($1) }')
	sed -i s/$current_version/$upgrade_version/g /etc/apt/sources.list
	printf "Upgrading from $current_version to $upgrade_version...\n"
}


function log_current_version {
	echo $current_version > ./upgradeUbuntuLog.txt
}


function preinstall_clean_up {
	apt-get clean
}


function perform_current_updates {
	printf "\nPerforming current available updates...\n"
	apt-get update && apt-get upgrade
}


function upgrade {
	if [[ do_upgrade -eq 0 ]]; then
		perform_current_updates && set_sources && log_current_version && apt-get update && apt-get dist-upgrade
	elif [[ do_upgrade -eq 1 ]]; then
		print_exit_message
	fi
}


function rollback_changes {
	# TODO: a more comprehensive roll-back method might be useful in case of an error
	printf "Rolling back changes...\n"
	sed -i s/$upgrade_version/$current_version/g /etc/apt/sources.list
}


function recover_last_version {
	# most likely a bad idea
	last_version=$(cat ./upgradeUbuntuLog.txt)
	printf "Recovering from $current_version to $last_version...\n"
	sed -i s/$current_version/$last_version/g /etc/apt/sources.list
	upgrade
}


function run {
	show_menu && upgrade
}


run
